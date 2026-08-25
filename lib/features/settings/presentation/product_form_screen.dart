import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/category_repository.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../shared/widgets/patali_card.dart';
import '../../../shared/widgets/patali_shell.dart';

final productByIdProvider = FutureProvider.family<Product?, String>((
  ref,
  id,
) async {
  ref.watch(devSeedProvider);
  return ref.watch(productRepositoryProvider).getProductById(id);
});

class ProductFormScreen extends ConsumerStatefulWidget {
  const ProductFormScreen({super.key, this.productId});

  static const createRoutePath = '/settings/products/new';
  static const editRoutePath = '/settings/products/:productId/edit';

  static String editLocation(String productId) {
    return '/settings/products/$productId/edit';
  }

  final String? productId;

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _skuController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _costController = TextEditingController();
  final _stockController = TextEditingController(text: '0');
  final _minStockController = TextEditingController(text: '0');

  String? _selectedCategoryId;
  String? _imagePath;
  bool _trackStock = false;
  bool _hydrated = false;
  bool _saving = false;

  bool get _isEditing => widget.productId != null;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _skuController.dispose();
    _barcodeController.dispose();
    _descriptionController.dispose();
    _costController.dispose();
    _stockController.dispose();
    _minStockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(activeCategoriesProvider);
    final product = _isEditing
        ? ref.watch(productByIdProvider(widget.productId!))
        : const AsyncValue<Product?>.data(null);

