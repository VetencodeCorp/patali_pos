import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/repositories/sales_summary_repository.dart';
import '../../../shared/widgets/patali_card.dart';
import '../../../shared/widgets/patali_shell.dart';

class SalesSummaryScreen extends ConsumerWidget {
  const SalesSummaryScreen({super.key});

  static const routePath = '/reports/sales-summary';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedSalesDateProvider);
    final summary = ref.watch(dailySalesSummaryProvider);
    final dateFormat = DateFormat('EEEE, dd MMM yyyy', 'id_ID');
    final shortDateFormat = DateFormat('dd MMM yyyy', 'id_ID');
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return PataliShell(
      title: 'Ringkasan Penjualan',
      currentIndex: 2,
      actions: [
        IconButton(
          tooltip: 'Pilih tanggal',
          onPressed: () => _pickDate(context, ref, selectedDate),
          icon: const Icon(Icons.calendar_month_outlined),
        ),
      ],
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          PataliCard(
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.softMint,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tanggal laporan',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dateFormat.format(selectedDate),
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Pilih tanggal',
                  onPressed: () => _pickDate(context, ref, selectedDate),
                  icon: const Icon(Icons.tune),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          summary.when(
            data: (data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SalesHero(
                    label: shortDateFormat.format(data.start),
                    value: currency.format(data.totalSales),
                    orderCount: data.orderCount,
                    averageOrder: currency.format(data.averageOrderValue),
                  ),
                  const SizedBox(height: 14),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final twoColumns = constraints.maxWidth >= 560;
                      return GridView.count(
                        crossAxisCount: twoColumns ? 2 : 1,
                        childAspectRatio: twoColumns ? 2.55 : 3.2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: [
                          _MetricCard(
                            icon: Icons.payments_outlined,
                            title: 'Tunai',
                            value: currency.format(data.cashSales),
                            tint: AppColors.softMint,
                          ),
                          _MetricCard(
                            icon: Icons.credit_card,
                            title: 'Non-tunai',
                            value: currency.format(data.nonCashSales),
                            tint: AppColors.lavender,
                          ),
                          _MetricCard(
                            icon: Icons.receipt_long_outlined,
                            title: 'Total transaksi',
                            value: '${data.orderCount}',
                            tint: const Color(0xFFFFF2DA),
                          ),
                          _MetricCard(
                            icon: Icons.trending_up,
                            title: 'Average order',
                            value: currency.format(data.averageOrderValue),
                            tint: const Color(0xFFEAF3FF),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stackTrace) => Padding(
              padding: const EdgeInsets.all(24),
              child: Center(child: Text('Gagal memuat laporan: $error')),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate(
    BuildContext context,
    WidgetRef ref,
    DateTime selectedDate,
  ) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate == null) return;
    ref.read(selectedSalesDateProvider.notifier).state = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
    );
  }
}

class _SalesHero extends StatelessWidget {
  const _SalesHero({
    required this.label,
    required this.value,
    required this.orderCount,
    required this.averageOrder,
  });

  final String label;
  final String value;
  final int orderCount;
  final String averageOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryDark, AppColors.primary],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _HeroPill(label: '$orderCount transaksi'),
              _HeroPill(label: 'Rata-rata $averageOrder'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  const _HeroPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.tint,
  });

  final IconData icon;
  final String title;
  final String value;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return PataliCard(
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
