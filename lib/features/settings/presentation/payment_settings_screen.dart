import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/payment_settings_repository.dart';
import '../../../shared/widgets/patali_card.dart';
import '../../../shared/widgets/patali_shell.dart';

class PaymentSettingsScreen extends ConsumerStatefulWidget {
  const PaymentSettingsScreen({super.key});

  static const routePath = '/settings/payments';

  @override
  ConsumerState<PaymentSettingsScreen> createState() =>
      _PaymentSettingsScreenState();
}

class _PaymentSettingsScreenState extends ConsumerState<PaymentSettingsScreen> {
  final _qrisProviderController = TextEditingController();
  final _qrisMerchantIdController = TextEditingController();
  final _qrisInstructionController = TextEditingController();
  final _debitProviderController = TextEditingController();
  final _debitMerchantIdController = TextEditingController();
  final _debitInstructionController = TextEditingController();
  final _transferBankNameController = TextEditingController();
  final _transferAccountNumberController = TextEditingController();
  final _transferAccountNameController = TextEditingController();
  final _transferInstructionController = TextEditingController();

  bool _qrisEnabled = true;
  bool _debitEnabled = true;
  bool _transferEnabled = true;
  bool _hydrated = false;
  bool _saving = false;

  @override
  void dispose() {
    _qrisProviderController.dispose();
    _qrisMerchantIdController.dispose();
    _qrisInstructionController.dispose();
    _debitProviderController.dispose();
    _debitMerchantIdController.dispose();
    _debitInstructionController.dispose();
    _transferBankNameController.dispose();
    _transferAccountNumberController.dispose();
    _transferAccountNameController.dispose();
    _transferInstructionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(paymentSettingsProvider);

    return PataliShell(
      title: 'Pembayaran Nontunai',
      currentIndex: 4,
      child: settings.when(
        data: (data) {
          if (!_hydrated) _hydrate(data);
          return LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 900;
              final form = _PaymentForm(
                qrisEnabled: _qrisEnabled,
                debitEnabled: _debitEnabled,
                transferEnabled: _transferEnabled,
                saving: _saving,
                qrisProviderController: _qrisProviderController,
                qrisMerchantIdController: _qrisMerchantIdController,
                qrisInstructionController: _qrisInstructionController,
                debitProviderController: _debitProviderController,
                debitMerchantIdController: _debitMerchantIdController,
                debitInstructionController: _debitInstructionController,
                transferBankNameController: _transferBankNameController,
                transferAccountNumberController:
                    _transferAccountNumberController,
                transferAccountNameController: _transferAccountNameController,
                transferInstructionController: _transferInstructionController,
                onQrisChanged: (value) => setState(() => _qrisEnabled = value),
                onDebitChanged: (value) =>
                    setState(() => _debitEnabled = value),
                onTransferChanged: (value) {
                  setState(() => _transferEnabled = value);
                },
                onSave: _save,
              );
              final summary = _PaymentSummary(
                qrisEnabled: _qrisEnabled,
                debitEnabled: _debitEnabled,
                transferEnabled: _transferEnabled,
                qrisProvider: _qrisProviderController.text,
                debitProvider: _debitProviderController.text,
                transferBankName: _transferBankNameController.text,
              );

              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: form),
                    SizedBox(width: 360, child: summary),
                  ],
                );
              }
              return ListView(
                padding: EdgeInsets.zero,
                children: [form, summary],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Gagal memuat pembayaran: $error')),
      ),
    );
  }

  void _hydrate(PaymentSetting settings) {
    _qrisEnabled = settings.qrisEnabled;
    _qrisProviderController.text = settings.qrisProvider ?? '';
    _qrisMerchantIdController.text = settings.qrisMerchantId ?? '';
    _qrisInstructionController.text = settings.qrisInstruction ?? '';
    _debitEnabled = settings.debitEnabled;
    _debitProviderController.text = settings.debitProvider ?? '';
    _debitMerchantIdController.text = settings.debitMerchantId ?? '';
    _debitInstructionController.text = settings.debitInstruction ?? '';
    _transferEnabled = settings.transferEnabled;
    _transferBankNameController.text = settings.transferBankName ?? '';
    _transferAccountNumberController.text =
        settings.transferAccountNumber ?? '';
    _transferAccountNameController.text = settings.transferAccountName ?? '';
    _transferInstructionController.text = settings.transferInstruction ?? '';
    _hydrated = true;
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await ref
          .read(paymentSettingsRepositoryProvider)
          .saveSettings(
            qrisEnabled: _qrisEnabled,
            qrisProvider: _qrisProviderController.text,
            qrisMerchantId: _qrisMerchantIdController.text,
            qrisInstruction: _qrisInstructionController.text,
            debitEnabled: _debitEnabled,
            debitProvider: _debitProviderController.text,
            debitMerchantId: _debitMerchantIdController.text,
            debitInstruction: _debitInstructionController.text,
            transferEnabled: _transferEnabled,
            transferBankName: _transferBankNameController.text,
            transferAccountNumber: _transferAccountNumberController.text,
            transferAccountName: _transferAccountNameController.text,
            transferInstruction: _transferInstructionController.text,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Setting pembayaran disimpan')),
      );
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

class _PaymentForm extends StatelessWidget {
  const _PaymentForm({
    required this.qrisEnabled,
    required this.debitEnabled,
    required this.transferEnabled,
    required this.saving,
    required this.qrisProviderController,
    required this.qrisMerchantIdController,
    required this.qrisInstructionController,
    required this.debitProviderController,
    required this.debitMerchantIdController,
    required this.debitInstructionController,
    required this.transferBankNameController,
    required this.transferAccountNumberController,
    required this.transferAccountNameController,
    required this.transferInstructionController,
    required this.onQrisChanged,
    required this.onDebitChanged,
    required this.onTransferChanged,
    required this.onSave,
  });

  final bool qrisEnabled;
  final bool debitEnabled;
  final bool transferEnabled;
  final bool saving;
  final TextEditingController qrisProviderController;
  final TextEditingController qrisMerchantIdController;
  final TextEditingController qrisInstructionController;
  final TextEditingController debitProviderController;
  final TextEditingController debitMerchantIdController;
  final TextEditingController debitInstructionController;
  final TextEditingController transferBankNameController;
  final TextEditingController transferAccountNumberController;
  final TextEditingController transferAccountNameController;
  final TextEditingController transferInstructionController;
  final ValueChanged<bool> onQrisChanged;
  final ValueChanged<bool> onDebitChanged;
  final ValueChanged<bool> onTransferChanged;
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
              _PaymentSection(
                icon: Icons.qr_code_2,
                title: 'QRIS',
                enabled: qrisEnabled,
                onChanged: onQrisChanged,
                children: [
                  _LabeledTextField(
                    label: 'Provider',
                    hint: 'Contoh: Midtrans / Xendit / Bank BCA',
                    controller: qrisProviderController,
                  ),
                  const SizedBox(height: 12),
                  _LabeledTextField(
                    label: 'Merchant ID',
                    hint: 'Contoh: MID-123456',
                    controller: qrisMerchantIdController,
                  ),
                  const SizedBox(height: 12),
                  _LabeledTextField(
                    label: 'Instruksi',
                    hint: 'Contoh: Scan QRIS di layar kasir',
                    controller: qrisInstructionController,
                    minLines: 2,
                    maxLines: 3,
                  ),
                ],
              ),
              const Divider(height: 28),
              _PaymentSection(
                icon: Icons.credit_card,
                title: 'Debit',
                enabled: debitEnabled,
                onChanged: onDebitChanged,
                children: [
                  _LabeledTextField(
                    label: 'Provider / Acquirer',
                    hint: 'Contoh: BCA EDC',
                    controller: debitProviderController,
                  ),
                  const SizedBox(height: 12),
                  _LabeledTextField(
                    label: 'Merchant ID',
                    hint: 'Contoh: EDC-987654',
                    controller: debitMerchantIdController,
                  ),
                  const SizedBox(height: 12),
                  _LabeledTextField(
                    label: 'Instruksi',
                    hint: 'Contoh: Masukkan kartu ke EDC',
                    controller: debitInstructionController,
                    minLines: 2,
                    maxLines: 3,
                  ),
                ],
              ),
              const Divider(height: 28),
              _PaymentSection(
                icon: Icons.account_balance,
                title: 'Transfer',
                enabled: transferEnabled,
                onChanged: onTransferChanged,
                children: [
                  _LabeledTextField(
                    label: 'Bank',
                    hint: 'Contoh: BCA',
                    controller: transferBankNameController,
                  ),
                  const SizedBox(height: 12),
                  _LabeledTextField(
                    label: 'Nomor Rekening',
                    hint: 'Contoh: 1234567890',
                    controller: transferAccountNumberController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  _LabeledTextField(
                    label: 'Nama Rekening',
                    hint: 'Contoh: PT Patali Nusantara',
                    controller: transferAccountNameController,
                  ),
                  const SizedBox(height: 12),
                  _LabeledTextField(
                    label: 'Instruksi',
                    hint: 'Contoh: Transfer lalu tunjukkan bukti bayar',
                    controller: transferInstructionController,
                    minLines: 2,
                    maxLines: 3,
                  ),
                ],
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
                label: const Text('Simpan Pembayaran'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PaymentSection extends StatelessWidget {
  const _PaymentSection({
    required this.icon,
    required this.title,
    required this.enabled,
    required this.onChanged,
    required this.children,
  });

  final IconData icon;
  final String title;
  final bool enabled;
  final ValueChanged<bool> onChanged;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: Icon(icon, color: AppColors.primary),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          value: enabled,
          onChanged: onChanged,
        ),
        if (enabled) ...[const SizedBox(height: 8), ...children],
      ],
    );
  }
}

class _PaymentSummary extends StatelessWidget {
  const _PaymentSummary({
    required this.qrisEnabled,
    required this.debitEnabled,
    required this.transferEnabled,
    required this.qrisProvider,
    required this.debitProvider,
    required this.transferBankName,
  });

  final bool qrisEnabled;
  final bool debitEnabled;
  final bool transferEnabled;
  final String qrisProvider;
  final String debitProvider;
  final String transferBankName;

  @override
  Widget build(BuildContext context) {
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
                'Metode Aktif',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
              ),
              const SizedBox(height: 14),
              _StatusRow('Tunai', 'Selalu aktif'),
              _StatusRow(
                'QRIS',
                qrisEnabled ? _value(qrisProvider) : 'Nonaktif',
              ),
              _StatusRow(
                'Debit',
                debitEnabled ? _value(debitProvider) : 'Nonaktif',
              ),
              _StatusRow(
                'Transfer',
                transferEnabled ? _value(transferBankName) : 'Nonaktif',
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _value(String value) {
    return value.trim().isEmpty ? 'Aktif' : value.trim();
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

class _LabeledTextField extends StatelessWidget {
  const _LabeledTextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.minLines,
    this.maxLines,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
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
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    );
  }
}
