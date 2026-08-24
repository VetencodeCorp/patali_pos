import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../reports/presentation/sales_summary_screen.dart';
import 'category_management_screen.dart';
import 'product_management_screen.dart';
import '../../../shared/widgets/patali_shell.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const routePath = '/settings';

  @override
  Widget build(BuildContext context) {
    return PataliShell(
      title: 'Setting',
      currentIndex: 2,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(
            leading: Icon(Icons.storefront),
            title: Text('Outlet'),
            subtitle: Text('Patali Demo Outlet'),
          ),
          ListTile(
            leading: const Icon(Icons.inventory_2_outlined),
            title: const Text('Produk'),
            subtitle: const Text('Kelola produk lokal'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(ProductManagementScreen.routePath),
          ),
          ListTile(
            leading: const Icon(Icons.category_outlined),
            title: const Text('Kategori'),
            subtitle: const Text('Kelola kategori produk'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(CategoryManagementScreen.routePath),
          ),
          ListTile(
            leading: const Icon(Icons.analytics_outlined),
            title: const Text('Laporan harian'),
            subtitle: const Text('Total sales, order, cash/non-cash'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(SalesSummaryScreen.routePath),
          ),
          const ListTile(
            leading: Icon(Icons.people),
            title: Text('Role & Permission'),
            subtitle: Text('Disiapkan, enforcement menyusul'),
          ),
          const ListTile(
            leading: Icon(Icons.print),
            title: Text('Printer'),
            subtitle: Text('Bluetooth dan LAN'),
          ),
        ],
      ),
    );
  }
}
