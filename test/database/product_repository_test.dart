import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patali_pos/data/database/app_database.dart';
import 'package:patali_pos/data/repositories/category_repository.dart';
import 'package:patali_pos/data/repositories/product_repository.dart';

void main() {
  late AppDatabase database;
  late ProductRepository products;
  late CategoryRepository categories;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    products = ProductRepository(database);
    categories = CategoryRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('creates active product', () async {
    final product = await products.createProduct(
      name: 'Es Teh',
      price: 8000,
      sku: 'DRK-003',
      barcode: '899123',
      description: 'Teh dingin manis',
      imagePath: r'D:\images\es-teh.png',
      cost: 3000,
      trackStock: true,
      stockQty: 12,
      minStock: 5,
    );

    expect(product.name, 'Es Teh');
    expect(product.price, 8000);
    expect(product.sku, 'DRK-003');
    expect(product.barcode, '899123');
    expect(product.description, 'Teh dingin manis');
    expect(product.imagePath, r'D:\images\es-teh.png');
    expect(product.cost, 3000);
    expect(product.trackStock, isTrue);
    expect(product.stockQty, 12);
    expect(product.minStock, 5);

    final activeProducts = await products.watchActiveProducts().first;

    expect(activeProducts.single.name, 'Es Teh');
  });

  test('updates and deactivates product', () async {
    final product = await products.createProduct(
      name: 'Es Teh',
      price: 8000,
      sku: 'DRK-003',
    );

    await products.updateProduct(
      id: product.id,
      name: 'Es Teh Manis',
      price: 9000,
      sku: 'DRK-004',
      barcode: '899124',
      description: 'Teh manis jumbo',
      imagePath: r'D:\images\es-teh-manis.png',
      cost: 3500,
      trackStock: true,
      stockQty: 7,
      minStock: 3,
    );

    var activeProducts = await products.watchActiveProducts().first;

    expect(activeProducts.single.name, 'Es Teh Manis');
    expect(activeProducts.single.price, 9000);
    expect(activeProducts.single.sku, 'DRK-004');
    expect(activeProducts.single.barcode, '899124');
    expect(activeProducts.single.description, 'Teh manis jumbo');
    expect(activeProducts.single.imagePath, r'D:\images\es-teh-manis.png');
    expect(activeProducts.single.cost, 3500);
    expect(activeProducts.single.trackStock, isTrue);
    expect(activeProducts.single.stockQty, 7);
    expect(activeProducts.single.minStock, 3);

    await products.deactivateProduct(product.id);
    activeProducts = await products.watchActiveProducts().first;

    expect(activeProducts, isEmpty);
  });

  test('soft deletes product', () async {
    final product = await products.createProduct(
      name: 'Es Jeruk',
      price: 10000,
      sku: 'DRK-005',
    );

    await products.deleteProduct(product.id);

    final rows = await database.select(database.products).get();
    final activeProducts = await products.watchActiveProducts().first;

    expect(rows.single.deletedAt, isNotNull);
    expect(rows.single.isActive, isFalse);
    expect(activeProducts, isEmpty);
  });

  test('filters active products by category', () async {
    final drinks = await categories.createCategory(name: 'Minuman');
    final foods = await categories.createCategory(name: 'Makanan');

    await products.createProduct(
      name: 'Es Teh',
      price: 8000,
      categoryId: drinks.id,
    );
    await products.createProduct(
      name: 'Nasi Goreng',
      price: 28000,
      categoryId: foods.id,
    );

    final drinkProducts = await products
        .watchActiveProducts(categoryId: drinks.id)
        .first;

    expect(drinkProducts.single.name, 'Es Teh');
  });

  test('watches low stock products', () async {
    await products.createProduct(
      name: 'Kopi Susu',
      price: 18000,
      trackStock: true,
      stockQty: 3,
      minStock: 5,
    );
    await products.createProduct(
      name: 'Latte',
      price: 20000,
      trackStock: true,
      stockQty: 12,
      minStock: 5,
    );

    final lowStock = await products.watchLowStockProducts().first;

    expect(lowStock.single.name, 'Kopi Susu');
  });
}
