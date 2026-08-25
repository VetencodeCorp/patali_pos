import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';

final salesSummaryRepositoryProvider = Provider<SalesSummaryRepository>((ref) {
  return SalesSummaryRepository(ref.watch(appDatabaseProvider));
});

final selectedSalesDateProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

final dailySalesSummaryProvider = FutureProvider<SalesSummary>((ref) {
  final date = ref.watch(selectedSalesDateProvider);
  return ref.watch(salesSummaryRepositoryProvider).getDailySummary(date);
});

final selectedProductSalesDateProvider = StateProvider<DateTime?>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

final productSalesProvider = FutureProvider<List<ProductSalesItem>>((ref) {
  final date = ref.watch(selectedProductSalesDateProvider);
  return ref.watch(salesSummaryRepositoryProvider).getProductSales(date: date);
});

class SalesSummaryRepository {
  SalesSummaryRepository(this._database);

  final AppDatabase _database;

  Future<SalesSummary> getDailySummary(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return getSummary(start: start, end: end);
  }

  Future<SalesSummary> getSummary({
    required DateTime start,
    required DateTime end,
  }) async {
    final orders =
        await (_database.select(_database.orders)..where((order) {
              return order.orderedAt.isBiggerOrEqualValue(start) &
                  order.orderedAt.isSmallerThanValue(end) &
                  order.status.equals('completed');
            }))
            .get();
    final orderIds = orders.map((order) => order.id).toList();
    final payments = orderIds.isEmpty
        ? <Payment>[]
        : await (_database.select(
            _database.payments,
          )..where((payment) => payment.orderId.isIn(orderIds))).get();

    final totalSales = orders.fold<int>(
      0,
      (total, order) => total + order.grandTotal,
    );
    final cashSales = payments
        .where((payment) => payment.method == 'cash')
        .fold<int>(0, (total, payment) => total + payment.amount);
    final nonCashSales = payments
        .where((payment) => payment.method != 'cash')
        .fold<int>(0, (total, payment) => total + payment.amount);
    final discountTotal = orders.fold<int>(
      0,
      (total, order) => total + order.discountTotal,
    );
    var manualDiscountTotal = 0;
    final promoMap = <String, _PromoDiscountAccumulator>{};
    for (final order in orders) {
      final promoName = order.promoName?.trim();
      final hasPromo = promoName != null && promoName.isNotEmpty;
      final manualDiscount = hasPromo
          ? order.manualDiscountTotal.clamp(0, order.discountTotal)
          : order.discountTotal;
      final promoDiscount = hasPromo
          ? (order.discountTotal - manualDiscount).clamp(0, order.discountTotal)
          : 0;
      manualDiscountTotal += manualDiscount;
      if (!hasPromo || promoDiscount <= 0) continue;
      promoMap.putIfAbsent(
        promoName,
        () => _PromoDiscountAccumulator(promoName),
      );
      promoMap[promoName]!
        ..orderCount += 1
        ..discountTotal += promoDiscount;
    }
    final promoDiscounts =
        [
          for (final promo in promoMap.values)
            PromoDiscountItem(
              promoName: promo.promoName,
              orderCount: promo.orderCount,
              discountTotal: promo.discountTotal,
            ),
        ]..sort((a, b) {
          final discountCompare = b.discountTotal.compareTo(a.discountTotal);
          if (discountCompare != 0) return discountCompare;
          return b.orderCount.compareTo(a.orderCount);
        });
    final promoDiscountTotal = promoDiscounts.fold<int>(
      0,
      (total, promo) => total + promo.discountTotal,
    );

    return SalesSummary(
      start: start,
      end: end,
      totalSales: totalSales,
      cashSales: cashSales,
      nonCashSales: nonCashSales,
      discountTotal: discountTotal,
      manualDiscountTotal: manualDiscountTotal,
      promoDiscountTotal: promoDiscountTotal,
      promoDiscounts: promoDiscounts,
      orderCount: orders.length,
    );
  }

  Future<List<ProductSalesItem>> getProductSales({DateTime? date}) async {
    final ordersQuery = _database.select(_database.orders)
      ..where((order) => order.status.equals('completed'));
    if (date != null) {
      final start = DateTime(date.year, date.month, date.day);
      final end = start.add(const Duration(days: 1));
      ordersQuery.where(
        (order) =>
            order.orderedAt.isBiggerOrEqualValue(start) &
            order.orderedAt.isSmallerThanValue(end),
      );
    }

    final orders = await ordersQuery.get();
    final orderIds = orders.map((order) => order.id).toList();
    if (orderIds.isEmpty) return const [];

    final items = await (_database.select(
      _database.orderItems,
    )..where((item) => item.orderId.isIn(orderIds))).get();
    final grouped = <String, _ProductSalesAccumulator>{};

    for (final item in items) {
      final key = item.productId ?? item.productName;
      grouped.putIfAbsent(
        key,
        () => _ProductSalesAccumulator(
          productId: item.productId,
          productName: item.productName,
        ),
      );
      grouped[key]!
        ..qty += item.qty
        ..sales += item.lineTotal
        ..orderIds.add(item.orderId);
    }

    final result =
        [
          for (final item in grouped.values)
            ProductSalesItem(
              productId: item.productId,
              productName: item.productName,
              qty: item.qty,
              sales: item.sales,
              orderCount: item.orderIds.length,
            ),
        ]..sort((a, b) {
          final qtyCompare = b.qty.compareTo(a.qty);
          if (qtyCompare != 0) return qtyCompare;
          return b.sales.compareTo(a.sales);
        });

    return result;
  }
}

class SalesSummary {
  const SalesSummary({
    required this.start,
    required this.end,
    required this.totalSales,
    required this.cashSales,
    required this.nonCashSales,
    required this.discountTotal,
    required this.manualDiscountTotal,
    required this.promoDiscountTotal,
    required this.promoDiscounts,
    required this.orderCount,
  });

  final DateTime start;
  final DateTime end;
  final int totalSales;
  final int cashSales;
  final int nonCashSales;
  final int discountTotal;
  final int manualDiscountTotal;
  final int promoDiscountTotal;
  final List<PromoDiscountItem> promoDiscounts;
  final int orderCount;

  int get averageOrderValue => orderCount == 0 ? 0 : totalSales ~/ orderCount;
}

class PromoDiscountItem {
  const PromoDiscountItem({
    required this.promoName,
    required this.orderCount,
    required this.discountTotal,
  });

  final String promoName;
  final int orderCount;
  final int discountTotal;
}

class ProductSalesItem {
  const ProductSalesItem({
    required this.productId,
    required this.productName,
    required this.qty,
    required this.sales,
    required this.orderCount,
  });

  final String? productId;
  final String productName;
  final int qty;
  final int sales;
  final int orderCount;
}

class _ProductSalesAccumulator {
  _ProductSalesAccumulator({
    required this.productId,
    required this.productName,
  });

  final String? productId;
  final String productName;
  final Set<String> orderIds = {};
  int qty = 0;
  int sales = 0;
}

class _PromoDiscountAccumulator {
  _PromoDiscountAccumulator(this.promoName);

  final String promoName;
  int orderCount = 0;
  int discountTotal = 0;
}
