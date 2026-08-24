import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/database/app_database.dart';
import '../../../data/repositories/category_repository.dart';
import '../../../data/repositories/product_repository.dart';

class ProductManagementScreen extends ConsumerWidget {
  const ProductManagementScreen({super.key});

  static const routePath = '/settings/products';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(activeProductsProvider);
    final categories = ref.watch(activeCategoriesProvider);
    final currency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Produk')),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tambah produk',
        onPressed: () => _showProductDialog(
          context,
          ref,
          categories.valueOrNull ?? const [],
        ),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: products.when(
          data: (items) {
            if (items.isEmpty) {
              return const Center(child: Text('Belum ada produk'));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final product = items[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.inventory_2_outlined),
                    title: Text(product.name),
                    subtitle: Text(product.sku ?? 'Tanpa SKU'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(currency.format(product.price)),
                        PopupMenuButton<_ProductAction>(
                          tooltip: 'Aksi produk',
                          onSelected: (action) {
                            switch (action) {
                              case _ProductAction.edit:
                                _showProductDialog(
                                  context,
                                  ref,
                                  categories.valueOrNull ?? const [],
                                  product,
                                );
                              case _ProductAction.deactivate:
                                _confirmDeactivate(context, ref, product);
                              case _ProductAction.delete:
                                _confirmDelete(context, ref, product);
                            }
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(
                              value: _ProductAction.edit,
                              child: ListTile(
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              ),
                            ),
                            PopupMenuItem(
                              value: _ProductAction.deactivate,
                              child: ListTile(
                                leading: Icon(Icons.hide_source),
                                title: Text('Nonaktifkan'),
                              ),
                            ),
                            PopupMenuItem(
                              value: _ProductAction.delete,
                              child: ListTile(
                                leading: Icon(Icons.delete_outline),
                                title: Text('Hapus'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Gagal memuat produk: $error'),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showProductDialog(
    BuildContext context,
    WidgetRef ref, [
    List<Category> categories = const [],
    Product? product,
  ]) async {
    final nameController = TextEditingController(text: product?.name ?? '');
    final priceController = TextEditingController(
      text: product?.price.toString() ?? '',
    );
    final skuController = TextEditingController(text: product?.sku ?? '');
    var selectedCategoryId = product?.categoryId;
    final isEditing = product != null;

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit produk' : 'Tambah produk'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Nama produk'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Harga',
                    prefixText: 'Rp ',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: skuController,
                  decoration: const InputDecoration(labelText: 'SKU'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String?>(
                  initialValue: selectedCategoryId,
                  decoration: const InputDecoration(labelText: 'Kategori'),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('Tanpa kategori'),
                    ),
                    for (final category in categories)
                      DropdownMenuItem<String?>(
                        value: category.id,
                        child: Text(category.name),
                      ),
                  ],
                  onChanged: (value) {
                    selectedCategoryId = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () async {
                final price =
                    int.tryParse(
                      priceController.text.replaceAll(RegExp(r'[^0-9]'), ''),
                    ) ??
                    0;
                if (isEditing) {
                  await ref
                      .read(productRepositoryProvider)
                      .updateProduct(
                        id: product.id,
                        name: nameController.text,
                        price: price,
                        sku: skuController.text,
                        categoryId: selectedCategoryId,
                      );
                } else {
                  await ref
                      .read(productRepositoryProvider)
                      .createProduct(
                        name: nameController.text,
                        price: price,
                        sku: skuController.text,
                        categoryId: selectedCategoryId,
                      );
                }
                if (!context.mounted) return;
                Navigator.of(context).pop(true);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );

    if (!context.mounted || saved != true) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isEditing ? 'Produk diperbarui' : 'Produk ditambahkan'),
      ),
    );
  }

  Future<void> _confirmDeactivate(
    BuildContext context,
    WidgetRef ref,
    Product product,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nonaktifkan produk'),
          content: Text('${product.name} tidak tampil lagi di POS.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Nonaktifkan'),
            ),
          ],
        );
      },
    );

    if (!context.mounted || confirmed != true) return;
    await ref.read(productRepositoryProvider).deactivateProduct(product.id);
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Produk dinonaktifkan')));
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Product product,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus produk'),
          content: Text(
            '${product.name} akan dihapus dari daftar aktif dan POS.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (!context.mounted || confirmed != true) return;
    try {
      await ref.read(productRepositoryProvider).deleteProduct(product.id);
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Produk dihapus')));
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Produk gagal dihapus: $error')));
    }
  }
}

enum _ProductAction { edit, deactivate, delete }
