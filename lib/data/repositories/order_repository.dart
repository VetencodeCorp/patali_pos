import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';
import 'cash_session_repository.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(ref.watch(appDatabaseProvider));
});

final recentOrdersProvider = StreamProvider<List<Order>>((ref) {
  return ref.watch(orderRepositoryProvider).watchRecentOrders();
});

final orderHistoryDateProvider = StateProvider<DateTime?>((ref) => null);

final orderHistoryPaymentMethodProvider = StateProvider<String?>((ref) => null);

final orderHistoryItemsProvider = StreamProvider<List<OrderListItem>>((ref) {
  final date = ref.watch(orderHistoryDateProvider);
  final paymentMethod = ref.watch(orderHistoryPaymentMethodProvider);
  return ref
      .watch(orderRepositoryProvider)
      .watchOrderHistory(date: date, paymentMethod: paymentMethod);
});

final orderReceiptProvider = FutureProvider.family<OrderReceipt, String>((
  ref,
  orderId,
) {
  return ref.watch(orderRepositoryProvider).getReceipt(orderId);
});

class OrderRepository {
  OrderRepository(this._database);

  final AppDatabase _database;
  final Uuid _uuid = const Uuid();

  Stream<List<Order>> watchRecentOrders() {
    final query = _database.select(_database.orders)
      ..orderBy([(order) => OrderingTerm.desc(order.orderedAt)])
      ..limit(50);

    return query.watch();
  }

  Stream<List<OrderListItem>> watchOrderHistory({
    DateTime? date,
    String? paymentMethod,
  }) {
    final query = _database.select(_database.orders).join([
      leftOuterJoin(
        _database.payments,
        _database.payments.orderId.equalsExp(_database.orders.id),
      ),
    ]);

    if (date != null) {
      final start = DateTime(date.year, date.month, date.day);
      final end = start.add(const Duration(days: 1));
      query.where(
        _database.orders.orderedAt.isBiggerOrEqualValue(start) &
            _database.orders.orderedAt.isSmallerThanValue(end),
      );
    }

    if (paymentMethod != null) {
      query.where(_database.payments.method.equals(paymentMethod));
    }

    query
      ..orderBy([OrderingTerm.desc(_database.orders.orderedAt)])
      ..limit(50);

    return query.watch().map((rows) {
      return [
        for (final row in rows)
          OrderListItem(
            order: row.readTable(_database.orders),
            payment: row.readTableOrNull(_database.payments),
          ),
      ];
    });
  }

  Future<OrderReceipt> getReceipt(String orderId) async {
    final order = await (_database.select(
      _database.orders,
    )..where((order) => order.id.equals(orderId))).getSingle();
    final items = await (_database.select(
      _database.orderItems,
    )..where((item) => item.orderId.equals(orderId))).get();
    final payments = await (_database.select(
      _database.payments,
    )..where((payment) => payment.orderId.equals(orderId))).get();

    return OrderReceipt(order: order, items: items, payments: payments);
  }

  Future<Order> createCashOrder({
    required List<CreateOrderItem> items,
    required String cashSessionId,
    String? customerId,
    String orderType = 'takeaway',
    String paymentMethod = 'cash',
    String invoicePrefix = 'INV',
    bool resetInvoiceDaily = true,
    required int subtotal,
    required int discountTotal,
    int taxTotal = 0,
    required int grandTotal,
  }) async {
    if (items.isEmpty) {
      throw StateError('Cart kosong');
    }

    final now = DateTime.now();
    final orderId = _uuid.v4();
    final paymentId = _uuid.v4();

    return _database.transaction(() async {
      final orderNumber = await _buildOrderNumber(
        now,
        prefix: invoicePrefix,
        resetDaily: resetInvoiceDaily,
      );
      await _decreaseTrackedStock(items, now);

      await _database
          .into(_database.orders)
          .insert(
            OrdersCompanion.insert(
              id: orderId,
              cashSessionId: Value(cashSessionId),
              cashierUserId: const Value(devOwnerUserId),
              customerId: Value(customerId),
              orderNumber: orderNumber,
              orderType: Value(orderType),
              subtotal: Value(subtotal),
              discountTotal: Value(discountTotal),
              taxTotal: Value(taxTotal),
              grandTotal: Value(grandTotal),
              orderedAt: now,
            ),
          );

      await _database.batch((batch) {
        batch.insertAll(_database.orderItems, [
          for (final item in items)
            OrderItemsCompanion.insert(
              id: _uuid.v4(),
              orderId: orderId,
              productId: Value(item.productId),
              productName: item.productName,
              qty: item.qty,
              unitPrice: item.unitPrice,
              lineTotal: item.lineTotal,
            ),
        ]);
      });

      await _database
          .into(_database.payments)
          .insert(
            PaymentsCompanion.insert(
              id: paymentId,
              orderId: orderId,
              method: paymentMethod,
              amount: grandTotal,
              paidAt: now,
            ),
          );

      await _database
          .into(_database.syncQueue)
          .insert(
            SyncQueueCompanion.insert(
              id: _uuid.v4(),
              entityType: 'order',
              entityId: orderId,
              action: 'create',
              payloadJson: jsonEncode({
                'order_id': orderId,
                'order_number': orderNumber,
                'cash_session_id': cashSessionId,
                'customer_id': customerId,
                'order_type': orderType,
                'payment_method': paymentMethod,
                'subtotal': subtotal,
                'discount_total': discountTotal,
                'tax_total': taxTotal,
                'grand_total': grandTotal,
              }),
            ),
          );

      return (_database.select(
        _database.orders,
      )..where((order) => order.id.equals(orderId))).getSingle();
    });
  }

