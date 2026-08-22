import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/orders/presentation/order_history_screen.dart';
import '../../features/pos/presentation/pos_screen.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      body: SafeArea(child: child),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => _goTo(context, index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.point_of_sale_outlined),
            selectedIcon: Icon(Icons.point_of_sale),
            label: 'POS',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Riwayat',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }

  void _goTo(BuildContext context, int index) {
    final route = switch (index) {
      0 => PosScreen.routePath,
      1 => OrderHistoryScreen.routePath,
      _ => SettingsScreen.routePath,
    };
    context.go(route);
  }
}
