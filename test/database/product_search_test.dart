import 'package:flutter_test/flutter_test.dart';
import 'package:patali_pos/data/database/app_database.dart';
import 'package:patali_pos/data/repositories/product_repository.dart';

void main() {
  test('matches products by name sku and barcode', () {
    final now = DateTime(2026, 8, 24);
    final product = Product(
      id: 'prod-kopi-susu',
      name: 'Kopi Susu',
      price: 18000,
      sku: 'DRK-001',
      barcode: '899001',
      trackStock: false,
      stockQty: 0,
      minStock: 0,
      isActive: true,
      createdAt: now,
    );

    expect(matchesProductSearch(product, 'kopi'), isTrue);
    expect(matchesProductSearch(product, 'DRK'), isTrue);
    expect(matchesProductSearch(product, '899001'), isTrue);
    expect(matchesProductSearch(product, 'nasi'), isFalse);
  });
}
