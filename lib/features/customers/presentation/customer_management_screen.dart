import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/customer_repository.dart';
import '../../../shared/widgets/patali_card.dart';
import '../../../shared/widgets/patali_shell.dart';
import 'customer_form_screen.dart';

class CustomerManagementScreen extends ConsumerWidget {
  const CustomerManagementScreen({super.key});

  static const routePath = '/customers';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customers = ref.watch(activeCustomersProvider);

    return PataliShell(
      title: 'Pelanggan',
      currentIndex: 4,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: const BoxDecoration(
              color: AppColors.background,
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: TextField(
              onChanged: (value) {
                ref.read(customerSearchQueryProvider.notifier).state = value;
              },
              decoration: const InputDecoration(
                hintText: 'Cari nama atau nomor HP',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: customers.when(
              data: (items) {
                if (items.isEmpty) {
                  return _EmptyCustomers(
                    onCreate: () =>
                        context.push(CustomerFormScreen.createRoutePath),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length + 1,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return OutlinedButton.icon(
                        onPressed: () =>
                            context.push(CustomerFormScreen.createRoutePath),
                        icon: const Icon(Icons.person_add_alt_1_outlined),
                        label: const Text('Tambah Pelanggan'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(54),
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                        ),
                      );
                    }

                    final customer = items[index - 1];
                    return _CustomerRow(
                      customer: customer,
                      onEdit: () => context.push(
                        CustomerFormScreen.editLocation(customer.id),
                      ),
                      onDeactivate: () =>
                          _confirmDeactivateCustomer(context, ref, customer),
                      onDelete: () =>
                          _confirmDeleteCustomer(context, ref, customer),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text('Gagal memuat pelanggan: $error')),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomerRow extends StatelessWidget {
  const _CustomerRow({
    required this.customer,
    required this.onEdit,
    required this.onDeactivate,
    required this.onDelete,
  });

  final Customer customer;
  final VoidCallback onEdit;
  final VoidCallback onDeactivate;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final detail = [
      if (customer.phone != null) customer.phone!,
      if (customer.email != null) customer.email!,
      if (customer.address != null) customer.address!,
    ].join(' - ');

    return PataliCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.softMint,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.person_outline, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  detail.isEmpty ? 'Tanpa kontak' : detail,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<_CustomerAction>(
            tooltip: 'Aksi',
            onSelected: (action) {
              switch (action) {
                case _CustomerAction.edit:
                  onEdit();
                case _CustomerAction.deactivate:
                  onDeactivate();
                case _CustomerAction.delete:
                  onDelete();
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: _CustomerAction.edit,
                child: ListTile(
                  leading: Icon(Icons.edit_outlined),
                  title: Text('Edit'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: _CustomerAction.deactivate,
                child: ListTile(
                  leading: Icon(Icons.hide_source_outlined),
                  title: Text('Nonaktifkan'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: _CustomerAction.delete,
                child: ListTile(
                  leading: Icon(Icons.delete_outline),
                  title: Text('Hapus'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyCustomers extends StatelessWidget {
  const _EmptyCustomers({required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                Icons.people_alt_outlined,
                color: AppColors.primary,
                size: 52,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Belum Ada Pelanggan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tambah pelanggan untuk member dan riwayat transaksi.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: onCreate,
              icon: const Icon(Icons.person_add_alt_1_outlined),
              label: const Text('Tambah Pelanggan'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _confirmDeactivateCustomer(
  BuildContext context,
  WidgetRef ref,
  Customer customer,
) async {
  final confirmed = await _confirm(
    context,
    title: 'Nonaktifkan pelanggan',
    content: '${customer.name} tidak tampil di pilihan aktif.',
    confirmLabel: 'Nonaktifkan',
  );
  if (!context.mounted || confirmed != true) return;
  await ref.read(customerRepositoryProvider).deactivateCustomer(customer.id);
}

Future<void> _confirmDeleteCustomer(
  BuildContext context,
  WidgetRef ref,
  Customer customer,
) async {
  final confirmed = await _confirm(
    context,
    title: 'Hapus pelanggan',
    content: '${customer.name} akan disembunyikan tapi data order tetap aman.',
    confirmLabel: 'Hapus',
  );
  if (!context.mounted || confirmed != true) return;
  await ref.read(customerRepositoryProvider).deleteCustomer(customer.id);
}

Future<bool?> _confirm(
  BuildContext context, {
  required String title,
  required String content,
  required String confirmLabel,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmLabel),
          ),
        ],
      );
    },
  );
}

enum _CustomerAction { edit, deactivate, delete }
