import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/repositories/order_repository.dart';
import 'receipt_screen.dart';
import '../../../shared/widgets/patali_shell.dart';

class OrderHistoryScreen extends ConsumerWidget {
  const OrderHistoryScreen({super.key});

  static const routePath = '/orders';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(recentOrdersProvider);
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final dateFormat = DateFormat('dd MMM yyyy HH:mm', 'id_ID');

    return PataliShell(
      title: 'Riwayat Order',
      currentIndex: 1,
      child: orders.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('Belum ada transaksi'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final order = items[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.receipt_long),
                  title: Text(order.orderNumber),
                  subtitle: Text(dateFormat.format(order.orderedAt)),
                  trailing: Text(currency.format(order.grandTotal)),
                  onTap: () => context.push(ReceiptScreen.location(order.id)),
                ),
              );
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
    );
  }
}
