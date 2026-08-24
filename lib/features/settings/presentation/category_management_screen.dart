import 'package:flutter/material.dart';

import 'product_management_screen.dart';

class CategoryManagementScreen extends StatelessWidget {
  const CategoryManagementScreen({super.key});

  static const routePath = '/settings/categories';

  @override
  Widget build(BuildContext context) {
    return const ProductManagementScreen(initialTab: 1);
  }
}
