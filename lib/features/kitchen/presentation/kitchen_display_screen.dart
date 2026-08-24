import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/order_repository.dart';
import '../../../shared/widgets/patali_card.dart';
import '../../../shared/widgets/patali_shell.dart';

class KitchenDisplayScreen extends ConsumerWidget {
  const KitchenDisplayScreen({super.key});

  static const routePath = '/kitchen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(kitchenOrdersProvider);

    return PataliShell(
      title: 'Dapur',
      currentIndex: 4,
      child: orders.when(
        data: (items) {
          if (items.isEmpty) {
            return const _KitchenEmptyState();
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 920;
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: wide ? 2 : 1,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: wide ? 1.4 : 1.05,
                ),
                itemBuilder: (context, index) {
                  return _KitchenOrderCard(order: items[index]);
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Gagal memuat dapur: $error')),
      ),
    );
  }
}

class _KitchenOrderCard extends ConsumerWidget {
  const _KitchenOrderCard({required this.order});

  final KitchenOrder order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = DateFormat('HH:mm', 'id_ID').format(order.order.orderedAt);
    final readyCount = order.items
        .where((item) => item.kitchenStatus == 'ready')
        .length;
    final servedCount = order.items
        .where((item) => item.kitchenStatus == 'served')
        .length;

    return PataliCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.softMint,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.restaurant_menu,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.order.orderNumber,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$time - ${_orderTypeLabel(order.order.orderType)}',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              _ProgressBadge(
                label: '$readyCount siap / $servedCount selesai',
                color: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: order.items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = order.items[index];
                return _KitchenItemTile(
                  item: item,
                  onStatusChanged: (status) async {
                    try {
                      await ref
                          .read(orderRepositoryProvider)
                          .updateKitchenStatus(
                            orderItemId: item.id,
                            status: status,
                          );
                    } catch (error) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Gagal update status dapur: $error'),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _KitchenItemTile extends StatelessWidget {
  const _KitchenItemTile({required this.item, required this.onStatusChanged});

  final OrderItem item;
  final ValueChanged<String> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    final status = item.kitchenStatus;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FBF8),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(color: AppColors.border),
                ),
                child: Center(
                  child: Text(
                    '${item.qty}x',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  item.productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              _StatusBadge(status: status),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _StatusActionChip(
                label: 'Proses',
                active: status == 'preparing',
                enabled: status == 'pending',
                onTap: () => onStatusChanged('preparing'),
              ),
              _StatusActionChip(
                label: 'Siap',
                active: status == 'ready',
                enabled: status == 'pending' || status == 'preparing',
                onTap: () => onStatusChanged('ready'),
              ),
              _StatusActionChip(
                label: 'Selesai',
                active: status == 'served',
                enabled: status != 'served',
                onTap: () => onStatusChanged('served'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusActionChip extends StatelessWidget {
  const _StatusActionChip({
    required this.label,
    required this.active,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final bool active;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      onPressed: enabled ? onTap : null,
      backgroundColor: active ? AppColors.softMint : AppColors.surface,
      side: BorderSide(color: active ? AppColors.primary : AppColors.border),
      labelStyle: TextStyle(
        color: active ? AppColors.primary : AppColors.textPrimary,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return _ProgressBadge(
      label: _statusLabel(status),
      color: _statusColor(status),
    );
  }
}

class _ProgressBadge extends StatelessWidget {
  const _ProgressBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _KitchenEmptyState extends StatelessWidget {
  const _KitchenEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 126,
              height: 126,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.softMint, AppColors.lavender],
                ),
                borderRadius: BorderRadius.circular(34),
              ),
              child: const Icon(
                Icons.restaurant_menu,
                size: 56,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Dapur Kosong',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            const Text(
              'Order aktif hari ini akan muncul di sini.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _statusLabel(String value) {
  return switch (value) {
    'pending' => 'Baru',
    'preparing' => 'Diproses',
    'ready' => 'Siap',
    'served' => 'Selesai',
    _ => value,
  };
}

Color _statusColor(String value) {
  return switch (value) {
    'pending' => const Color(0xFF7A6A00),
    'preparing' => AppColors.primary,
    'ready' => const Color(0xFF2F6FEB),
    'served' => AppColors.textSecondary,
    _ => AppColors.textSecondary,
  };
}

String _orderTypeLabel(String value) {
  return switch (value.toLowerCase()) {
    'takeaway' => 'Bungkus',
    _ => value,
  };
}
