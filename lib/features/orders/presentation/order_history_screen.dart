import 'package:flutter/material.dart';

import '../../../shared/widgets/patali_shell.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  static const routePath = '/orders';

  @override
  Widget build(BuildContext context) {
    return const PataliShell(
      title: 'Riwayat Order',
      currentIndex: 1,
      child: Center(child: Text('Riwayat transaksi akan tampil di sini')),
    );
  }
}
