import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/category_repository.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../shared/widgets/patali_card.dart';
import '../../../shared/widgets/patali_shell.dart';
import '../../inventory/presentation/stock_movement_screen.dart';
import 'product_form_screen.dart';

class ProductManagementScreen extends ConsumerStatefulWidget {
  const ProductManagementScreen({super.key, this.initialTab = 0});

  static const routePath = '/settings/products';

  final int initialTab;

  @override
  ConsumerState<ProductManagementScreen> createState() =>
      _ProductManagementScreenState();
}

class _ProductManagementScreenState
    extends ConsumerState<ProductManagementScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTab,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(activeProductsProvider);
    final categories = ref.watch(activeCategoriesProvider);

    return PataliShell(
      title: 'Produk & Kategori',
      currentIndex: 3,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            decoration: const BoxDecoration(
              color: AppColors.background,
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Column(
              children: [
                const _SearchAndFilterBar(),
                const SizedBox(height: 12),
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textSecondary,
                  indicatorColor: AppColors.amber,
                  indicatorWeight: 4,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w900),
                  tabs: const [
                    Tab(text: 'Produk'),
                    Tab(text: 'Kategori'),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _ProductsTab(products: products, categories: categories),
                _CategoriesTab(categories: categories),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchAndFilterBar extends StatelessWidget {
  const _SearchAndFilterBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari ...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                tooltip: 'Filter',
                onPressed: () {},
                icon: const Icon(Icons.tune),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProductsTab extends ConsumerWidget {
  const _ProductsTab({required this.products, required this.categories});

  final AsyncValue<List<Product>> products;
  final AsyncValue<List<Category>> categories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryItems = categories.valueOrNull ?? const [];
    final lowStock = ref.watch(lowStockProductsProvider);

    return products.when(
      data: (items) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final twoColumns = constraints.maxWidth >= 560;
                final buttons = [
                  _OutlineActionButton(
                    label: 'Tambah Produk',
                    icon: Icons.add_box_outlined,
                    onPressed: () =>
                        context.push(ProductFormScreen.createRoutePath),
                  ),
                  _OutlineActionButton(
                    label: 'Pergerakan Stok',
                    icon: Icons.inventory_outlined,
                    onPressed: () =>
                        context.push(StockMovementScreen.routePath),
                  ),
                ];
                if (!twoColumns) {
                  return Column(
                    children: [
                      buttons[0],
                      const SizedBox(height: 10),
                      buttons[1],
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(child: buttons[0]),
                    const SizedBox(width: 10),
                    Expanded(child: buttons[1]),
                  ],
                );
              },
            ),
            const SizedBox(height: 18),
            lowStock.when(
              data: (stockItems) => _LowStockPanel(products: stockItems),
              loading: () => const SizedBox.shrink(),
              error: (error, stackTrace) => Text(
                'Gagal memuat stok menipis: $error',
                style: const TextStyle(color: AppColors.danger),
              ),
            ),
            const SizedBox(height: 18),
            const _ProductsHeader(),
            const SizedBox(height: 10),
            if (items.isEmpty)
              const _PremiumEmptyState(
                icon: Icons.inventory_2_outlined,
                title: 'Produk Tidak Tersedia',
                message: 'Tambahkan produk agar bisa tampil di kasir.',
              )
            else
              for (final product in items) ...[
                _ProductRow(
                  product: product,
                  categoryName: _categoryName(categoryItems, product),
                  onEdit: () =>
                      context.push(ProductFormScreen.editLocation(product.id)),
                  onDeactivate: () =>
                      _confirmDeactivateProduct(context, ref, product),
                  onDelete: () => _confirmDeleteProduct(context, ref, product),
                ),
                const SizedBox(height: 8),
              ],
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text('Gagal memuat produk: $error'),
        ),
      ),
    );
  }
}

class _CategoriesTab extends ConsumerWidget {
  const _CategoriesTab({required this.categories});

  final AsyncValue<List<Category>> categories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return categories.when(
      data: (items) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _OutlineActionButton(
              label: 'Tambah Kategori',
              icon: Icons.create_new_folder_outlined,
              onPressed: () => _showCategorySheet(context, ref),
            ),
            const SizedBox(height: 18),
            const _CategoriesHeader(),
            const SizedBox(height: 10),
            if (items.isEmpty)
              const _PremiumEmptyState(
                icon: Icons.category_outlined,
                title: 'Belum Ada Kategori',
                message: 'Tambahkan kategori untuk merapikan produk.',
              )
            else
              for (final category in items) ...[
                _CategoryRow(
                  category: category,
                  onEdit: () => _showCategorySheet(context, ref, category),
                  onDeactivate: () =>
                      _confirmDeactivateCategory(context, ref, category),
                  onDelete: () =>
                      _confirmDeleteCategory(context, ref, category),
                ),
                const SizedBox(height: 8),
              ],
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text('Gagal memuat kategori: $error'),
        ),
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

class _ProductsHeader extends StatelessWidget {
  const _ProductsHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          SizedBox(width: 54),
          Expanded(
            flex: 3,
            child: Text(
              'Produk',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Harga/Stok',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(width: 42),
        ],
      ),
    );
  }
}

