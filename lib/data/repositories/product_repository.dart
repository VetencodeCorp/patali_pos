import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository(ref.watch(appDatabaseProvider));
});

final activeProductsProvider = StreamProvider<List<Product>>((ref) {
  ref.watch(devSeedProvider);
  return ref.watch(productRepositoryProvider).watchActiveProducts();
});

final selectedCategoryIdProvider = StateProvider<String?>((ref) => null);

final filteredProductsProvider = StreamProvider<List<Product>>((ref) {
  ref.watch(devSeedProvider);
  final categoryId = ref.watch(selectedCategoryIdProvider);
  return ref
      .watch(productRepositoryProvider)
      .watchActiveProducts(categoryId: categoryId);
});

final devSeedProvider = FutureProvider<void>((ref) async {
  await ref.watch(productRepositoryProvider).seedDevProducts();
});

class ProductRepository {
  ProductRepository(this._database);

  final AppDatabase _database;
  final Uuid _uuid = const Uuid();

  Stream<List<Product>> watchActiveProducts({String? categoryId}) {
    final query = _database.select(_database.products)
      ..where((product) {
        final activeFilter =
            product.isActive.equals(true) & product.deletedAt.isNull();
        if (categoryId == null) return activeFilter;
        return activeFilter & product.categoryId.equals(categoryId);
      })
      ..orderBy([(product) => OrderingTerm.asc(product.name)]);

    return query.watch();
  }

  Future<Product> createProduct({
    required String name,
    required int price,
    String? sku,
    String? barcode,
    String? categoryId,
    bool trackStock = false,
    int stockQty = 0,
  }) async {
    if (name.trim().isEmpty) {
      throw ArgumentError.value(name, 'name', 'Nama produk wajib diisi');
    }
    if (price < 0) {
      throw ArgumentError.value(price, 'price', 'Harga tidak boleh negatif');
    }
    if (stockQty < 0) {
      throw ArgumentError.value(
        stockQty,
        'stockQty',
        'Stok tidak boleh negatif',
      );
    }

    final productId = _uuid.v4();
    await _database
        .into(_database.products)
        .insert(
          ProductsCompanion.insert(
            id: productId,
            categoryId: Value(categoryId),
            sku: Value(sku?.trim().isEmpty ?? true ? null : sku!.trim()),
            barcode: Value(
              barcode?.trim().isEmpty ?? true ? null : barcode!.trim(),
            ),
            name: name.trim(),
            price: price,
            trackStock: Value(trackStock),
            stockQty: Value(trackStock ? stockQty : 0),
          ),
        );

    return (_database.select(
      _database.products,
    )..where((product) => product.id.equals(productId))).getSingle();
  }

  Future<void> updateProduct({
    required String id,
    required String name,
    required int price,
    String? sku,
    String? barcode,
    String? categoryId,
    bool trackStock = false,
    int stockQty = 0,
  }) async {
    if (name.trim().isEmpty) {
      throw ArgumentError.value(name, 'name', 'Nama produk wajib diisi');
    }
    if (price < 0) {
      throw ArgumentError.value(price, 'price', 'Harga tidak boleh negatif');
    }
    if (stockQty < 0) {
      throw ArgumentError.value(
        stockQty,
        'stockQty',
        'Stok tidak boleh negatif',
      );
    }

    await (_database.update(
      _database.products,
    )..where((product) => product.id.equals(id))).write(
      ProductsCompanion(
        categoryId: Value(categoryId),
        sku: Value(sku?.trim().isEmpty ?? true ? null : sku!.trim()),
        barcode: Value(
          barcode?.trim().isEmpty ?? true ? null : barcode!.trim(),
        ),
        name: Value(name.trim()),
        price: Value(price),
        trackStock: Value(trackStock),
        stockQty: Value(trackStock ? stockQty : 0),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deactivateProduct(String id) async {
    await (_database.update(
      _database.products,
    )..where((product) => product.id.equals(id))).write(
      ProductsCompanion(
        isActive: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteProduct(String id) async {
    await (_database.update(
      _database.products,
    )..where((product) => product.id.equals(id))).write(
      ProductsCompanion(
        isActive: const Value(false),
        deletedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> seedDevProducts() async {
    final productCount = await _database
        .select(_database.products)
        .get()
        .then((rows) => rows.length);
    if (productCount > 0) return;

    await _database.batch((batch) {
      batch.insert(
        _database.categories,
        CategoriesCompanion.insert(
          id: 'cat-drinks',
          name: 'Minuman',
          sortOrder: const Value(1),
        ),
        mode: InsertMode.insertOrIgnore,
      );
      batch.insert(
        _database.categories,
        CategoriesCompanion.insert(
          id: 'cat-foods',
          name: 'Makanan',
          sortOrder: const Value(2),
        ),
        mode: InsertMode.insertOrIgnore,
      );
      batch.insertAll(_database.products, [
        ProductsCompanion.insert(
          id: 'prod-kopi-susu',
          categoryId: const Value('cat-drinks'),
          sku: const Value('DRK-001'),
          name: 'Kopi Susu',
          price: 18000,
        ),
        ProductsCompanion.insert(
          id: 'prod-americano',
          categoryId: const Value('cat-drinks'),
          sku: const Value('DRK-002'),
          name: 'Americano',
          price: 15000,
        ),
        ProductsCompanion.insert(
          id: 'prod-nasi-goreng',
          categoryId: const Value('cat-foods'),
          sku: const Value('FOD-001'),
          name: 'Nasi Goreng',
          price: 28000,
        ),
        ProductsCompanion.insert(
          id: 'prod-roti-bakar',
          categoryId: const Value('cat-foods'),
          sku: const Value('FOD-002'),
          name: 'Roti Bakar',
          price: 17000,
        ),
      ], mode: InsertMode.insertOrIgnore);
    });
  }
}
