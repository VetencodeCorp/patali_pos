import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/repositories/app_settings_repository.dart';
import '../../../data/repositories/order_repository.dart';
import '../application/receipt_text_formatter.dart';

class ReceiptScreen extends ConsumerWidget {
  const ReceiptScreen({super.key, required this.orderId});

  static const routePath = '/orders/:orderId/receipt';

  static String location(String orderId) => '/orders/$orderId/receipt';

  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final receipt = ref.watch(orderReceiptProvider(orderId));
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final dateFormat = DateFormat('dd MMM yyyy HH:mm', 'id_ID');
    final settings = ref.watch(appSettingsProvider).valueOrNull;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Struk'),
        actions: [
          IconButton(
            tooltip: 'Cetak',
            onPressed: null,
            icon: const Icon(Icons.print),
          ),
        ],
      ),
      body: SafeArea(
        child: receipt.when(
          data: (data) {
            final manualDiscount = data.order.manualDiscountTotal;
            final promoDiscount =
                data.order.discountTotal - data.order.manualDiscountTotal;
            final thermalText = ReceiptTextFormatter().format(
              data,
              settings: settings,
            );
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        settings?.outletName ?? 'Patali Demo Outlet',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(data.order.orderNumber),
                      Text(dateFormat.format(data.order.orderedAt)),
                      if (data.customer != null)
                        Text('Pelanggan: ${data.customer!.name}'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                for (final item in data.items) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text('${item.productName} x${item.qty}')),
                      Text(currency.format(item.lineTotal)),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
                const Divider(),
                _ReceiptRow(
                  label: 'Subtotal',
                  value: currency.format(data.order.subtotal),
                ),
                if (manualDiscount > 0)
                  _ReceiptRow(
                    label: 'Diskon Manual',
                    value: '-${currency.format(manualDiscount)}',
                  ),
                if (promoDiscount > 0)
                  _ReceiptRow(
                    label: _promoReceiptLabel(data.order.promoName),
                    value: '-${currency.format(promoDiscount)}',
                  ),
                if (manualDiscount == 0 &&
                    promoDiscount <= 0 &&
                    data.order.discountTotal > 0)
                  _ReceiptRow(
                    label: 'Diskon',
                    value: '-${currency.format(data.order.discountTotal)}',
                  ),
                _ReceiptRow(
                  label: 'Pajak/Service',
                  value: currency.format(data.order.taxTotal),
                ),
                const SizedBox(height: 8),
                _ReceiptRow(
                  label: 'Total',
                  value: currency.format(data.order.grandTotal),
                  emphasized: true,
                ),
                const Divider(),
                for (final payment in data.payments)
                  _ReceiptRow(
                    label: payment.method.toUpperCase(),
                    value: currency.format(payment.amount),
                  ),
                const SizedBox(height: 20),
                Center(child: Text(settings?.receiptFooter ?? 'Terima kasih')),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Preview thermal',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Salin struk',
                      onPressed: () async {
                        await Clipboard.setData(
                          ClipboardData(text: thermalText),
                        );
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Struk disalin')),
                        );
                      },
                      icon: const Icon(Icons.copy),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(color: const Color(0xFFE0E5E1)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    thermalText,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      height: 1.25,
                    ),
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Gagal memuat struk: $error'),
            ),
          ),
        ),
      ),
    );
  }
}

String _promoReceiptLabel(String? promoName) {
  final name = promoName?.trim();
  if (name == null || name.isEmpty) return 'Promo';
  return 'Promo: $name';
}

class _ReceiptRow extends StatelessWidget {
  const _ReceiptRow({
    required this.label,
    required this.value,
    this.emphasized = false,
  });

  final String label;
  final String value;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final style = emphasized
        ? Theme.of(context).textTheme.titleMedium
        : Theme.of(context).textTheme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }
}
