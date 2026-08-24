import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/device_settings_repository.dart';
import '../../../shared/widgets/patali_card.dart';
import '../../../shared/widgets/patali_shell.dart';

class DeviceSettingsScreen extends ConsumerStatefulWidget {
  const DeviceSettingsScreen({super.key});

  static const routePath = '/settings/devices';

  @override
  ConsumerState<DeviceSettingsScreen> createState() =>
      _DeviceSettingsScreenState();
}

class _DeviceSettingsScreenState extends ConsumerState<DeviceSettingsScreen> {
  final _printerNameController = TextEditingController();
  final _printerAddressController = TextEditingController();
  final _printerIpController = TextEditingController();
  final _printerPortController = TextEditingController(text: '9100');

  String _printerType = 'bluetooth';
  int _paperWidth = 58;
  bool _cashDrawerEnabled = false;
  bool _barcodeScannerEnabled = true;
  bool _hydrated = false;
  bool _saving = false;

  @override
  void dispose() {
    _printerNameController.dispose();
    _printerAddressController.dispose();
    _printerIpController.dispose();
    _printerPortController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(deviceSettingsProvider);

    return PataliShell(
      title: 'Perangkat',
      currentIndex: 4,
      child: settings.when(
        data: (data) {
          if (!_hydrated) _hydrate(data);
          return LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 900;
              final form = _DeviceForm(
                printerNameController: _printerNameController,
                printerAddressController: _printerAddressController,
                printerIpController: _printerIpController,
                printerPortController: _printerPortController,
                printerType: _printerType,
                paperWidth: _paperWidth,
                cashDrawerEnabled: _cashDrawerEnabled,
                barcodeScannerEnabled: _barcodeScannerEnabled,
                saving: _saving,
                onPrinterTypeChanged: (value) {
                  if (value == null) return;
                  setState(() => _printerType = value);
                },
                onPaperWidthChanged: (value) {
                  if (value == null) return;
                  setState(() => _paperWidth = value);
                },
                onCashDrawerChanged: (value) {
                  setState(() => _cashDrawerEnabled = value);
                },
                onBarcodeScannerChanged: (value) {
                  setState(() => _barcodeScannerEnabled = value);
                },
                onSave: _save,
                onTestPrint: _showTestPrintPreview,
              );
              final status = _DeviceStatusCard(
                printerType: _printerType,
                printerName: _printerNameController.text,
                printerIp: _printerIpController.text,
                printerPort: _parsePort(_printerPortController.text),
                paperWidth: _paperWidth,
                cashDrawerEnabled: _cashDrawerEnabled,
                barcodeScannerEnabled: _barcodeScannerEnabled,
              );

              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: form),
                    SizedBox(width: 360, child: status),
                  ],
                );
              }
              return ListView(
                padding: EdgeInsets.zero,
                children: [form, status],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Gagal memuat perangkat: $error')),
      ),
    );
  }

  void _hydrate(DeviceSetting settings) {
    _printerType = settings.printerType;
    _printerNameController.text = settings.printerName ?? '';
    _printerAddressController.text = settings.printerAddress ?? '';
    _printerIpController.text = settings.printerIp ?? '';
    _printerPortController.text = settings.printerPort.toString();
    _paperWidth = settings.paperWidth;
    _cashDrawerEnabled = settings.cashDrawerEnabled;
    _barcodeScannerEnabled = settings.barcodeScannerEnabled;
    _hydrated = true;
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await ref
          .read(deviceSettingsRepositoryProvider)
          .saveSettings(
            printerType: _printerType,
            printerName: _printerNameController.text,
            printerAddress: _printerAddressController.text,
            printerIp: _printerIpController.text,
            printerPort: _parsePort(_printerPortController.text),
            paperWidth: _paperWidth,
            cashDrawerEnabled: _cashDrawerEnabled,
            barcodeScannerEnabled: _barcodeScannerEnabled,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Setting perangkat disimpan')),
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

  Future<void> _showTestPrintPreview() {
    final text = _buildTestPrintText(
      printerType: _printerType,
      printerName: _printerNameController.text,
      paperWidth: _paperWidth,
    );
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Test Print'),
        content: SingleChildScrollView(
          child: SelectableText(
            text,
            style: const TextStyle(fontFamily: 'monospace', height: 1.25),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tutup'),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Test print siap. Integrasi printer menyusul.'),
                ),
              );
            },
            icon: const Icon(Icons.print_outlined),
            label: const Text('Simulasi Print'),
          ),
        ],
      ),
    );
  }
}

class _DeviceForm extends StatelessWidget {
  const _DeviceForm({
    required this.printerNameController,
    required this.printerAddressController,
    required this.printerIpController,
    required this.printerPortController,
    required this.printerType,
    required this.paperWidth,
    required this.cashDrawerEnabled,
    required this.barcodeScannerEnabled,
    required this.saving,
    required this.onPrinterTypeChanged,
    required this.onPaperWidthChanged,
    required this.onCashDrawerChanged,
    required this.onBarcodeScannerChanged,
    required this.onSave,
    required this.onTestPrint,
  });

