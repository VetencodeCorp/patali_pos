import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/cashier_settings_repository.dart';
import '../../../shared/widgets/patali_card.dart';
import '../../../shared/widgets/patali_shell.dart';

class CashierSettingsScreen extends ConsumerStatefulWidget {
  const CashierSettingsScreen({super.key});

  static const routePath = '/settings/cashier';

  @override
  ConsumerState<CashierSettingsScreen> createState() =>
      _CashierSettingsScreenState();
}

class _CashierSettingsScreenState extends ConsumerState<CashierSettingsScreen> {
  final _invoicePrefixController = TextEditingController();

  bool _resetInvoiceDaily = true;
  String _defaultPaymentMethod = 'cash';
  String _defaultOrderType = 'Bungkus';
  bool _manualDiscountEnabled = true;
  bool _customerRequired = false;
  bool _hydrated = false;
  bool _saving = false;

  @override
  void dispose() {
    _invoicePrefixController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(cashierSettingsProvider);

    return PataliShell(
      title: 'Kasir',
      currentIndex: 4,
      child: settings.when(
        data: (data) {
          if (!_hydrated) _hydrate(data);
          return LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 900;
              final form = _CashierForm(
                invoicePrefixController: _invoicePrefixController,
                resetInvoiceDaily: _resetInvoiceDaily,
                defaultPaymentMethod: _defaultPaymentMethod,
                defaultOrderType: _defaultOrderType,
                manualDiscountEnabled: _manualDiscountEnabled,
                customerRequired: _customerRequired,
                saving: _saving,
                onResetDailyChanged: (value) {
                  setState(() => _resetInvoiceDaily = value);
                },
                onPaymentChanged: (value) {
                  if (value == null) return;
                  setState(() => _defaultPaymentMethod = value);
                },
                onOrderTypeChanged: (value) {
                  if (value == null) return;
                  setState(() => _defaultOrderType = value);
                },
                onDiscountChanged: (value) {
                  setState(() => _manualDiscountEnabled = value);
                },
                onCustomerRequiredChanged: (value) {
                  setState(() => _customerRequired = value);
                },
                onSave: _save,
              );
              final preview = _InvoicePreview(
                prefix: _invoicePrefixController.text,
                resetDaily: _resetInvoiceDaily,
                paymentMethod: _defaultPaymentMethod,
                orderType: _defaultOrderType,
                discountEnabled: _manualDiscountEnabled,
                customerRequired: _customerRequired,
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
            Center(child: Text('Gagal memuat setting kasir: $error')),
      ),
    );
  }

  void _hydrate(CashierSetting settings) {
    _invoicePrefixController.text = settings.invoicePrefix;
    _resetInvoiceDaily = settings.resetInvoiceDaily;
    _defaultPaymentMethod = settings.defaultPaymentMethod;
    _defaultOrderType = settings.defaultOrderType;
    _manualDiscountEnabled = settings.manualDiscountEnabled;
    _customerRequired = settings.customerRequired;
    _hydrated = true;
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await ref
          .read(cashierSettingsRepositoryProvider)
          .saveSettings(
            invoicePrefix: _invoicePrefixController.text,
            resetInvoiceDaily: _resetInvoiceDaily,
            defaultPaymentMethod: _defaultPaymentMethod,
            defaultOrderType: _defaultOrderType,
            manualDiscountEnabled: _manualDiscountEnabled,
            customerRequired: _customerRequired,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Setting kasir disimpan')));
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

class _CashierForm extends StatelessWidget {
  const _CashierForm({
    required this.invoicePrefixController,
    required this.resetInvoiceDaily,
    required this.defaultPaymentMethod,
    required this.defaultOrderType,
    required this.manualDiscountEnabled,
    required this.customerRequired,
    required this.saving,
    required this.onResetDailyChanged,
    required this.onPaymentChanged,
    required this.onOrderTypeChanged,
    required this.onDiscountChanged,
    required this.onCustomerRequiredChanged,
    required this.onSave,
  });

  final TextEditingController invoicePrefixController;
  final bool resetInvoiceDaily;
  final String defaultPaymentMethod;
  final String defaultOrderType;
  final bool manualDiscountEnabled;
  final bool customerRequired;
  final bool saving;
  final ValueChanged<bool> onResetDailyChanged;
  final ValueChanged<String?> onPaymentChanged;
  final ValueChanged<String?> onOrderTypeChanged;
  final ValueChanged<bool> onDiscountChanged;
  final ValueChanged<bool> onCustomerRequiredChanged;
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
              const _SectionTitle('Nomor Order'),
              _LabeledTextField(
                label: 'Prefix Invoice',
                hint: 'Contoh: INV',
                controller: invoicePrefixController,
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Reset nomor setiap hari'),
                subtitle: const Text('Format: INV-20260824-0001'),
                value: resetInvoiceDaily,
                onChanged: onResetDailyChanged,
              ),
              const SizedBox(height: 16),
              const _SectionTitle('Default POS'),
              _LabeledField(
                label: 'Metode Bayar Default',
                child: DropdownButtonFormField<String>(
                  initialValue: defaultPaymentMethod,
                  items: const [
                    DropdownMenuItem(value: 'cash', child: Text('Tunai')),
                    DropdownMenuItem(value: 'qris', child: Text('QRIS')),
                    DropdownMenuItem(value: 'debit', child: Text('Debit')),
                    DropdownMenuItem(
                      value: 'transfer',
                      child: Text('Transfer'),
                    ),
                  ],
                  onChanged: onPaymentChanged,
                ),
              ),
              const SizedBox(height: 12),
              _LabeledField(
                label: 'Jenis Order Default',
                child: DropdownButtonFormField<String>(
                  initialValue: defaultOrderType,
                  items: const [
                    DropdownMenuItem(value: 'Meja', child: Text('Meja')),
                    DropdownMenuItem(
                      value: 'Free Table',
                      child: Text('Free Table'),
                    ),
                    DropdownMenuItem(value: 'Bungkus', child: Text('Bungkus')),
                    DropdownMenuItem(
                      value: 'Pengiriman',
                      child: Text('Pengiriman'),
                    ),
                    DropdownMenuItem(
                      value: 'Ojek Online',
                      child: Text('Ojek Online'),
                    ),
                    DropdownMenuItem(
                      value: 'Quick Service',
                      child: Text('Quick Service'),
                    ),
                    DropdownMenuItem(
                      value: 'Reservasi',
                      child: Text('Reservasi'),
                    ),
                  ],
                  onChanged: onOrderTypeChanged,
                ),
              ),
              const SizedBox(height: 16),
              const _SectionTitle('Aturan Kasir'),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Diskon manual'),
                subtitle: const Text('Kasir boleh tambah diskon di cart'),
                value: manualDiscountEnabled,
                onChanged: onDiscountChanged,
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Wajib pilih pelanggan'),
                subtitle: const Text('Enforcement penuh menyusul'),
                value: customerRequired,
                onChanged: onCustomerRequiredChanged,
              ),
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
                label: const Text('Simpan Setting Kasir'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InvoicePreview extends StatelessWidget {
  const _InvoicePreview({
    required this.prefix,
    required this.resetDaily,
    required this.paymentMethod,
    required this.orderType,
    required this.discountEnabled,
    required this.customerRequired,
  });

  final String prefix;
  final bool resetDaily;
  final String paymentMethod;
  final String orderType;
  final bool discountEnabled;
  final bool customerRequired;

  @override
  Widget build(BuildContext context) {
    final safePrefix = prefix.trim().isEmpty
        ? 'INV'
        : prefix.trim().toUpperCase();
    final invoice = resetDaily
        ? '$safePrefix-20260824-0001'
        : '$safePrefix-0001';
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        PataliCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Preview Kasir',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
              ),
              const SizedBox(height: 14),
              _StatusRow('Invoice berikut', invoice),
              _StatusRow('Metode bayar', _paymentLabel(paymentMethod)),
              _StatusRow('Jenis order', orderType),
              _StatusRow(
                'Diskon manual',
                discountEnabled ? 'Aktif' : 'Nonaktif',
              ),
              _StatusRow('Pelanggan wajib', customerRequired ? 'Ya' : 'Tidak'),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w900)),
        ],
      ),
    );
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
  });

  final String label;
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return _LabeledField(
      label: label,
      child: TextField(
        controller: controller,
        textCapitalization: TextCapitalization.characters,
        decoration: InputDecoration(hintText: hint),
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

String _paymentLabel(String value) {
  return switch (value) {
    'cash' => 'Tunai',
    'qris' => 'QRIS',
    'debit' => 'Debit',
    'transfer' => 'Transfer',
    _ => value,
  };
}