class _CategoriesHeader extends StatelessWidget {
  const _CategoriesHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: Text(
              'Urutan',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Nama',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(width: 42),
        ],
      ),
    );
  }
}

class _ProductRow extends StatelessWidget {
  const _ProductRow({
    required this.product,
    required this.categoryName,
    required this.onEdit,
    required this.onDeactivate,
    required this.onDelete,
  });

  final Product product;
  final String categoryName;
  final VoidCallback onEdit;
  final VoidCallback onDeactivate;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final stockText = _stockLabel(product);
    final stockColor = _stockColor(product);

    return PataliCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          _ProductImagePreview(path: product.imagePath, size: 46),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  product.sku == null || product.sku!.isEmpty
                      ? categoryName
                      : '$categoryName - ${product.sku}',
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
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  currency.format(product.price),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  stockText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ).copyWith(color: stockColor),
                ),
              ],
            ),
          ),
          _RowMenu(
            onEdit: onEdit,
            onDeactivate: onDeactivate,
            onDelete: onDelete,
          ),
        ],
      ),
    );
  }
}

class _LowStockPanel extends StatelessWidget {
  const _LowStockPanel({required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    return PataliCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE8EA),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.danger,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${products.length} Produk Stok Menipis',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final product in products.take(4)) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  _stockLabel(product),
                  style: TextStyle(
                    color: _stockColor(product),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _ProductImagePreview extends StatelessWidget {
  const _ProductImagePreview({required this.path, required this.size});

  final String? path;
  final double size;

  @override
  Widget build(BuildContext context) {
    final imagePath = path;
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: size,
        height: size,
        color: AppColors.softMint,
        child: imagePath == null || imagePath.isEmpty
            ? const Icon(Icons.fastfood_outlined, color: AppColors.primary)
            : Image.file(
                File(imagePath),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image_outlined,
                  color: AppColors.textSecondary,
                ),
              ),
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({
    required this.category,
    required this.onEdit,
    required this.onDeactivate,
    required this.onDelete,
  });

  final Category category;
  final VoidCallback onEdit;
  final VoidCallback onDeactivate;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return PataliCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: Text(
              '${category.sortOrder}',
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          Expanded(
            child: Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          _RowMenu(
            onEdit: onEdit,
            onDeactivate: onDeactivate,
            onDelete: onDelete,
          ),
        ],
      ),
    );
  }
}

class _RowMenu extends StatelessWidget {
  const _RowMenu({
    required this.onEdit,
    required this.onDeactivate,
    required this.onDelete,
  });