    return PataliShell(
      title: _isEditing ? 'Edit Produk' : 'Tambah Produk',
      currentIndex: 3,
      child: product.when(
        data: (item) {
          if (_isEditing && item == null) {
            return const Center(child: Text('Produk tidak ditemukan'));
          }
          if (item != null && !_hydrated) _hydrate(item);

          return categories.when(
            data: (categoryItems) => _ProductFormBody(
              categories: categoryItems,
              imagePath: _imagePath,
              selectedCategoryId: _selectedCategoryId,
              trackStock: _trackStock,
              saving: _saving,
              nameController: _nameController,
              priceController: _priceController,
              skuController: _skuController,
              barcodeController: _barcodeController,
              descriptionController: _descriptionController,
              costController: _costController,
              stockController: _stockController,
              minStockController: _minStockController,
              onCategoryChanged: (value) {
                setState(() => _selectedCategoryId = value);
              },
              onTrackStockChanged: (value) {
                setState(() => _trackStock = value);
              },
              onPickImage: _pickImage,
              onClearImage: _imagePath == null
                  ? null
                  : () => setState(() => _imagePath = null),
              onSave: () => _save(item),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) =>
                Center(child: Text('Gagal memuat kategori: $error')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Gagal memuat produk: $error')),
      ),
    );
  }

  void _hydrate(Product product) {
    _nameController.text = product.name;
    _priceController.text = product.price.toString();
    _skuController.text = product.sku ?? '';
    _barcodeController.text = product.barcode ?? '';
    _descriptionController.text = product.description ?? '';
    _costController.text = product.cost?.toString() ?? '';
    _stockController.text = product.stockQty.toString();
    _minStockController.text = product.minStock.toString();
    _selectedCategoryId = product.categoryId;
    _imagePath = product.imagePath;
    _trackStock = product.trackStock;
    _hydrated = true;
  }

  Future<void> _pickImage() async {
    try {
      final file = await openFile(
        acceptedTypeGroups: const [
          XTypeGroup(
            label: 'Gambar produk',
            extensions: ['jpg', 'jpeg', 'png', 'webp'],
          ),
        ],
      );
      if (file == null) return;
      final savedPath = await _copyImageToAppDirectory(file);
      if (!mounted) return;
      setState(() => _imagePath = savedPath);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal memilih gambar: $error')));
    }
  }

  Future<String> _copyImageToAppDirectory(XFile source) async {
    final appDir = await getApplicationDocumentsDirectory();
    final targetDir = Directory(p.join(appDir.path, 'patali_product_images'));
    if (!await targetDir.exists()) {
      await targetDir.create(recursive: true);
    }
    final extension = p.extension(source.name).isEmpty
        ? '.jpg'
        : p.extension(source.name);
    final fileName =
        'product_${DateTime.now().millisecondsSinceEpoch}$extension';
    final targetPath = p.join(targetDir.path, fileName);
    await File(targetPath).writeAsBytes(await source.readAsBytes());
    return targetPath;
  }

  Future<void> _save(Product? product) async {
    setState(() => _saving = true);
    try {
      final price = _parseMoney(_priceController.text);
      final cost = _costController.text.trim().isEmpty
          ? null
          : _parseMoney(_costController.text);
      final stockQty = _parseMoney(_stockController.text);
      final minStock = _parseMoney(_minStockController.text);

      if (_isEditing && product != null) {
        await ref
            .read(productRepositoryProvider)
            .updateProduct(
              id: product.id,
              name: _nameController.text,
              price: price,
              sku: _skuController.text,
              barcode: _barcodeController.text,
              description: _descriptionController.text,
              imagePath: _imagePath,
              categoryId: _selectedCategoryId,
              cost: cost,
              trackStock: _trackStock,
              stockQty: stockQty,
              minStock: minStock,
            );
      } else {
        await ref
            .read(productRepositoryProvider)
            .createProduct(
              name: _nameController.text,
              price: price,
              sku: _skuController.text,
              barcode: _barcodeController.text,
              description: _descriptionController.text,
              imagePath: _imagePath,
              categoryId: _selectedCategoryId,
              cost: cost,
              trackStock: _trackStock,
              stockQty: stockQty,
              minStock: minStock,
            );
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditing ? 'Produk diperbarui' : 'Produk ditambahkan',
          ),
        ),
      );
      context.pop(true);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan produk: $error')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

class _ProductFormBody extends StatelessWidget {
  const _ProductFormBody({
    required this.categories,
    required this.imagePath,
    required this.selectedCategoryId,
    required this.trackStock,
    required this.saving,
    required this.nameController,
    required this.priceController,
    required this.skuController,
    required this.barcodeController,
    required this.descriptionController,
    required this.costController,
    required this.stockController,
    required this.minStockController,
    required this.onCategoryChanged,
    required this.onTrackStockChanged,
    required this.onPickImage,
    required this.onClearImage,
    required this.onSave,
  });

  final List<Category> categories;
  final String? imagePath;
  final String? selectedCategoryId;
  final bool trackStock;
  final bool saving;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController skuController;
  final TextEditingController barcodeController;
  final TextEditingController descriptionController;
  final TextEditingController costController;
  final TextEditingController stockController;
  final TextEditingController minStockController;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<bool> onTrackStockChanged;
  final VoidCallback onPickImage;
  final VoidCallback? onClearImage;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        PataliCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Foto Produk',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  _ProductImagePreview(path: imagePath, size: 86),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        OutlinedButton.icon(
                          onPressed: onPickImage,
                          icon: const Icon(Icons.add_photo_alternate_outlined),
                          label: Text(
                            imagePath == null ? 'Pilih Gambar' : 'Ganti Gambar',
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'JPG, PNG, atau WEBP',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        if (imagePath != null) ...[
                          const SizedBox(height: 8),
                          TextButton.icon(
                            onPressed: onClearImage,
                            icon: const Icon(Icons.close),
                            label: const Text('Hapus Gambar'),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _LabeledTextField(
                label: 'Nama Produk',
                hint: 'Contoh: Kopi Susu Gula Aren',
                controller: nameController,
                autofocus: true,
              ),
              const SizedBox(height: 12),
              _LabeledField(
                label: 'Kategori',
                child: DropdownButtonFormField<String?>(
                  initialValue: selectedCategoryId,
                  decoration: const InputDecoration(hintText: 'Pilih kategori'),
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
                  onChanged: onCategoryChanged,
                ),
              ),
              const SizedBox(height: 12),
              _LabeledTextField(
                label: 'SKU',
                hint: 'Contoh: DRK-001',
                controller: skuController,
              ),
              const SizedBox(height: 12),
              _LabeledTextField(
                label: 'Barcode',
                hint: 'Contoh: 8991234567890',
                controller: barcodeController,
              ),
              const SizedBox(height: 12),
              _LabeledTextField(
                label: 'Deskripsi',
                hint: 'Contoh: Espresso, susu segar, gula aren',
                controller: descriptionController,
                minLines: 2,
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              _LabeledTextField(
                label: 'Harga Jual',
                hint: 'Contoh: 18000',
                controller: priceController,
                keyboardType: TextInputType.number,
                prefixText: 'Rp ',
              ),
              const SizedBox(height: 12),
              _LabeledTextField(
                label: 'Harga Modal',
                hint: 'Contoh: 9000',
                controller: costController,
                keyboardType: TextInputType.number,
                prefixText: 'Rp ',
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Monitor Persediaan'),
                value: trackStock,
                onChanged: onTrackStockChanged,
              ),
              if (trackStock) ...[
                const SizedBox(height: 12),
                _LabeledTextField(
                  label: 'Stok',
                  hint: 'Contoh: 24',
                  controller: stockController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                _LabeledTextField(
                  label: 'Stok Minimum',
                  hint: 'Contoh: 5',
                  controller: minStockController,
                  keyboardType: TextInputType.number,
                ),
              ],
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: saving ? null : onSave,
                icon: saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save_outlined),
                label: const Text('Simpan Produk'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LabeledTextField extends StatelessWidget {
  const _LabeledTextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.prefixText,
    this.autofocus = false,
    this.minLines,
    this.maxLines,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? prefixText;
  final bool autofocus;
  final int? minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return _LabeledField(
      label: label,
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        keyboardType: keyboardType,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(hintText: hint, prefixText: prefixText),
      ),
    );
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

class _ProductImagePreview extends StatelessWidget {
  const _ProductImagePreview({required this.path, required this.size});

  final String? path;
  final double size;

  @override
  Widget build(BuildContext context) {
    final imagePath = path;
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
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

int _parseMoney(String value) {
  return int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
}
