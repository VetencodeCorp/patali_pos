import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/app_settings_repository.dart';
import '../../../shared/widgets/patali_card.dart';
import '../../../shared/widgets/patali_shell.dart';

class ReceiptTaxSettingsScreen extends ConsumerStatefulWidget {
  const ReceiptTaxSettingsScreen({super.key});

  static const routePath = '/settings/receipt-tax';

  @override
  ConsumerState<ReceiptTaxSettingsScreen> createState() =>
      _ReceiptTaxSettingsScreenState();
}

class _ReceiptTaxSettingsScreenState
    extends ConsumerState<ReceiptTaxSettingsScreen> {
  final _outletNameController = TextEditingController();
  final _outletAddressController = TextEditingController();
  final _outletPhoneController = TextEditingController();
  final _receiptHeaderController = TextEditingController();
  final _receiptFooterController = TextEditingController();
  final _taxRateController = TextEditingController();
  final _serviceRateController = TextEditingController();

  bool _taxEnabled = false;
  bool _serviceEnabled = false;
  bool _showOutletAddress = true;
  bool _hydrated = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    for (final controller in [
      _outletNameController,
      _outletAddressController,
      _outletPhoneController,
      _receiptHeaderController,
      _receiptFooterController,
      _taxRateController,
      _serviceRateController,
    ]) {
      controller.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    _outletNameController.dispose();
    _outletAddressController.dispose();
    _outletPhoneController.dispose();
    _receiptHeaderController.dispose();
    _receiptFooterController.dispose();
    _taxRateController.dispose();
    _serviceRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(appSettingsProvider);

    return PataliShell(
      title: 'Struk & Pajak',
      currentIndex: 4,
      child: settings.when(
        data: (data) {
          if (!_hydrated) _hydrate(data);
          return LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 900;
              final form = _SettingsForm(
                outletNameController: _outletNameController,
                outletAddressController: _outletAddressController,
                outletPhoneController: _outletPhoneController,
                receiptHeaderController: _receiptHeaderController,
                receiptFooterController: _receiptFooterController,
                taxRateController: _taxRateController,
                serviceRateController: _serviceRateController,
                taxEnabled: _taxEnabled,
                serviceEnabled: _serviceEnabled,
                showOutletAddress: _showOutletAddress,
                saving: _saving,
                onTaxChanged: (value) => setState(() => _taxEnabled = value),
                onServiceChanged: (value) {
                  setState(() => _serviceEnabled = value);
                },
                onShowAddressChanged: (value) {
                  setState(() => _showOutletAddress = value);
                },
                onSave: _save,
              );
              final preview = _ReceiptPreview(
                outletName: _outletNameController.text,
                outletAddress: _outletAddressController.text,
                outletPhone: _outletPhoneController.text,
                receiptHeader: _receiptHeaderController.text,
                receiptFooter: _receiptFooterController.text,
                taxEnabled: _taxEnabled,
                taxRate: _parsePercent(_taxRateController.text),
                serviceEnabled: _serviceEnabled,
                serviceRate: _parsePercent(_serviceRateController.text),
                showOutletAddress: _showOutletAddress,
              );

              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: form),
                    SizedBox(width: 360, child: preview),
                  ],
                );
              }
              return ListView(
                padding: EdgeInsets.zero,
                children: [form, preview],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Gagal memuat setting: $error')),
      ),
    );
  }

  void _hydrate(AppSetting settings) {
    _outletNameController.text = settings.outletName;
    _outletAddressController.text = settings.outletAddress ?? '';
    _outletPhoneController.text = settings.outletPhone ?? '';
    _receiptHeaderController.text = settings.receiptHeader ?? '';
    _receiptFooterController.text = settings.receiptFooter;
    _taxRateController.text = settings.taxRate.toString();
    _serviceRateController.text = settings.serviceRate.toString();
    _taxEnabled = settings.taxEnabled;
    _serviceEnabled = settings.serviceEnabled;
    _showOutletAddress = settings.showOutletAddress;
    _hydrated = true;
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await ref
          .read(appSettingsRepositoryProvider)
          .saveSettings(
            outletName: _outletNameController.text,
            outletAddress: _outletAddressController.text,
            outletPhone: _outletPhoneController.text,
            receiptHeader: _receiptHeaderController.text,
            receiptFooter: _receiptFooterController.text,
            taxEnabled: _taxEnabled,
            taxRate: _parsePercent(_taxRateController.text),
            serviceEnabled: _serviceEnabled,
            serviceRate: _parsePercent(_serviceRateController.text),
            showOutletAddress: _showOutletAddress,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Setting struk disimpan')));
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan: $error')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

class _SettingsForm extends StatelessWidget {
  const _SettingsForm({
    required this.outletNameController,
    required this.outletAddressController,
    required this.outletPhoneController,
    required this.receiptHeaderController,
    required this.receiptFooterController,
    required this.taxRateController,
    required this.serviceRateController,
    required this.taxEnabled,
    required this.serviceEnabled,
    required this.showOutletAddress,
    required this.saving,
    required this.onTaxChanged,
    required this.onServiceChanged,
    required this.onShowAddressChanged,
    required this.onSave,
  });

  final TextEditingController outletNameController;
  final TextEditingController outletAddressController;
  final TextEditingController outletPhoneController;
  final TextEditingController receiptHeaderController;
  final TextEditingController receiptFooterController;
  final TextEditingController taxRateController;
  final TextEditingController serviceRateController;
  final bool taxEnabled;
  final bool serviceEnabled;
  final bool showOutletAddress;
  final bool saving;
  final ValueChanged<bool> onTaxChanged;
  final ValueChanged<bool> onServiceChanged;
  final ValueChanged<bool> onShowAddressChanged;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        PataliCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SectionTitle('Outlet'),
              _LabeledTextField(
                label: 'Nama Outlet',
                hint: 'Contoh: Patali Coffee Bandung',
                controller: outletNameController,
              ),
              const SizedBox(height: 12),
              _LabeledTextField(
                label: 'Alamat Outlet',
                hint: 'Contoh: Jl. Merdeka No. 10, Bandung',
                controller: outletAddressController,
                minLines: 2,
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              _LabeledTextField(
                label: 'Nomor Telepon',
                hint: 'Contoh: 0812-3456-7890',
                controller: outletPhoneController,
                keyboardType: TextInputType.phone,
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Tampilkan alamat di struk'),
                value: showOutletAddress,
                onChanged: onShowAddressChanged,
              ),
              const SizedBox(height: 18),
              _SectionTitle('Template Struk'),
              _LabeledTextField(
                label: 'Header Struk',
                hint: 'Contoh: Selamat datang',
                controller: receiptHeaderController,
              ),
              const SizedBox(height: 12),
              _LabeledTextField(
                label: 'Footer Struk',
                hint: 'Contoh: Terima kasih, ditunggu kembali',
                controller: receiptFooterController,
              ),
              const SizedBox(height: 18),
              _SectionTitle('Pajak & Service'),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Aktifkan pajak'),
                value: taxEnabled,
                onChanged: onTaxChanged,
              ),
              if (taxEnabled) ...[
                const SizedBox(height: 8),
                _LabeledTextField(
                  label: 'Pajak (%)',
                  hint: 'Contoh: 10',
                  controller: taxRateController,
                  keyboardType: TextInputType.number,
                  suffixText: '%',
                ),
              ],
              const SizedBox(height: 8),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Aktifkan service charge'),
                value: serviceEnabled,
                onChanged: onServiceChanged,
              ),
              if (serviceEnabled) ...[
                const SizedBox(height: 8),
                _LabeledTextField(
                  label: 'Service Charge (%)',
                  hint: 'Contoh: 5',
                  controller: serviceRateController,
                  keyboardType: TextInputType.number,
                  suffixText: '%',
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
                label: const Text('Simpan Setting'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReceiptPreview extends StatelessWidget {
  const _ReceiptPreview({
    required this.outletName,
    required this.outletAddress,
    required this.outletPhone,
    required this.receiptHeader,
    required this.receiptFooter,
    required this.taxEnabled,
    required this.taxRate,
    required this.serviceEnabled,
    required this.serviceRate,
    required this.showOutletAddress,
  });

  final String outletName;
  final String outletAddress;
  final String outletPhone;
  final String receiptHeader;
  final String receiptFooter;
  final bool taxEnabled;
  final int taxRate;
  final bool serviceEnabled;
  final int serviceRate;
  final bool showOutletAddress;

  @override
  Widget build(BuildContext context) {
    final subtotal = 36000;
    final tax = taxEnabled ? (subtotal * taxRate / 100).round() : 0;
    final service = serviceEnabled ? (subtotal * serviceRate / 100).round() : 0;
    final total = subtotal + tax + service;

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        PataliCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Preview Struk',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F7F8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  _previewText(
                    outletName: outletName,
                    outletAddress: outletAddress,
                    outletPhone: outletPhone,
                    receiptHeader: receiptHeader,
                    receiptFooter: receiptFooter,
                    showOutletAddress: showOutletAddress,
                    subtotal: subtotal,
                    tax: tax,
                    service: service,
                    total: total,
                  ),
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    height: 1.3,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _previewText({
    required String outletName,
    required String outletAddress,
    required String outletPhone,
    required String receiptHeader,
    required String receiptFooter,
    required bool showOutletAddress,
    required int subtotal,
    required int tax,
    required int service,
    required int total,
  }) {
    final lines = <String>[
      _center(outletName.trim().isEmpty ? 'PATALI DEMO OUTLET' : outletName),
      if (receiptHeader.trim().isNotEmpty) _center(receiptHeader),
      if (showOutletAddress && outletAddress.trim().isNotEmpty)
        _center(outletAddress),
      if (showOutletAddress && outletPhone.trim().isNotEmpty)
        _center(outletPhone),
      '-' * 32,
      'INV-20260824-001',
      '24/08/2026 10:00',
      '-' * 32,
      'Kopi Susu',
      _columns('2 x Rp 18.000', 'Rp 36.000'),
      '-' * 32,
      _columns('Subtotal', _money(subtotal)),
      if (tax > 0) _columns('Pajak', _money(tax)),
      if (service > 0) _columns('Service', _money(service)),
      _columns('TOTAL', _money(total)),
      '-' * 32,
      _columns('TUNAI', _money(total)),
      '-' * 32,
      _center(receiptFooter.trim().isEmpty ? 'Terima kasih' : receiptFooter),
      '',
    ];
    return lines.join('\n');
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w900,
          fontSize: 15,
        ),
      ),
    );
  }
}

class _LabeledTextField extends StatelessWidget {
  const _LabeledTextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.suffixText,
    this.minLines,
    this.maxLines,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? suffixText;
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
          keyboardType: keyboardType,
          minLines: minLines,
          maxLines: maxLines,
          decoration: InputDecoration(hintText: hint, suffixText: suffixText),
        ),
      ],
    );
  }
}

int _parsePercent(String value) {
  return int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
}

String _center(String value) {
  final clipped = _clip(value.toUpperCase(), 32);
  final left = ((32 - clipped.length) / 2).floor();
  return '${' ' * left}$clipped';
}

String _columns(String left, String right) {
  final safeRight = _clip(right, 32);
  final maxLeft = 32 - safeRight.length - 1;
  final safeLeft = _clip(left, maxLeft);
  final gap = 32 - safeLeft.length - safeRight.length;
  return '$safeLeft${' ' * gap}$safeRight';
}

String _clip(String value, int maxLength) {
  if (value.length <= maxLength) return value;
  if (maxLength <= 1) return value.substring(0, maxLength);
  return '${value.substring(0, maxLength - 1)}.';
}

String _money(int value) {
  final raw = value.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < raw.length; i++) {
    final left = raw.length - i;
    buffer.write(raw[i]);
    if (left > 1 && left % 3 == 1) buffer.write('.');
  }
  return 'Rp $buffer';
}