  final VoidCallback onEdit;
  final VoidCallback onDeactivate;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_RowAction>(
      tooltip: 'Aksi',
      onSelected: (action) {
        switch (action) {
          case _RowAction.edit:
            onEdit();
          case _RowAction.deactivate:
            onDeactivate();
          case _RowAction.delete:
            onDelete();
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: _RowAction.edit,
          child: ListTile(
            leading: Icon(Icons.edit_outlined),
            title: Text('Edit'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        PopupMenuItem(
          value: _RowAction.deactivate,
          child: ListTile(
            leading: Icon(Icons.hide_source_outlined),
            title: Text('Nonaktifkan'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        PopupMenuItem(
          value: _RowAction.delete,
          child: ListTile(
            leading: Icon(Icons.delete_outline),
            title: Text('Hapus'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}

class _PremiumEmptyState extends StatelessWidget {
  const _PremiumEmptyState({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Column(
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
    );
  }
}

Future<void> _showCategorySheet(
  BuildContext context,
  WidgetRef ref, [
  Category? category,
]) async {
  final nameController = TextEditingController(text: category?.name ?? '');
  final sortOrderController = TextEditingController(
    text: category?.sortOrder.toString() ?? '0',
  );
  final isEditing = category != null;

  final saved = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (context) {
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
              isEditing ? 'Edit Kategori' : 'Tambah Kategori',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: nameController,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Nama Kategori'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: sortOrderController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Urutan'),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () async {
                final sortOrder = int.tryParse(sortOrderController.text) ?? 0;
                if (isEditing) {
                  await ref
                      .read(categoryRepositoryProvider)
                      .updateCategory(
                        id: category.id,
                        name: nameController.text,
                        sortOrder: sortOrder,
                      );
                } else {
                  await ref
                      .read(categoryRepositoryProvider)
                      .createCategory(
                        name: nameController.text,
                        sortOrder: sortOrder,
                      );
                }
                if (!context.mounted) return;
                Navigator.of(context).pop(true);
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      );
    },
  );

  nameController.dispose();
  sortOrderController.dispose();

  if (!context.mounted || saved != true) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(isEditing ? 'Kategori diperbarui' : 'Kategori ditambahkan'),
    ),
  );
}

Future<void> _confirmDeactivateProduct(
  BuildContext context,
  WidgetRef ref,
  Product product,
) async {
  final confirmed = await _confirm(
    context,
    title: 'Nonaktifkan produk',
    content: '${product.name} tidak tampil lagi di POS.',
    confirmLabel: 'Nonaktifkan',
  );
  if (!context.mounted || confirmed != true) return;
  await ref.read(productRepositoryProvider).deactivateProduct(product.id);
}

Future<void> _confirmDeleteProduct(
  BuildContext context,
  WidgetRef ref,
  Product product,
) async {
  final confirmed = await _confirm(
    context,
    title: 'Hapus produk',
    content: '${product.name} akan disembunyikan dari daftar aktif dan POS.',
    confirmLabel: 'Hapus',
  );
  if (!context.mounted || confirmed != true) return;
  await ref.read(productRepositoryProvider).deleteProduct(product.id);
}

Future<void> _confirmDeactivateCategory(
  BuildContext context,
  WidgetRef ref,
  Category category,
) async {
  final confirmed = await _confirm(
    context,
    title: 'Nonaktifkan kategori',
    content: '${category.name} tidak tampil lagi di POS.',
    confirmLabel: 'Nonaktifkan',
  );
  if (!context.mounted || confirmed != true) return;
  await ref.read(categoryRepositoryProvider).deactivateCategory(category.id);
}

Future<void> _confirmDeleteCategory(
  BuildContext context,
  WidgetRef ref,
  Category category,
) async {
  final confirmed = await _confirm(
    context,
    title: 'Hapus kategori',
    content: '${category.name} akan disembunyikan dari daftar aktif dan POS.',
    confirmLabel: 'Hapus',
  );
  if (!context.mounted || confirmed != true) return;
  await ref.read(categoryRepositoryProvider).deleteCategory(category.id);
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

String _categoryName(List<Category> categories, Product product) {
  if (product.categoryId == null) return 'Tanpa kategori';
  for (final category in categories) {
    if (category.id == product.categoryId) return category.name;
  }
  return 'Kategori tidak ditemukan';
}

String _stockLabel(Product product) {
  if (!product.trackStock) return 'Non stok';
  if (product.stockQty <= 0) return 'Stok habis';
  if (product.stockQty <= product.minStock) {
    return 'Stok ${product.stockQty} / min ${product.minStock}';
  }
  return 'Stok ${product.stockQty}';
}

Color _stockColor(Product product) {
  if (!product.trackStock) return AppColors.textSecondary;
  if (product.stockQty <= 0) return AppColors.danger;
  if (product.stockQty <= product.minStock) return const Color(0xFFB7791F);
  return AppColors.textSecondary;
}

enum _RowAction { edit, deactivate, delete }
