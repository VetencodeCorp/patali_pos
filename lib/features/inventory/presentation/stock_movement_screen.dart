import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../data/repositories/stock_movement_repository.dart';
import '../../../shared/widgets/patali_card.dart';
import '../../../shared/widgets/patali_shell.dart';

class StockMovementScreen extends ConsumerWidget {
  const StockMovementScreen({super.key});

  static const routePath = '/inventory/stock-movements';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movements = ref.watch(stockMovementsProvider);

    return PataliShell(
      title: 'Pergerakan Stok',
      currentIndex: 3,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: TextButton.icon(
            onPressed: () => _showStockSheet(context, ref),
            icon: const Icon(Icons.add),
            label: const Text('Input Stok'),
          ),
        ),
      ],
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _OutlineActionButton(
            label: 'Input Stok',
            icon: Icons.add_box_outlined,
            onPressed: () => _showStockSheet(context, ref),
          ),
          const SizedBox(height: 14),
          movements.when(
            data: (items) {
              if (items.isEmpty) return const _EmptyMovementState();
              return Column(
                children: [
                  for (final item in items) ...[
                    _StockMovementRow(item: item),
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
              child: Center(child: Text('Gagal memuat stok: $error')),
            ),
          ),
        ],
      ),
    );
  }
}

class _StockMovementRow extends StatelessWidget {
  const _StockMovementRow({required this.item});

  final StockMovementListItem item;

  @override
  Widget build(BuildContext context) {
    final movement = item.movement;
    final dateFormat = DateFormat('dd MMM HH:mm', 'id_ID');
    final qtyPositive = movement.qtyChange > 0;
    final color = qtyPositive ? AppColors.primary : AppColors.danger;
    final sign = qtyPositive ? '+' : '';
    final source = _sourceLabel(movement.source, movement.type);

    return PataliCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: qtyPositive ? AppColors.softMint : const Color(0xFFFFE8EA),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              qtyPositive ? Icons.south_west : Icons.north_east,
              color: color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movement.productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  '$source - ${dateFormat.format(movement.createdAt)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (movement.note != null && movement.note!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    movement.note!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$sign${movement.qtyChange}',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Sisa ${movement.stockAfter}',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyMovementState extends StatelessWidget {
  const _EmptyMovementState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 80),
      child: Column(
        children: [
          Icon(Icons.inventory_outlined, size: 72, color: AppColors.primary),
          SizedBox(height: 16),
          Text(
            'Belum Ada Pergerakan Stok',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 8),
          Text(
            'Restock, koreksi stok, checkout, dan void akan muncul di sini.',
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

class _OutlineActionButton extends StatelessWidget {
  const _OutlineActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
      ),
    );
  }
}

Future<void> _showStockSheet(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    builder: (context) => const _StockMovementSheet(),
  );
}

class _StockMovementSheet extends ConsumerStatefulWidget {
  const _StockMovementSheet();

  @override
  ConsumerState<_StockMovementSheet> createState() =>
      _StockMovementSheetState();
}

class _StockMovementSheetState extends ConsumerState<_StockMovementSheet> {
  final _qtyController = TextEditingController();
  final _noteController = TextEditingController();
  String? _productId;
  String _mode = 'in';

  @override
  void dispose() {
    _qtyController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(activeProductsProvider);

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 20,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            'Input Stok',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 18),
          _LabeledField(
            label: 'Jenis',
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'in', label: Text('Tambah Stok')),
                ButtonSegment(value: 'adjustment', label: Text('Koreksi')),
              ],
              selected: {_mode},
              onSelectionChanged: (value) => setState(() {
                _mode = value.single;
              }),
            ),
          ),
          const SizedBox(height: 12),
          products.when(
            data: (items) {
              final stockProducts = items
                  .where((product) => product.trackStock)
                  .toList();
              if (stockProducts.isEmpty) {
                return const Text(
                  'Belum ada produk yang memakai stok.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                );
              }
              return _LabeledField(
                label: 'Produk',
                child: DropdownButtonFormField<String>(
                  initialValue: _productId,
                  decoration: const InputDecoration(
                    hintText: 'Pilih produk stok',
                  ),
                  items: [
                    for (final product in stockProducts)
                      DropdownMenuItem(
                        value: product.id,
                        child: Text(
                          '${product.name} - stok ${product.stockQty}',
                        ),
                      ),
                  ],
                  onChanged: (value) => setState(() => _productId = value),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Text('Produk gagal dimuat: $error'),
          ),
          const SizedBox(height: 12),
          _LabeledField(
            label: _mode == 'in' ? 'Jumlah Masuk' : 'Stok Baru',
            child: TextField(
              controller: _qtyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: _mode == 'in' ? 'Contoh: 20' : 'Contoh: 12',
              ),
            ),
          ),
          const SizedBox(height: 12),
          _LabeledField(
            label: 'Catatan',
            child: TextField(
              controller: _noteController,
              minLines: 2,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Contoh: Restock supplier / stok rusak',
              ),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Simpan Stok'),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final productId = _productId;
    final qty =
        int.tryParse(_qtyController.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
        0;
    if (productId == null) {
      _showMessage('Produk wajib dipilih');
      return;
    }
    if (qty <= 0) {
      _showMessage(
        _mode == 'in'
            ? 'Jumlah masuk harus lebih dari 0'
            : 'Stok baru harus diisi',
      );
      return;
    }

    try {
      final repository = ref.read(stockMovementRepositoryProvider);
      if (_mode == 'in') {
        await repository.addStock(
          productId: productId,
          qty: qty,
          note: _noteController.text,
        );
      } else {
        await repository.correctStock(
          productId: productId,
          newStock: qty,
          note: _noteController.text,
        );
      }
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Stok disimpan')));
    } catch (error) {
      _showMessage('Gagal menyimpan stok: $error');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 7),
        child,
      ],
    );
  }
}

String _sourceLabel(String? source, String type) {
  return switch (source) {
    'sale' => 'Checkout',
    'void_restore' => 'Void',
    'manual' => type == 'adjustment' ? 'Koreksi' : 'Stok Masuk',
    _ =>
      type == 'adjustment'
          ? 'Koreksi'
          : type == 'out'
          ? 'Stok Keluar'
          : 'Stok Masuk',
  };
}
