import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/repositories/order_repository.dart';
import '../../../shared/widgets/patali_shell.dart';
import 'receipt_screen.dart';

class OrderHistoryScreen extends ConsumerWidget {
  const OrderHistoryScreen({super.key});

  static const routePath = '/orders';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderHistoryItemsProvider);
    final selectedDate = ref.watch(orderHistoryDateProvider);
    final selectedPayment = ref.watch(orderHistoryPaymentMethodProvider);

    return PataliShell(
      title: 'Riwayat Order',
      currentIndex: 1,
      child: Column(
        children: [
          _OrderHistoryFilters(
            selectedDate: selectedDate,
            selectedPayment: selectedPayment,
          ),
          Expanded(
            child: orders.when(
              data: (items) {
                if (items.isEmpty) {
                  return const Center(child: Text('Belum ada transaksi'));
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return _OrderHistoryTile(item: items[index]);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text('Gagal memuat riwayat: $error'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderHistoryFilters extends ConsumerWidget {
  const _OrderHistoryFilters({
    required this.selectedDate,
    required this.selectedPayment,
  });

  final DateTime? selectedDate;
  final String? selectedPayment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Semua tanggal'),
                selected: selectedDate == null,
                onSelected: (_) {
                  ref.read(orderHistoryDateProvider.notifier).state = null;
                },
              ),
              ChoiceChip(
                label: const Text('Hari ini'),
                selected: selectedDate != null,
                onSelected: (_) {
                  ref.read(orderHistoryDateProvider.notifier).state =
                      normalizedToday;
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Semua metode'),
                selected: selectedPayment == null,
                onSelected: (_) {
                  ref.read(orderHistoryPaymentMethodProvider.notifier).state =
                      null;
                },
              ),
              for (final method in _paymentMethods)
                ChoiceChip(
                  avatar: Icon(method.icon, size: 17),
                  label: Text(method.label),
                  selected: selectedPayment == method.code,
                  onSelected: (_) {
                    ref.read(orderHistoryPaymentMethodProvider.notifier).state =
                        method.code;
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderHistoryTile extends ConsumerWidget {
  const _OrderHistoryTile({required this.item});

  final OrderListItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = item.order;
    final payment = item.payment;
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final dateFormat = DateFormat('dd MMM yyyy HH:mm', 'id_ID');
    final paymentLabel = _paymentLabel(payment?.method);

    return Card(
      child: ListTile(
        leading: Icon(_paymentIcon(payment?.method)),
        title: Text(order.orderNumber),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Wrap(
            spacing: 8,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(dateFormat.format(order.orderedAt)),
              _HistoryBadge(label: paymentLabel),
              _HistoryBadge(label: order.status),
            ],
          ),
        ),
        trailing: SizedBox(
          width: 132,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  currency.format(order.grandTotal),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              if (order.status == 'completed')
                PopupMenuButton<String>(
                  tooltip: 'Aksi transaksi',
                  onSelected: (value) async {
                    if (value != 'void') return;
                    await _confirmVoidOrder(context, ref, order.id);
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: 'void',
                      child: ListTile(
                        leading: Icon(Icons.cancel_outlined),
                        title: Text('Batalkan'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        onTap: () => context.push(ReceiptScreen.location(order.id)),
      ),
    );
  }

  Future<void> _confirmVoidOrder(
    BuildContext context,
    WidgetRef ref,
    String orderId,
  ) async {
    final reason = await showDialog<String>(
      context: context,
      builder: (context) => const _VoidOrderDialog(),
    );

    if (reason == null) return;
    if (!context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(orderRepositoryProvider)
          .voidOrder(orderId, reason: reason);
      messenger.showSnackBar(
        const SnackBar(content: Text('Transaksi dibatalkan')),
      );
    } catch (error) {
      messenger.showSnackBar(
        SnackBar(content: Text('Gagal membatalkan: $error')),
      );
    }
  }
}

class _VoidOrderDialog extends StatefulWidget {
  const _VoidOrderDialog();

  @override
  State<_VoidOrderDialog> createState() => _VoidOrderDialogState();
}

class _VoidOrderDialogState extends State<_VoidOrderDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Batalkan transaksi'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Alasan',
          hintText: 'Salah input, pesanan batal, dll',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: const Text('Batalkan transaksi'),
        ),
      ],
    );
  }
}

class _HistoryBadge extends StatelessWidget {
  const _HistoryBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFE8F7F1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        child: Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

const _paymentMethods = [
  _PaymentMethod('cash', 'Tunai', Icons.payments_outlined),
  _PaymentMethod('qris', 'QRIS', Icons.qr_code_2),
  _PaymentMethod('debit', 'Debit', Icons.credit_card),
  _PaymentMethod('transfer', 'Transfer', Icons.account_balance),
];

class _PaymentMethod {
  const _PaymentMethod(this.code, this.label, this.icon);

  final String code;
  final String label;
  final IconData icon;
}

String _paymentLabel(String? method) {
  return switch (method) {
    'cash' => 'Tunai',
    'qris' => 'QRIS',
    'debit' => 'Debit',
    'transfer' => 'Transfer',
    _ => 'Belum dibayar',
  };
}

IconData _paymentIcon(String? method) {
  return switch (method) {
    'cash' => Icons.payments_outlined,
    'qris' => Icons.qr_code_2,
    'debit' => Icons.credit_card,
    'transfer' => Icons.account_balance,
    _ => Icons.receipt_long,
  };
}
