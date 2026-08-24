import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../features/orders/presentation/order_history_screen.dart';
import '../../features/pos/presentation/pos_screen.dart';
import '../../features/reports/presentation/sales_summary_screen.dart';
import '../../features/settings/presentation/product_management_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';

class PataliShell extends StatelessWidget {
  const PataliShell({
    super.key,
    required this.title,
    required this.currentIndex,
    required this.child,
    this.actions,
  });

  final String title;
  final int currentIndex;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 920;
        final sidebar = _PataliSidebar(currentIndex: currentIndex, wide: wide);

        return Scaffold(
          appBar: wide ? null : AppBar(title: Text(title), actions: actions),
          drawer: wide ? null : Drawer(child: SafeArea(child: sidebar)),
          body: SafeArea(
            child: Row(
              children: [
                if (wide) sidebar,
                Expanded(
                  child: Column(
                    children: [
                      if (wide) _DesktopHeader(title: title, actions: actions),
                      Expanded(child: child),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DesktopHeader extends StatelessWidget {
  const _DesktopHeader({required this.title, this.actions});

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          ...?actions,
        ],
      ),
    );
  }
}

class _PataliSidebar extends StatelessWidget {
  const _PataliSidebar({required this.currentIndex, required this.wide});

  final int currentIndex;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          width: wide ? 286 : null,
          color: AppColors.surface.withValues(alpha: 0.92),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryDark],
                        ),
                        borderRadius: BorderRadius.circular(17),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.18),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.hub, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Patali POS',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Demo Outlet',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.border),
              const SizedBox(height: 10),
              for (final item in _items)
                _SidebarItem(
                  item: item,
                  selected: currentIndex == item.index,
                  onTap: () {
                    if (!wide) Navigator.of(context).pop();
                    context.go(item.route);
                  },
                ),
              const Spacer(),
              const Divider(height: 1, color: AppColors.border),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Role Owner aktif\nPermission disiapkan bertahap',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            decoration: BoxDecoration(
              color: selected ? AppColors.softMint : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: selected
                  ? Border.all(color: AppColors.primary.withValues(alpha: 0.16))
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  selected ? item.activeIcon : item.icon,
                  color: selected ? AppColors.primary : AppColors.textSecondary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.label,
                    style: TextStyle(
                      fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
                      color: selected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const _items = [
  _NavItem(
    index: 0,
    label: 'Kasir',
    route: PosScreen.routePath,
    icon: Icons.point_of_sale_outlined,
    activeIcon: Icons.point_of_sale,
  ),
  _NavItem(
    index: 1,
    label: 'Daftar Order',
    route: OrderHistoryScreen.routePath,
    icon: Icons.receipt_long_outlined,
    activeIcon: Icons.receipt_long,
  ),
  _NavItem(
    index: 2,
    label: 'Laporan',
    route: SalesSummaryScreen.routePath,
    icon: Icons.analytics_outlined,
    activeIcon: Icons.analytics,
  ),
  _NavItem(
    index: 3,
    label: 'Inventori',
    route: ProductManagementScreen.routePath,
    icon: Icons.inventory_2_outlined,
    activeIcon: Icons.inventory_2,
  ),
  _NavItem(
    index: 4,
    label: 'Pengaturan',
    route: SettingsScreen.routePath,
    icon: Icons.settings_outlined,
    activeIcon: Icons.settings,
  ),
];

class _NavItem {
  const _NavItem({
    required this.index,
    required this.label,
    required this.route,
    required this.icon,
    required this.activeIcon,
  });

  final int index;
  final String label;
  final String route;
  final IconData icon;
  final IconData activeIcon;
}
