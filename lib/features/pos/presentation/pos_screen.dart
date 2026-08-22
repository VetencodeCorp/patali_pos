import 'package:flutter/material.dart';

import '../../../shared/widgets/patali_shell.dart';

class PosScreen extends StatelessWidget {
  const PosScreen({super.key});

  static const routePath = '/pos';

  @override
  Widget build(BuildContext context) {
    final products = [
      ('Kopi Susu', 18000),
      ('Americano', 15000),
      ('Nasi Goreng', 28000),
      ('Roti Bakar', 17000),
    ];

    return PataliShell(
      title: 'Kasir',
      currentIndex: 0,
      actions: [
        IconButton(
          tooltip: 'Scan barcode',
          onPressed: () {},
          icon: const Icon(Icons.qr_code_scanner),
        ),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 720;
          final productGrid = GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: wide ? 3 : 2,
              childAspectRatio: wide ? 1.7 : 1.25,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.$1,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        Text('Rp ${product.$2}'),
                      ],
                    ),
                  ),
                ),
              );
            },
          );

          final cart = _CartSummary(wide: wide);
          if (wide) {
            return Row(
              children: [
                Expanded(flex: 3, child: productGrid),
                SizedBox(width: 360, child: cart),
              ],
            );
          }
          return Column(
            children: [
              Expanded(child: productGrid),
              cart,
            ],
          );
        },
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  const _CartSummary({required this.wide});

  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: const Border(top: BorderSide(color: Color(0xFFE0E5E1))),
      ),
      child: Column(
        mainAxisSize: wide ? MainAxisSize.max : MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Cart', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          const Text('Belum ada item'),
          if (wide) const Spacer() else const SizedBox(height: 16),
          const Divider(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Total'), Text('Rp 0')],
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: null,
            icon: const Icon(Icons.payments),
            label: const Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
