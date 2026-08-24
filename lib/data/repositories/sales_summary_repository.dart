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

    return SalesSummary(
      start: start,
      end: end,
      totalSales: totalSales,
      cashSales: cashSales,
      nonCashSales: nonCashSales,
      orderCount: orders.length,
    );
  }
}

class SalesSummary {
  const SalesSummary({
    required this.start,
    required this.end,
    required this.totalSales,
    required this.cashSales,
    required this.nonCashSales,
    required this.orderCount,
  });

  final DateTime start;
  final DateTime end;
  final int totalSales;
  final int cashSales;
  final int nonCashSales;
  final int orderCount;

  int get averageOrderValue => orderCount == 0 ? 0 : totalSales ~/ orderCount;
}
