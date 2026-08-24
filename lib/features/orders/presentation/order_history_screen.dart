import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/repositories/order_repository.dart';
import '../../../shared/widgets/patali_card.dart';
import '../../../shared/widgets/patali_shell.dart';
import 'receipt_screen.dart';

class OrderHistoryScreen extends ConsumerStatefulWidget {
  const OrderHistoryScreen({super.key});

  static const routePath = '/orders';

  @override
  ConsumerState<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends ConsumerState<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(orderHistoryItemsProvider);
    final selectedDate = ref.watch(orderHistoryDateProvider);
    final selectedPayment = ref.watch(orderHistoryPaymentMethodProvider);

    return PataliShell(
      title: 'Daftar Order',
      currentIndex: 1,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.background,
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Column(
              children: [
                _OrderHistoryFilters(
                  selectedDate: selectedDate,
                  selectedPayment: selectedPayment,
                  searchController: _searchController,
                  onSearchChanged: (value) {
                    setState(() => _query = value.trim().toLowerCase());
                  },
                ),
                orders.when(
                  data: (items) => TabBar(
                    controller: _tabController,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.textSecondary,
                    indicatorColor: AppColors.amber,
                    indicatorWeight: 4,
                    labelStyle: const TextStyle(fontWeight: FontWeight.w900),
                    tabs: [
                      Tab(text: 'Semua (${_filterByTab(items, 0).length})'),
                      Tab(text: 'Kasir (${_filterByTab(items, 1).length})'),
                      Tab(text: 'Online (${_filterByTab(items, 2).length})'),
                    ],
                  ),
                  loading: () => TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(text: 'Semua'),
                      Tab(text: 'Kasir'),
                      Tab(text: 'Online'),
                    ],
                  ),
                  error: (_, _) => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          Expanded(
            child: orders.when(
              data: (items) {
                final filtered = _filterBySearch(
                  _filterByTab(items, _tabController.index),
                );
                if (filtered.isEmpty) {
                  return const _PremiumEmptyState(
                    title: 'Belum Ada Pesanan',
                    message: 'Transaksi kasir akan muncul di daftar ini.',
                    icon: Icons.receipt_long_outlined,
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return _OrderHistoryTile(item: filtered[index]);
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

  List<OrderListItem> _filterByTab(List<OrderListItem> items, int tabIndex) {
    return switch (tabIndex) {
      0 => items,
      1 => items,
      _ => const <OrderListItem>[],
    };
  }

  List<OrderListItem> _filterBySearch(List<OrderListItem> items) {
    if (_query.isEmpty) return items;
    return items.where((item) {
      final order = item.order;
      final payment = item.payment;
      return order.orderNumber.toLowerCase().contains(_query) ||
          order.status.toLowerCase().contains(_query) ||
          _paymentLabel(payment?.method).toLowerCase().contains(_query);
    }).toList();
  }
}

class _OrderHistoryFilters extends ConsumerWidget {
  const _OrderHistoryFilters({
    required this.selectedDate,
    required this.selectedPayment,
    required this.searchController,
    required this.onSearchChanged,
  });

  final DateTime? selectedDate;
  final String? selectedPayment;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Cari ...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                tooltip: 'Filter',
                onPressed: () => _showFilterSheet(
                  context,
                  ref,
                  normalizedToday,
                  selectedDate,
                  selectedPayment,
                ),
                icon: const Icon(Icons.tune),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _FilterPill(
                  label: selectedDate == null ? 'Semua tanggal' : 'Hari ini',
                  icon: Icons.calendar_today_outlined,
                  active: selectedDate != null,
                  onTap: () {
                    ref.read(orderHistoryDateProvider.notifier).state =
                        selectedDate == null ? normalizedToday : null;
                  },
                ),
                _FilterPill(
                  label: selectedPayment == null
                      ? 'Semua metode'
                      : _paymentLabel(selectedPayment),
                  icon: Icons.payments_outlined,
                  active: selectedPayment != null,
                  onTap: () => _showFilterSheet(
                    context,
                    ref,
                    normalizedToday,
                    selectedDate,
                    selectedPayment,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showFilterSheet(
    BuildContext context,
    WidgetRef ref,
    DateTime today,
    DateTime? selectedDate,
    String? selectedPayment,
  ) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            children: [
              Text(
                'Filter Order',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Tanggal',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('Semua tanggal'),
                    selected: selectedDate == null,
                    onSelected: (_) {
                      ref.read(orderHistoryDateProvider.notifier).state = null;
                      Navigator.of(context).pop();
                    },
                  ),
                  ChoiceChip(
                    label: const Text('Hari ini'),
                    selected: selectedDate != null,
                    onSelected: (_) {
                      ref.read(orderHistoryDateProvider.notifier).state = today;
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'Metode Pembayaran',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('Semua metode'),
                    selected: selectedPayment == null,
                    onSelected: (_) {
                      ref
                              .read(orderHistoryPaymentMethodProvider.notifier)
                              .state =
                          null;
                      Navigator.of(context).pop();
                    },
                  ),
                  for (final method in _paymentMethods)
                    ChoiceChip(
                      avatar: Icon(method.icon, size: 17),
                      label: Text(method.label),
                      selected: selectedPayment == method.code,
                      onSelected: (_) {
                        ref
                            .read(orderHistoryPaymentMethodProvider.notifier)
                            .state = method
                            .code;
                        Navigator.of(context).pop();
                      },
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 17, color: active ? AppColors.primary : null),
      label: Text(label),
      onPressed: onTap,
      side: BorderSide(color: active ? AppColors.primary : AppColors.border),
      backgroundColor: active ? AppColors.softMint : AppColors.surface,
      labelStyle: TextStyle(
        color: active ? AppColors.primary : AppColors.textPrimary,
        fontWeight: FontWeight.w800,
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

    return PataliCard(
      onTap: () => context.push(ReceiptScreen.location(order.id)),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.softMint,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              _paymentIcon(payment?.method),
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.orderNumber,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 5),
                Text(
                  dateFormat.format(order.orderedAt),
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _HistoryBadge(
                      label: _orderTypeLabel(order.orderType),
                      muted: true,
                    ),
                    _HistoryBadge(label: paymentLabel),
                    _HistoryBadge(
                      label: order.status,
                      danger: order.status == 'voided',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                currency.format(order.grandTotal),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w900),
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
        ],
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
  const _HistoryBadge({
    required this.label,
    this.danger = false,
    this.muted = false,
  });

  final String label;
  final bool danger;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: danger
            ? const Color(0xFFFFE7E7)
            : muted
            ? AppColors.lavender
            : AppColors.softMint,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          label,
          style: TextStyle(
            color: danger
                ? AppColors.danger
                : muted
                ? AppColors.textSecondary
                : AppColors.primary,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _PremiumEmptyState extends StatelessWidget {
  const _PremiumEmptyState({
    required this.title,
    required this.message,
    required this.icon,
  });

  final String title;
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 132,
              height: 132,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.softMint, AppColors.lavender],
                ),
                borderRadius: BorderRadius.circular(36),
              ),
              child: Icon(icon, size: 58, color: AppColors.primary),
            ),
            const SizedBox(height: 22),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
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

String _orderTypeLabel(String value) {
  return switch (value.toLowerCase()) {
    'takeaway' => 'Bungkus',
    _ => value,
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
