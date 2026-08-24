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
    String paymentMethod = 'cash',
    required int subtotal,
    required int discountTotal,
    required int grandTotal,
  }) async {
    if (items.isEmpty) {
      throw StateError('Cart kosong');
    }

    final now = DateTime.now();
    final orderId = _uuid.v4();
    final orderNumber = _buildOrderNumber(now);
    final paymentId = _uuid.v4();

    return _database.transaction(() async {
      await _database
          .into(_database.orders)
          .insert(
            OrdersCompanion.insert(
              id: orderId,
              cashSessionId: Value(cashSessionId),
              cashierUserId: const Value(devOwnerUserId),
              orderNumber: orderNumber,
              subtotal: Value(subtotal),
              discountTotal: Value(discountTotal),
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
                'payment_method': paymentMethod,
                'subtotal': subtotal,
                'discount_total': discountTotal,
                'grand_total': grandTotal,
              }),
            ),
          );

      return (_database.select(
        _database.orders,
      )..where((order) => order.id.equals(orderId))).getSingle();
    });
  }

  String _buildOrderNumber(DateTime value) {
    final stamp =
        '${value.year}'
        '${value.month.toString().padLeft(2, '0')}'
        '${value.day.toString().padLeft(2, '0')}'
        '-'
        '${value.hour.toString().padLeft(2, '0')}'
        '${value.minute.toString().padLeft(2, '0')}'
        '${value.second.toString().padLeft(2, '0')}';
    return 'INV-$stamp';
  }
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
