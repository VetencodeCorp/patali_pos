import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/customer_repository.dart';
import '../../../shared/widgets/patali_card.dart';
import '../../../shared/widgets/patali_shell.dart';

class CustomerFormScreen extends ConsumerStatefulWidget {
  const CustomerFormScreen({super.key, this.customerId});

  static const createRoutePath = '/customers/new';
  static const editRoutePath = '/customers/:customerId/edit';

  static String editLocation(String customerId) {
    return '/customers/$customerId/edit';
  }

  final String? customerId;

  @override
  ConsumerState<CustomerFormScreen> createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends ConsumerState<CustomerFormScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _noteController = TextEditingController();

  bool _hydrated = false;
  bool _saving = false;

  bool get _isEditing => widget.customerId != null;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customer = _isEditing
        ? ref.watch(customerByIdProvider(widget.customerId!))
        : const AsyncValue<Customer?>.data(null);

    return PataliShell(
      title: _isEditing ? 'Edit Pelanggan' : 'Tambah Pelanggan',
      currentIndex: 4,
      child: customer.when(
        data: (item) {
          if (_isEditing && item == null) {
            return const Center(child: Text('Pelanggan tidak ditemukan'));
          }
          if (item != null && !_hydrated) _hydrate(item);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              PataliCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _LabeledTextField(
                      label: 'Nama Pelanggan',
                      hint: 'Contoh: Andi Saputra',
                      controller: _nameController,
                      autofocus: true,
                    ),
                    const SizedBox(height: 12),
                    _LabeledTextField(
                      label: 'Nomor HP',
                      hint: 'Contoh: 081234567890',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 12),
                    _LabeledTextField(
                      label: 'Email',
                      hint: 'Contoh: andi@email.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    _LabeledTextField(
                      label: 'Alamat',
                      hint: 'Contoh: Jl. Merdeka No. 10',
                      controller: _addressController,
                      minLines: 2,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    _LabeledTextField(
                      label: 'Catatan',
                      hint: 'Contoh: Suka kopi tanpa gula',
                      controller: _noteController,
                      minLines: 2,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    FilledButton.icon(
                      onPressed: _saving ? null : () => _save(item),
                      icon: _saving
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.save_outlined),
                      label: const Text('Simpan Pelanggan'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Gagal memuat pelanggan: $error')),
      ),
    );
  }

  void _hydrate(Customer customer) {
    _nameController.text = customer.name;
    _phoneController.text = customer.phone ?? '';
    _emailController.text = customer.email ?? '';
    _addressController.text = customer.address ?? '';
    _noteController.text = customer.note ?? '';
    _hydrated = true;
  }

  Future<void> _save(Customer? customer) async {
    setState(() => _saving = true);
    try {
      if (_isEditing && customer != null) {
        await ref
            .read(customerRepositoryProvider)
            .updateCustomer(
              id: customer.id,
              name: _nameController.text,
              phone: _phoneController.text,
              email: _emailController.text,
              address: _addressController.text,
              note: _noteController.text,
            );
      } else {
        await ref
            .read(customerRepositoryProvider)
            .createCustomer(
              name: _nameController.text,
              phone: _phoneController.text,
              email: _emailController.text,
              address: _addressController.text,
              note: _noteController.text,
            );
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditing ? 'Pelanggan diperbarui' : 'Pelanggan ditambahkan',
          ),
        ),
      );
      context.pop(true);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan pelanggan: $error')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

class _LabeledTextField extends StatelessWidget {
  const _LabeledTextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.autofocus = false,
    this.minLines,
    this.maxLines,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool autofocus;
  final int? minLines;
  final int? maxLines;

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
        TextField(
          controller: controller,
          autofocus: autofocus,
          keyboardType: keyboardType,
          minLines: minLines,
          maxLines: maxLines,
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    );
  }
}
