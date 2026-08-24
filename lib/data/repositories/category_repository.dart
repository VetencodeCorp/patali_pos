import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';
import 'product_repository.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepository(ref.watch(appDatabaseProvider));
});

final activeCategoriesProvider = StreamProvider<List<Category>>((ref) {
  ref.watch(devSeedProvider);
  return ref.watch(categoryRepositoryProvider).watchActiveCategories();
});

class CategoryRepository {
  CategoryRepository(this._database);

  final AppDatabase _database;
  final Uuid _uuid = const Uuid();

  Stream<List<Category>> watchActiveCategories() {
    final query = _database.select(_database.categories)
      ..where((category) {
        return category.isActive.equals(true) & category.deletedAt.isNull();
      })
      ..orderBy([
        (category) => OrderingTerm.asc(category.sortOrder),
        (category) => OrderingTerm.asc(category.name),
      ]);

    return query.watch();
  }

  Future<Category> createCategory({
    required String name,
    int sortOrder = 0,
  }) async {
    if (name.trim().isEmpty) {
      throw ArgumentError.value(name, 'name', 'Nama kategori wajib diisi');
    }

    final categoryId = _uuid.v4();
    await _database
        .into(_database.categories)
        .insert(
          CategoriesCompanion.insert(
            id: categoryId,
            name: name.trim(),
            sortOrder: Value(sortOrder),
          ),
        );

    return (_database.select(
      _database.categories,
    )..where((category) => category.id.equals(categoryId))).getSingle();
  }

  Future<void> updateCategory({
    required String id,
    required String name,
    required int sortOrder,
  }) async {
    if (name.trim().isEmpty) {
      throw ArgumentError.value(name, 'name', 'Nama kategori wajib diisi');
    }

    await (_database.update(
      _database.categories,
    )..where((category) => category.id.equals(id))).write(
      CategoriesCompanion(
        name: Value(name.trim()),
        sortOrder: Value(sortOrder),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deactivateCategory(String id) async {
    await (_database.update(
      _database.categories,
    )..where((category) => category.id.equals(id))).write(
      CategoriesCompanion(
        isActive: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteCategory(String id) async {
    await (_database.update(
      _database.categories,
    )..where((category) => category.id.equals(id))).write(
      CategoriesCompanion(
        isActive: const Value(false),
        deletedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
