import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patali_pos/data/database/app_database.dart';
import 'package:patali_pos/data/repositories/category_repository.dart';

void main() {
  late AppDatabase database;
  late CategoryRepository categories;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    categories = CategoryRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('creates updates deactivates and soft deletes category', () async {
    final category = await categories.createCategory(
      name: 'Snack',
      sortOrder: 3,
    );

    await categories.updateCategory(
      id: category.id,
      name: 'Cemilan',
      sortOrder: 4,
    );

    var activeCategories = await categories.watchActiveCategories().first;

    expect(activeCategories.single.name, 'Cemilan');
    expect(activeCategories.single.sortOrder, 4);

    await categories.deactivateCategory(category.id);
    activeCategories = await categories.watchActiveCategories().first;

    expect(activeCategories, isEmpty);

    await categories.deleteCategory(category.id);
    final rows = await database.select(database.categories).get();

    expect(rows.single.deletedAt, isNotNull);
    expect(rows.single.isActive, isFalse);
  });
}
