import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/repositories/sales_summary_repository.dart';
import '../../../shared/widgets/patali_card.dart';
import '../../../shared/widgets/patali_shell.dart';

class ProductSalesScreen extends ConsumerWidget {
  const ProductSalesScreen({super.key});

  static const routePath = '/reports/product-sales';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedProductSalesDateProvider);
    final productSales = ref.watch(productSalesProvider);
    final dateFormat = DateFormat('EEEE, dd MMM yyyy', 'id_ID');
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return PataliShell(
      title: 'Produk Terjual',
      currentIndex: 2,
      actions: [
        IconButton(
          tooltip: 'Pilih tanggal',
          onPressed: selectedDate == null
              ? null
              : () => _pickDate(context, ref, selectedDate),
          icon: const Icon(Icons.calendar_month_outlined),
        ),
      ],
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          PataliCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.softMint,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.inventory_2_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Periode laporan',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            selectedDate == null
                                ? 'Semua tanggal'
                                : dateFormat.format(selectedDate),
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('Hari ini'),
                      selected: selectedDate != null,
                      onSelected: (_) {
                        final now = DateTime.now();
                        ref
                            .read(selectedProductSalesDateProvider.notifier)
                            .state = DateTime(
                          now.year,
                          now.month,
                          now.day,
                        );
                      },
                    ),
                    ChoiceChip(
                      label: const Text('Semua'),
                      selected: selectedDate == null,
                      onSelected: (_) {
                        ref
                                .read(selectedProductSalesDateProvider.notifier)
                                .state =
                            null;
                      },
                    ),
                    if (selectedDate != null)
                      ActionChip(
                        avatar: const Icon(Icons.tune, size: 17),
                        label: const Text('Ganti tanggal'),
                        onPressed: () => _pickDate(context, ref, selectedDate),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          productSales.when(
            data: (items) {
              final totalQty = items.fold<int>(
                0,
                (sum, item) => sum + item.qty,
              );
              final totalSales = items.fold<int>(
                0,
                (sum, item) => sum + item.sales,
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final twoColumns = constraints.maxWidth >= 560;
                      return GridView.count(
                        crossAxisCount: twoColumns ? 2 : 1,
                        childAspectRatio: twoColumns ? 2.75 : 3.2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: [
                          _MetricCard(
                            icon: Icons.shopping_bag_outlined,
                            title: 'Qty terjual',
                            value: '$totalQty item',
                            tint: AppColors.softMint,
                          ),
                          _MetricCard(
                            icon: Icons.payments_outlined,
                            title: 'Omzet produk',
                            value: currency.format(totalSales),
                            tint: AppColors.lavender,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  if (items.isEmpty)
                    const _EmptyProductSales()
                  else
                    for (final (index, item) in items.indexed) ...[
                      _ProductSalesRow(
                        rank: index + 1,
                        item: item,
                        currency: currency,
                      ),
                      const SizedBox(height: 8),
                    ],
                ],
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stackTrace) => Padding(
              padding: const EdgeInsets.all(24),
              child: Center(child: Text('Gagal memuat produk terjual: $error')),
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
    ref.read(selectedProductSalesDateProvider.notifier).state = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
    );
  }
}

class _ProductSalesRow extends StatelessWidget {
  const _ProductSalesRow({
    required this.rank,
    required this.item,
    required this.currency,
  });

  final int rank;
  final ProductSalesItem item;
  final NumberFormat currency;

  @override
  Widget build(BuildContext context) {
    return PataliCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: rank <= 3 ? const Color(0xFFFFF2DA) : AppColors.softMint,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                '#$rank',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.qty} item - ${item.orderCount} transaksi',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            currency.format(item.sales),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ],
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

class _EmptyProductSales extends StatelessWidget {
  const _EmptyProductSales();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 46),
      child: Column(
        children: [
          Container(
            width: 118,
            height: 118,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.softMint, AppColors.lavender],
              ),
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              color: AppColors.primary,
              size: 52,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Belum Ada Produk Terjual',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          const Text(
            'Produk dari transaksi selesai akan muncul di sini.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
