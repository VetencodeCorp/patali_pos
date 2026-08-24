import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/repositories/sales_summary_repository.dart';
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
      title: 'Laporan Harian',
      currentIndex: 2,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tanggal',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(dateFormat.format(selectedDate)),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Pilih tanggal',
                    onPressed: () => _pickDate(context, ref, selectedDate),
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          summary.when(
            data: (data) => Column(
              children: [
                _SummaryHero(
                  label: shortDateFormat.format(data.start),
                  value: currency.format(data.totalSales),
                ),
                const SizedBox(height: 12),
                _SummaryTile(
                  icon: Icons.receipt_long,
                  title: 'Jumlah order',
                  value: '${data.orderCount}',
                ),
                _SummaryTile(
                  icon: Icons.payments,
                  title: 'Tunai',
                  value: currency.format(data.cashSales),
                ),
                _SummaryTile(
                  icon: Icons.credit_card,
                  title: 'Non-tunai',
                  value: currency.format(data.nonCashSales),
                ),
                _SummaryTile(
                  icon: Icons.trending_up,
                  title: 'Average order',
                  value: currency.format(data.averageOrderValue),
                ),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Gagal memuat laporan: $error'),
              ),
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

class _SummaryHero extends StatelessWidget {
  const _SummaryHero({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
