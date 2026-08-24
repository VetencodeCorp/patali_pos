import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/patali_card.dart';
import '../../../shared/widgets/patali_shell.dart';
import 'device_settings_screen.dart';
import 'product_management_screen.dart';
import 'receipt_tax_settings_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const routePath = '/settings';

  @override
  Widget build(BuildContext context) {
    return PataliShell(
      title: 'Pengaturan',
      currentIndex: 4,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _OutletCard(),
          const SizedBox(height: 18),
          const _SectionLabel('OPERASIONAL'),
          _SettingEntry(
            icon: Icons.inventory_2_outlined,
            title: 'Produk & Kategori',
            subtitle: 'Produk, kategori, harga, stok, aktif/nonaktif',
            onTap: () => context.push(ProductManagementScreen.routePath),
          ),
          _SettingEntry(
            icon: Icons.receipt_long_outlined,
            title: 'Struk & Pajak',
            subtitle: 'Template struk, pajak, service charge',
            onTap: () => context.push(ReceiptTaxSettingsScreen.routePath),
          ),
          _SettingEntry(
            icon: Icons.point_of_sale_outlined,
            title: 'Kasir',
            subtitle: 'Nomor order, metode bayar, kas harian',
            onTap: () {},
          ),
          _SettingEntry(
            icon: Icons.print_outlined,
            title: 'Perangkat',
            subtitle: 'Printer Bluetooth/LAN, cash drawer, scanner',
            onTap: () => context.push(DeviceSettingsScreen.routePath),
          ),
          _SettingEntry(
            icon: Icons.credit_card,
            title: 'Pembayaran Nontunai',
            subtitle: 'QRIS, transfer, EDC, integrasi payment gateway',
            onTap: () {},
          ),
          _SettingEntry(
            icon: Icons.local_offer_outlined,
            title: 'Promo & Diskon',
            subtitle: 'Diskon manual, voucher, aturan refund',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          const _SectionLabel('AKUN'),
          _SettingEntry(
            icon: Icons.people_alt_outlined,
            title: 'Role & Permission',
            subtitle: 'Struktur disiapkan, enforcement menyusul',
            onTap: () {},
          ),
          _SettingEntry(
            icon: Icons.workspace_premium_outlined,
            title: 'Subscription',
            subtitle: 'Trial, paket bulanan/tahunan, billing',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _OutletCard extends StatelessWidget {
  const _OutletCard();

  @override
  Widget build(BuildContext context) {
    return PataliCard(
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.mint],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(Icons.storefront, color: Colors.white),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Patali Demo Outlet',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Owner aktif - mode offline-first',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 2, 4, 8),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w900,
          fontSize: 12,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _SettingEntry extends StatelessWidget {
  const _SettingEntry({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: PataliCard(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.lavender,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
