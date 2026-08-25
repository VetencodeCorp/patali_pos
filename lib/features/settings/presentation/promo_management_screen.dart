import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/promo_repository.dart';
import '../../../shared/widgets/patali_card.dart';
import '../../../shared/widgets/patali_shell.dart';

class PromoManagementScreen extends ConsumerWidget {
  const PromoManagementScreen({super.key});

  static const routePath = '/settings/promos';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promos = ref.watch(activePromosProvider);

    return PataliShell(
      title: 'Promo & Diskon',
      currentIndex: 4,
      child: promos.when(
        data: (items) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              OutlinedButton.icon(
                onPressed: () => _showPromoSheet(context, ref),
                icon: const Icon(Icons.local_offer_outlined),
                label: const Text('Tambah Promo'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(54),
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 16),
              if (items.isEmpty)
                const _EmptyPromoState()
              else
                for (final promo in items) ...[
                  _PromoRow(
                    promo: promo,
                    onEdit: () => _showPromoSheet(context, ref, promo),
                    onDeactivate: () =>
                        _confirmDeactivatePromo(context, ref, promo),
                    onDelete: () => _confirmDeletePromo(context, ref, promo),
                  ),
                  const SizedBox(height: 8),
                ],
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Gagal memuat promo: $error')),
      ),
    );
  }
}

class _PromoRow extends StatelessWidget {
  const _PromoRow({
    required this.promo,
    required this.onEdit,
    required this.onDeactivate,
    required this.onDelete,
  });

  final Promo promo;
  final VoidCallback onEdit;
  final VoidCallback onDeactivate;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
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
            child: const Icon(
              Icons.local_offer_outlined,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  promo.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  '${promoValueLabel(promo)} - Transaksi',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<_PromoAction>(
            tooltip: 'Aksi',
            onSelected: (action) {
              switch (action) {
                case _PromoAction.edit:
                  onEdit();
                case _PromoAction.deactivate:
                  onDeactivate();
                case _PromoAction.delete:
                  onDelete();
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: _PromoAction.edit,
                child: ListTile(
                  leading: Icon(Icons.edit_outlined),
                  title: Text('Edit'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: _PromoAction.deactivate,
                child: ListTile(
                  leading: Icon(Icons.hide_source_outlined),
                  title: Text('Nonaktifkan'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: _PromoAction.delete,
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

class _EmptyPromoState extends StatelessWidget {
  const _EmptyPromoState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 80),
      child: Column(
        children: [
          Icon(Icons.local_offer_outlined, size: 72, color: AppColors.primary),
          SizedBox(height: 16),
          Text(
            'Belum Ada Promo',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 8),
          Text(
            'Tambah promo transaksi untuk dipilih di POS.',
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

Future<void> _showPromoSheet(
  BuildContext context,
  WidgetRef ref, [
  Promo? promo,
]) async {
  final isEditing = promo != null;

  final saved = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    builder: (context) => _PromoSheet(promo: promo),
  );

  if (!context.mounted || saved != true) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(isEditing ? 'Promo diperbarui' : 'Promo ditambah')),
  );
}

class _PromoSheet extends ConsumerStatefulWidget {
  const _PromoSheet({this.promo});

  final Promo? promo;

  @override
  ConsumerState<_PromoSheet> createState() => _PromoSheetState();
}

class _PromoSheetState extends ConsumerState<_PromoSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _valueController;
  late String _type;

  bool get _isEditing => widget.promo != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.promo?.name ?? '');
    _valueController = TextEditingController(
      text: widget.promo?.value.toString() ?? '',
    );
    _type = widget.promo?.type ?? 'amount';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            _isEditing ? 'Edit Promo' : 'Tambah Promo',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 18),
          _LabeledTextField(
            label: 'Nama Promo',
            hint: 'Contoh: Diskon Opening',
            controller: _nameController,
            autofocus: true,
          ),
          const SizedBox(height: 12),
          _LabeledField(
            label: 'Tipe Diskon',
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'amount', label: Text('Nominal')),
                ButtonSegment(value: 'percent', label: Text('Persen')),
              ],
              selected: {_type},
              onSelectionChanged: (value) {
                setState(() => _type = value.single);
              },
            ),
          ),
          const SizedBox(height: 12),
          _LabeledTextField(
            label: _type == 'amount' ? 'Nominal Diskon' : 'Persen Diskon',
            hint: _type == 'amount' ? 'Contoh: 10000' : 'Contoh: 10',
            controller: _valueController,
            keyboardType: TextInputType.number,
            prefixText: _type == 'amount' ? 'Rp ' : null,
            suffixText: _type == 'percent' ? '%' : null,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: _savePromo,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Simpan Promo'),
          ),
        ],
      ),
    );
  }

  Future<void> _savePromo() async {
    try {
      final value = _parseMoney(_valueController.text);
      final validationError = _validatePromoInput(
        name: _nameController.text,
        type: _type,
        value: value,
      );
      if (validationError != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(validationError)));
        return;
      }

      final repository = ref.read(promoRepositoryProvider);
      if (_isEditing) {
        await repository.updatePromo(
          id: widget.promo!.id,
          name: _nameController.text,
          type: _type,
          value: value,
        );
      } else {
        await repository.createPromo(
          name: _nameController.text,
          type: _type,
          value: value,
        );
      }

      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan promo: $error')));
    }
  }
}

Future<void> _confirmDeactivatePromo(
  BuildContext context,
  WidgetRef ref,
  Promo promo,
) async {
  final confirmed = await _confirm(
    context,
    title: 'Nonaktifkan promo',
    content: '${promo.name} tidak tampil lagi di POS.',
    confirmLabel: 'Nonaktifkan',
  );
  if (!context.mounted || confirmed != true) return;
  await ref.read(promoRepositoryProvider).deactivatePromo(promo.id);
}

Future<void> _confirmDeletePromo(
  BuildContext context,
  WidgetRef ref,
  Promo promo,
) async {
  final confirmed = await _confirm(
    context,
    title: 'Hapus promo',
    content: '${promo.name} akan disembunyikan dari daftar aktif.',
    confirmLabel: 'Hapus',
  );
  if (!context.mounted || confirmed != true) return;
  await ref.read(promoRepositoryProvider).deletePromo(promo.id);
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

class _LabeledTextField extends StatelessWidget {
  const _LabeledTextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.prefixText,
    this.suffixText,
    this.autofocus = false,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? prefixText;
  final String? suffixText;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return _LabeledField(
      label: label,
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          prefixText: prefixText,
          suffixText: suffixText,
        ),
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

int _parseMoney(String value) {
  return int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
}

String? _validatePromoInput({
  required String name,
  required String type,
  required int value,
}) {
  if (name.trim().isEmpty) return 'Nama promo wajib diisi';
  if (value <= 0) return 'Nilai promo harus lebih dari 0';
  if (type == 'percent' && value > 100) return 'Persen maksimal 100';
  return null;
}

enum _PromoAction { edit, deactivate, delete }
