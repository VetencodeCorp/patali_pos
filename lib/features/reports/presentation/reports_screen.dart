import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/patali_card.dart';
import '../../../shared/widgets/patali_shell.dart';
import 'product_sales_screen.dart';
import 'sales_summary_screen.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  static const routePath = '/reports';

  @override
  Widget build(BuildContext context) {
    return PataliShell(
      title: 'Laporan',
      currentIndex: 2,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ReportEntry(
            icon: Icons.assessment_outlined,
            title: 'Ringkasan Penjualan',
            subtitle: 'Omzet, transaksi, pembayaran, dan rata-rata order',
            onTap: () => context.push(SalesSummaryScreen.routePath),
          ),
          _ReportEntry(
            icon: Icons.cancel_outlined,
            title: 'Void',
            subtitle: 'Transaksi dibatalkan dan alasan void',
            onTap: () {},
          ),
          _ReportEntry(
            icon: Icons.point_of_sale_outlined,
            title: 'Kasir',
            subtitle: 'Shift, order kasir, dan aktivitas transaksi',
            onTap: () {},
          ),
          _ReportEntry(
            icon: Icons.account_balance_wallet_outlined,
            title: 'Kas Kasir',
            subtitle: 'Modal, uang fisik, dan selisih closing',
            onTap: () {},
          ),
          _ReportEntry(
            icon: Icons.inventory_2_outlined,
            title: 'Produk Terjual',
            subtitle: 'Produk paling laku dan kuantitas terjual',
            onTap: () => context.push(ProductSalesScreen.routePath),
          ),
        ],
      ),
    );
  }
}

class _ReportEntry extends StatelessWidget {
  const _ReportEntry({
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
                color: AppColors.softMint,
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
