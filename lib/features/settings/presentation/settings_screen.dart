import 'package:flutter/material.dart';

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
        children: const [
          ListTile(
            leading: Icon(Icons.storefront),
            title: Text('Outlet'),
            subtitle: Text('Patali Demo Outlet'),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Role & Permission'),
            subtitle: Text('Disiapkan, enforcement menyusul'),
          ),
          ListTile(
            leading: Icon(Icons.print),
            title: Text('Printer'),
            subtitle: Text('Bluetooth dan LAN'),
          ),
        ],
      ),
    );
  }
}