  Future<void> voidOrder(String orderId, {String? reason}) async {
    final now = DateTime.now();
    final order = await (_database.select(
      _database.orders,
    )..where((order) => order.id.equals(orderId))).getSingle();
    if (order.status == 'voided') return;
    if (order.status != 'completed') {
      throw StateError('Order tidak bisa dibatalkan');
    }

    await _database.transaction(() async {
      await (_database.update(
        _database.orders,
      )..where((order) => order.id.equals(orderId))).write(
        OrdersCompanion(
          status: const Value('voided'),
          note: reason == null || reason.trim().isEmpty
              ? const Value.absent()
              : Value(reason.trim()),
          updatedAt: Value(now),
        ),
      );

      await (_database.update(
        _database.payments,
      )..where((payment) => payment.orderId.equals(orderId))).write(
        PaymentsCompanion(status: const Value('voided'), updatedAt: Value(now)),
      );

      await _restoreTrackedStock(orderId, now);

      await _database
          .into(_database.syncQueue)
          .insert(
            SyncQueueCompanion.insert(
              id: _uuid.v4(),
              entityType: 'order',
              entityId: orderId,
              action: 'void',
              payloadJson: jsonEncode({
                'order_id': orderId,
                'order_number': order.orderNumber,
                'reason': reason?.trim(),
                'voided_at': now.toIso8601String(),
              }),
            ),
          );
    });
  }

  Future<void> _decreaseTrackedStock(
    List<CreateOrderItem> items,
    DateTime now,
  ) async {
    for (final item in items) {
      final productId = item.productId;
      final product = await (_database.select(
        _database.products,
      )..where((product) => product.id.equals(productId))).getSingleOrNull();
      if (product == null || !product.trackStock) continue;
      if (product.stockQty < item.qty) {
        throw StateError('Stok ${product.name} tidak cukup');
      }

      await (_database.update(
        _database.products,
      )..where((product) => product.id.equals(productId))).write(
        ProductsCompanion(
          stockQty: Value(product.stockQty - item.qty),
          updatedAt: Value(now),
        ),
      );
    }
  }

  Future<void> _restoreTrackedStock(String orderId, DateTime now) async {
    final items = await (_database.select(
      _database.orderItems,
    )..where((item) => item.orderId.equals(orderId))).get();

    for (final item in items) {
      final productId = item.productId;
      if (productId == null) continue;
      final product = await (_database.select(
        _database.products,
      )..where((product) => product.id.equals(productId))).getSingleOrNull();
      if (product == null || !product.trackStock) continue;

      await (_database.update(
        _database.products,
      )..where((product) => product.id.equals(productId))).write(
        ProductsCompanion(
          stockQty: Value(product.stockQty + item.qty),
          updatedAt: Value(now),
        ),
      );
    }
  }

  Future<String> _buildOrderNumber(
    DateTime value, {
    required String prefix,
    required bool resetDaily,
  }) async {
    final safePrefix = prefix.trim().toUpperCase().isEmpty
        ? 'INV'
        : prefix.trim().toUpperCase();
    final dayStamp =
        '${value.year}'
        '${value.month.toString().padLeft(2, '0')}'
        '${value.day.toString().padLeft(2, '0')}';
    final countQuery = _database.selectOnly(_database.orders)
      ..addColumns([_database.orders.id.count()]);

    if (resetDaily) {
      final start = DateTime(value.year, value.month, value.day);
      final end = start.add(const Duration(days: 1));
      countQuery.where(
        _database.orders.orderedAt.isBiggerOrEqualValue(start) &
            _database.orders.orderedAt.isSmallerThanValue(end) &
            _database.orders.orderNumber.like('$safePrefix-$dayStamp-%'),
      );
    } else {
      countQuery.where(_database.orders.orderNumber.like('$safePrefix-%'));
    }

    final count = await countQuery
        .map((row) => row.read(_database.orders.id.count()) ?? 0)
        .getSingle();
    final sequence = (count + 1).toString().padLeft(4, '0');
    if (resetDaily) return '$safePrefix-$dayStamp-$sequence';
    return '$safePrefix-$sequence';
  }
}

class OrderListItem {
  const OrderListItem({required this.order, required this.payment});

  final Order order;
  final Payment? payment;
}

class OrderReceipt {
  const OrderReceipt({
    required this.order,
    required this.items,
    required this.payments,
  });

  final Order order;
  final List<OrderItem> items;
  final List<Payment> payments;
}

class CreateOrderItem {
  const CreateOrderItem({
    required this.productId,
    required this.productName,
    required this.qty,
    required this.unitPrice,
    required this.lineTotal,
  });

  final String productId;
  final String productName;
  final int qty;
  final int unitPrice;
  final int lineTotal;
}
