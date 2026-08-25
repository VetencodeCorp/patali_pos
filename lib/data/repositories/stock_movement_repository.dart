import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';

final stockMovementRepositoryProvider = Provider<StockMovementRepository>((
  ref,
) {
  return StockMovementRepository(ref.watch(appDatabaseProvider));
});

final stockMovementsProvider = StreamProvider<List<StockMovementListItem>>((
  ref,
) {
  return ref.watch(stockMovementRepositoryProvider).watchMovements();
});

class StockMovementRepository {
  StockMovementRepository(this._database);

  final AppDatabase _database;
  final Uuid _uuid = const Uuid();

  Stream<List<StockMovementListItem>> watchMovements({String? productId}) {
    final query = _database.select(_database.stockMovements).join([
      innerJoin(
        _database.products,
        _database.products.id.equalsExp(_database.stockMovements.productId),
      ),
    ]);
    if (productId != null) {
      query.where(_database.stockMovements.productId.equals(productId));
    }
    query
      ..orderBy([OrderingTerm.desc(_database.stockMovements.createdAt)])
      ..limit(100);

    return query.watch().map((rows) {
      return [
        for (final row in rows)
          StockMovementListItem(
            movement: row.readTable(_database.stockMovements),
            product: row.readTable(_database.products),
          ),
      ];
    });
  }

  Future<void> addStock({
    required String productId,
    required int qty,
    String? note,
  }) {
    if (qty <= 0) {
      throw ArgumentError.value(qty, 'qty', 'Jumlah stok harus lebih dari 0');
    }
    return _moveStock(
      productId: productId,
      qtyChange: qty,
      type: 'in',
      source: 'manual',
      note: note,
    );
  }

  Future<void> correctStock({
    required String productId,
    required int newStock,
    String? note,
  }) async {
    if (newStock < 0) {
      throw ArgumentError.value(
        newStock,
        'newStock',
        'Stok tidak boleh negatif',
      );
    }
    final product = await _getProduct(productId);
    final qtyChange = newStock - product.stockQty;
    if (qtyChange == 0) return;
    await _writeMovement(
      product: product,
      qtyChange: qtyChange,
      stockAfter: newStock,
      type: 'adjustment',
      source: 'manual',
      note: note,
    );
  }

  Future<void> _moveStock({
    required String productId,
    required int qtyChange,
    required String type,
    String? source,
    String? note,
  }) async {
    final product = await _getProduct(productId);
    final stockAfter = product.stockQty + qtyChange;
    if (stockAfter < 0) {
      throw StateError('Stok ${product.name} tidak cukup');
    }
    await _writeMovement(
      product: product,
      qtyChange: qtyChange,
      stockAfter: stockAfter,
      type: type,
      source: source,
      note: note,
    );
  }

  Future<Product> _getProduct(String productId) async {
    final product = await (_database.select(
      _database.products,
    )..where((product) => product.id.equals(productId))).getSingleOrNull();
    if (product == null || product.deletedAt != null) {
      throw StateError('Produk tidak ditemukan');
    }
    if (!product.trackStock) {
      throw StateError('Produk ${product.name} tidak memakai stok');
    }
    return product;
  }

  Future<void> _writeMovement({
    required Product product,
    required int qtyChange,
    required int stockAfter,
    required String type,
    String? source,
    String? note,
  }) async {
    final now = DateTime.now();
    final cleanNote = note?.trim();
    await _database.transaction(() async {
      await (_database.update(
        _database.products,
      )..where((item) => item.id.equals(product.id))).write(
        ProductsCompanion(stockQty: Value(stockAfter), updatedAt: Value(now)),
      );
      await _database
          .into(_database.stockMovements)
          .insert(
            StockMovementsCompanion.insert(
              id: _uuid.v4(),
              productId: product.id,
              productName: product.name,
              type: type,
              qtyChange: qtyChange,
              stockAfter: stockAfter,
              source: Value(source),
              note: Value(
                cleanNote == null || cleanNote.isEmpty ? null : cleanNote,
              ),
              createdAt: Value(now),
            ),
          );
    });
  }
}

class StockMovementListItem {
  const StockMovementListItem({required this.movement, required this.product});

  final StockMovement movement;
  final Product product;
}