  final TextEditingController printerNameController;
  final TextEditingController printerAddressController;
  final TextEditingController printerIpController;
  final TextEditingController printerPortController;
  final String printerType;
  final int paperWidth;
  final bool cashDrawerEnabled;
  final bool barcodeScannerEnabled;
  final bool saving;
  final ValueChanged<String?> onPrinterTypeChanged;
  final ValueChanged<int?> onPaperWidthChanged;
  final ValueChanged<bool> onCashDrawerChanged;
  final ValueChanged<bool> onBarcodeScannerChanged;
  final VoidCallback onSave;
  final VoidCallback onTestPrint;

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
              const _SectionTitle('Printer'),
              _LabeledField(
                label: 'Tipe Printer',
                child: DropdownButtonFormField<String>(
                  initialValue: printerType,
                  decoration: const InputDecoration(hintText: 'Pilih tipe'),
                  items: const [
                    DropdownMenuItem(
                      value: 'bluetooth',
                      child: Text('Bluetooth'),
                    ),
                    DropdownMenuItem(value: 'lan', child: Text('LAN')),
                  ],
                  onChanged: onPrinterTypeChanged,
                ),
              ),
              const SizedBox(height: 12),
              _LabeledTextField(
                label: 'Nama Printer',
                hint: 'Contoh: RPP02N / Kitchen Printer',
                controller: printerNameController,
              ),
              const SizedBox(height: 12),
              if (printerType == 'bluetooth')
                _LabeledTextField(
                  label: 'Alamat Bluetooth',
                  hint: 'Contoh: 00:11:22:33:AA:BB',
                  controller: printerAddressController,
                )
              else ...[
                _LabeledTextField(
                  label: 'IP Printer',
                  hint: 'Contoh: 192.168.1.50',
                  controller: printerIpController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                _LabeledTextField(
                  label: 'Port',
                  hint: 'Contoh: 9100',
                  controller: printerPortController,
                  keyboardType: TextInputType.number,
                ),
              ],
              const SizedBox(height: 12),
              _LabeledField(
                label: 'Lebar Kertas',
                child: SegmentedButton<int>(
                  segments: const [
                    ButtonSegment(value: 58, label: Text('58 mm')),
                    ButtonSegment(value: 80, label: Text('80 mm')),
                  ],
                  selected: {paperWidth},
                  onSelectionChanged: (values) {
                    onPaperWidthChanged(values.first);
                  },
                ),
              ),
              const SizedBox(height: 18),
              const _SectionTitle('Aksesori'),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Cash drawer'),
                subtitle: const Text('Buka laci dari perintah printer'),
                value: cashDrawerEnabled,
                onChanged: onCashDrawerChanged,
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Barcode scanner'),
                subtitle: const Text('Scanner keyboard wedge / input barcode'),
                value: barcodeScannerEnabled,
                onChanged: onBarcodeScannerChanged,
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: onTestPrint,
                icon: const Icon(Icons.print_outlined),
                label: const Text('Test Print'),
              ),
              const SizedBox(height: 10),
              FilledButton.icon(
                onPressed: saving ? null : onSave,
                icon: saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save_outlined),
                label: const Text('Simpan Perangkat'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DeviceStatusCard extends StatelessWidget {
  const _DeviceStatusCard({
    required this.printerType,
    required this.printerName,
    required this.printerIp,
    required this.printerPort,
    required this.paperWidth,
    required this.cashDrawerEnabled,
    required this.barcodeScannerEnabled,
  });

  final String printerType;
  final String printerName;
  final String printerIp;
  final int printerPort;
  final int paperWidth;
  final bool cashDrawerEnabled;
  final bool barcodeScannerEnabled;

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
                'Status Konfigurasi',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
              ),
              const SizedBox(height: 14),
              _StatusRow(
                'Printer',
                printerName.trim().isEmpty ? '-' : printerName,
              ),
              _StatusRow('Tipe', printerType == 'lan' ? 'LAN' : 'Bluetooth'),
              _StatusRow(
                'Koneksi',
                printerType == 'lan'
                    ? '${printerIp.trim().isEmpty ? '-' : printerIp}:$printerPort'
                    : 'Bluetooth paired device',
              ),
              _StatusRow('Kertas', '$paperWidth mm'),
              _StatusRow(
                'Cash drawer',
                cashDrawerEnabled ? 'Aktif' : 'Nonaktif',
              ),
              _StatusRow(
                'Barcode scanner',
                barcodeScannerEnabled ? 'Aktif' : 'Nonaktif',
              ),
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
    this.keyboardType,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return _LabeledField(
      label: label,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
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

int _parsePort(String value) {
  return int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 9100;
}

String _buildTestPrintText({
  required String printerType,
  required String printerName,
  required int paperWidth,
}) {
  final columns = paperWidth == 80 ? 42 : 32;
  final line = '-' * columns;
  return [
    _center('PATALI POS', columns),
    _center('TEST PRINT', columns),
    line,
    'Printer : ${printerName.trim().isEmpty ? '-' : printerName}',
    'Tipe    : ${printerType == 'lan' ? 'LAN' : 'Bluetooth'}',
    'Kertas  : $paperWidth mm',
    line,
    _columns('Kopi Susu', 'Rp 18.000', columns),
    _columns('TOTAL', 'Rp 18.000', columns),
    line,
    _center('Printer siap dikonfigurasi', columns),
    '',
  ].join('\n');
}

String _center(String value, int columns) {
  final text = _clip(value, columns);
  final left = ((columns - text.length) / 2).floor();
  return '${' ' * left}$text';
}

String _columns(String left, String right, int columns) {
  final safeRight = _clip(right, columns);
  final maxLeft = columns - safeRight.length - 1;
  final safeLeft = _clip(left, maxLeft);
  final gap = columns - safeLeft.length - safeRight.length;
  return '$safeLeft${' ' * gap}$safeRight';
}

String _clip(String value, int maxLength) {
  if (value.length <= maxLength) return value;
  if (maxLength <= 1) return value.substring(0, maxLength);
  return '${value.substring(0, maxLength - 1)}.';
}
