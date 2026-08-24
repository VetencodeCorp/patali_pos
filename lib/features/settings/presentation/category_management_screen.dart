import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/repositories/category_repository.dart';

class CategoryManagementScreen extends ConsumerWidget {
  const CategoryManagementScreen({super.key});

  static const routePath = '/settings/categories';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(activeCategoriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Kategori')),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tambah kategori',
        onPressed: () => _showCategoryDialog(context, ref),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: categories.when(
          data: (items) {
            if (items.isEmpty) {
              return const Center(child: Text('Belum ada kategori'));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final category = items[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.category_outlined),
                    title: Text(category.name),
                    subtitle: Text('Urutan ${category.sortOrder}'),
                    trailing: PopupMenuButton<_CategoryAction>(
                      tooltip: 'Aksi kategori',
                      onSelected: (action) {
                        switch (action) {
                          case _CategoryAction.edit:
                            _showCategoryDialog(context, ref, category);
                          case _CategoryAction.deactivate:
                            _confirmDeactivate(context, ref, category);
                          case _CategoryAction.delete:
                            _confirmDelete(context, ref, category);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: _CategoryAction.edit,
                          child: ListTile(
                            leading: Icon(Icons.edit),
                            title: Text('Edit'),
                          ),
                        ),
                        PopupMenuItem(
                          value: _CategoryAction.deactivate,
                          child: ListTile(
                            leading: Icon(Icons.hide_source),
                            title: Text('Nonaktifkan'),
                          ),
                        ),
                        PopupMenuItem(
                          value: _CategoryAction.delete,
                          child: ListTile(
                            leading: Icon(Icons.delete_outline),
                            title: Text('Hapus'),
                          ),
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
              child: Text('Gagal memuat kategori: $error'),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showCategoryDialog(
    BuildContext context,
    WidgetRef ref, [
    Category? category,
  ]) async {
    final nameController = TextEditingController(text: category?.name ?? '');
    final sortOrderController = TextEditingController(
      text: category?.sortOrder.toString() ?? '0',
    );
    final isEditing = category != null;

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit kategori' : 'Tambah kategori'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Nama kategori'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: sortOrderController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Urutan'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
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
        );
      },
    );

    if (!context.mounted || saved != true) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isEditing ? 'Kategori diperbarui' : 'Kategori ditambahkan',
        ),
      ),
    );
  }

  Future<void> _confirmDeactivate(
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
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Kategori dinonaktifkan')));
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Category category,
  ) async {
    final confirmed = await _confirm(
      context,
      title: 'Hapus kategori',
      content: '${category.name} akan dihapus dari daftar aktif dan POS.',
      confirmLabel: 'Hapus',
    );
    if (!context.mounted || confirmed != true) return;
    await ref.read(categoryRepositoryProvider).deleteCategory(category.id);
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Kategori dihapus')));
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
}

enum _CategoryAction { edit, deactivate, delete }
