import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patali_pos/data/database/app_database.dart';
import 'package:patali_pos/data/repositories/product_repository.dart';
import 'package:patali_pos/data/repositories/stock_movement_repository.dart';

void main() {
  late AppDatabase database;
  late ProductRepository products;
  late StockMovementRepository stockMovements;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    products = ProductRepository(database);
    stockMovements = StockMovementRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('adds stock and stores movement', () async {
    final product = await products.createProduct(
      name: 'Kopi Susu',
      price: 18000,
      trackStock: true,
      stockQty: 5,
    );

    await stockMovements.addStock(
      productId: product.id,
      qty: 10,
      note: 'Restock supplier',
    );

    final updatedProduct = await products.getProductById(product.id);
    final movements = await stockMovements.watchMovements().first;

    expect(updatedProduct?.stockQty, 15);
    expect(movements.single.movement.qtyChange, 10);
    expect(movements.single.movement.stockAfter, 15);
    expect(movements.single.movement.source, 'manual');
  });

  test('corrects stock and stores delta movement', () async {
    final product = await products.createProduct(
      name: 'Latte',
      price: 20000,
      trackStock: true,
      stockQty: 8,
    );

    await stockMovements.correctStock(productId: product.id, newStock: 3);

    final updatedProduct = await products.getProductById(product.id);
    final movements = await stockMovements.watchMovements().first;

    expect(updatedProduct?.stockQty, 3);
    expect(movements.single.movement.type, 'adjustment');
    expect(movements.single.movement.qtyChange, -5);
    expect(movements.single.movement.stockAfter, 3);
  });
}
