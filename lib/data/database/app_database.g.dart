// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    sortOrder,
    isActive,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String name;
  final int sortOrder;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const Category({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      sortOrder: Value(sortOrder),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Category copyWith({
    String? id,
    String? name,
    int? sortOrder,
    bool? isActive,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    sortOrder,
    isActive,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? sortOrder,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
    'sku',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<int> price = GeneratedColumn<int>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<int> cost = GeneratedColumn<int>(
    'cost',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _trackStockMeta = const VerificationMeta(
    'trackStock',
  );
  @override
  late final GeneratedColumn<bool> trackStock = GeneratedColumn<bool>(
    'track_stock',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("track_stock" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _stockQtyMeta = const VerificationMeta(
    'stockQty',
  );
  @override
  late final GeneratedColumn<int> stockQty = GeneratedColumn<int>(
    'stock_qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _minStockMeta = const VerificationMeta(
    'minStock',
  );
  @override
  late final GeneratedColumn<int> minStock = GeneratedColumn<int>(
    'min_stock',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    sku,
    barcode,
    name,
    description,
    imagePath,
    price,
    cost,
    trackStock,
    stockQty,
    minStock,
    isActive,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('sku')) {
      context.handle(
        _skuMeta,
        sku.isAcceptableOrUnknown(data['sku']!, _skuMeta),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    }
    if (data.containsKey('track_stock')) {
      context.handle(
        _trackStockMeta,
        trackStock.isAcceptableOrUnknown(data['track_stock']!, _trackStockMeta),
      );
    }
    if (data.containsKey('stock_qty')) {
      context.handle(
        _stockQtyMeta,
        stockQty.isAcceptableOrUnknown(data['stock_qty']!, _stockQtyMeta),
      );
    }
    if (data.containsKey('min_stock')) {
      context.handle(
        _minStockMeta,
        minStock.isAcceptableOrUnknown(data['min_stock']!, _minStockMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      sku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku'],
      ),
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price'],
      )!,
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost'],
      ),
      trackStock: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}track_stock'],
      )!,
      stockQty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock_qty'],
      )!,
      minStock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_stock'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final String id;
  final String? categoryId;
  final String? sku;
  final String? barcode;
  final String name;
  final String? description;
  final String? imagePath;
  final int price;
  final int? cost;
  final bool trackStock;
  final int stockQty;
  final int minStock;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const Product({
    required this.id,
    this.categoryId,
    this.sku,
    this.barcode,
    required this.name,
    this.description,
    this.imagePath,
    required this.price,
    this.cost,
    required this.trackStock,
    required this.stockQty,
    required this.minStock,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['price'] = Variable<int>(price);
    if (!nullToAbsent || cost != null) {
      map['cost'] = Variable<int>(cost);
    }
    map['track_stock'] = Variable<bool>(trackStock);
    map['stock_qty'] = Variable<int>(stockQty);
    map['min_stock'] = Variable<int>(minStock);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      price: Value(price),
      cost: cost == null && nullToAbsent ? const Value.absent() : Value(cost),
      trackStock: Value(trackStock),
      stockQty: Value(stockQty),
      minStock: Value(minStock),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<String>(json['id']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      sku: serializer.fromJson<String?>(json['sku']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      price: serializer.fromJson<int>(json['price']),
      cost: serializer.fromJson<int?>(json['cost']),
      trackStock: serializer.fromJson<bool>(json['trackStock']),
      stockQty: serializer.fromJson<int>(json['stockQty']),
      minStock: serializer.fromJson<int>(json['minStock']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'categoryId': serializer.toJson<String?>(categoryId),
      'sku': serializer.toJson<String?>(sku),
      'barcode': serializer.toJson<String?>(barcode),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'imagePath': serializer.toJson<String?>(imagePath),
      'price': serializer.toJson<int>(price),
      'cost': serializer.toJson<int?>(cost),
      'trackStock': serializer.toJson<bool>(trackStock),
      'stockQty': serializer.toJson<int>(stockQty),
      'minStock': serializer.toJson<int>(minStock),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Product copyWith({
    String? id,
    Value<String?> categoryId = const Value.absent(),
    Value<String?> sku = const Value.absent(),
    Value<String?> barcode = const Value.absent(),
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> imagePath = const Value.absent(),
    int? price,
    Value<int?> cost = const Value.absent(),
    bool? trackStock,
    int? stockQty,
    int? minStock,
    bool? isActive,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Product(
    id: id ?? this.id,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    sku: sku.present ? sku.value : this.sku,
    barcode: barcode.present ? barcode.value : this.barcode,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    price: price ?? this.price,
    cost: cost.present ? cost.value : this.cost,
    trackStock: trackStock ?? this.trackStock,
    stockQty: stockQty ?? this.stockQty,
    minStock: minStock ?? this.minStock,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      sku: data.sku.present ? data.sku.value : this.sku,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      price: data.price.present ? data.price.value : this.price,
      cost: data.cost.present ? data.cost.value : this.cost,
      trackStock: data.trackStock.present
          ? data.trackStock.value
          : this.trackStock,
      stockQty: data.stockQty.present ? data.stockQty.value : this.stockQty,
      minStock: data.minStock.present ? data.minStock.value : this.minStock,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('sku: $sku, ')
          ..write('barcode: $barcode, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imagePath: $imagePath, ')
          ..write('price: $price, ')
          ..write('cost: $cost, ')
          ..write('trackStock: $trackStock, ')
          ..write('stockQty: $stockQty, ')
          ..write('minStock: $minStock, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    sku,
    barcode,
    name,
    description,
    imagePath,
    price,
    cost,
    trackStock,
    stockQty,
    minStock,
    isActive,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.sku == this.sku &&
          other.barcode == this.barcode &&
          other.name == this.name &&
          other.description == this.description &&
          other.imagePath == this.imagePath &&
          other.price == this.price &&
          other.cost == this.cost &&
          other.trackStock == this.trackStock &&
          other.stockQty == this.stockQty &&
          other.minStock == this.minStock &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> id;
  final Value<String?> categoryId;
  final Value<String?> sku;
  final Value<String?> barcode;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> imagePath;
  final Value<int> price;
  final Value<int?> cost;
  final Value<bool> trackStock;
  final Value<int> stockQty;
  final Value<int> minStock;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.sku = const Value.absent(),
    this.barcode = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.price = const Value.absent(),
    this.cost = const Value.absent(),
    this.trackStock = const Value.absent(),
    this.stockQty = const Value.absent(),
    this.minStock = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String id,
    this.categoryId = const Value.absent(),
    this.sku = const Value.absent(),
    this.barcode = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.imagePath = const Value.absent(),
    required int price,
    this.cost = const Value.absent(),
    this.trackStock = const Value.absent(),
    this.stockQty = const Value.absent(),
    this.minStock = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       price = Value(price);
  static Insertable<Product> custom({
    Expression<String>? id,
    Expression<String>? categoryId,
    Expression<String>? sku,
    Expression<String>? barcode,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? imagePath,
    Expression<int>? price,
    Expression<int>? cost,
    Expression<bool>? trackStock,
    Expression<int>? stockQty,
    Expression<int>? minStock,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (sku != null) 'sku': sku,
      if (barcode != null) 'barcode': barcode,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (imagePath != null) 'image_path': imagePath,
      if (price != null) 'price': price,
      if (cost != null) 'cost': cost,
      if (trackStock != null) 'track_stock': trackStock,
      if (stockQty != null) 'stock_qty': stockQty,
      if (minStock != null) 'min_stock': minStock,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<String>? id,
    Value<String?>? categoryId,
    Value<String?>? sku,
    Value<String?>? barcode,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? imagePath,
    Value<int>? price,
    Value<int?>? cost,
    Value<bool>? trackStock,
    Value<int>? stockQty,
    Value<int>? minStock,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      name: name ?? this.name,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      trackStock: trackStock ?? this.trackStock,
      stockQty: stockQty ?? this.stockQty,
      minStock: minStock ?? this.minStock,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (cost.present) {
      map['cost'] = Variable<int>(cost.value);
    }
    if (trackStock.present) {
      map['track_stock'] = Variable<bool>(trackStock.value);
    }
    if (stockQty.present) {
      map['stock_qty'] = Variable<int>(stockQty.value);
    }
    if (minStock.present) {
      map['min_stock'] = Variable<int>(minStock.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('sku: $sku, ')
          ..write('barcode: $barcode, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imagePath: $imagePath, ')
          ..write('price: $price, ')
          ..write('cost: $cost, ')
          ..write('trackStock: $trackStock, ')
          ..write('stockQty: $stockQty, ')
          ..write('minStock: $minStock, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StockMovementsTable extends StockMovements
    with TableInfo<$StockMovementsTable, StockMovement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockMovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtyChangeMeta = const VerificationMeta(
    'qtyChange',
  );
  @override
  late final GeneratedColumn<int> qtyChange = GeneratedColumn<int>(
    'qty_change',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stockAfterMeta = const VerificationMeta(
    'stockAfter',
  );
  @override
  late final GeneratedColumn<int> stockAfter = GeneratedColumn<int>(
    'stock_after',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    productName,
    type,
    qtyChange,
    stockAfter,
    source,
    note,
    createdAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_movements';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockMovement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('qty_change')) {
      context.handle(
        _qtyChangeMeta,
        qtyChange.isAcceptableOrUnknown(data['qty_change']!, _qtyChangeMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyChangeMeta);
    }
    if (data.containsKey('stock_after')) {
      context.handle(
        _stockAfterMeta,
        stockAfter.isAcceptableOrUnknown(data['stock_after']!, _stockAfterMeta),
      );
    } else if (isInserting) {
      context.missing(_stockAfterMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockMovement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockMovement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      qtyChange: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}qty_change'],
      )!,
      stockAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock_after'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $StockMovementsTable createAlias(String alias) {
    return $StockMovementsTable(attachedDatabase, alias);
  }
}

class StockMovement extends DataClass implements Insertable<StockMovement> {
  final String id;
  final String productId;
  final String productName;
  final String type;
  final int qtyChange;
  final int stockAfter;
  final String? source;
  final String? note;
  final DateTime createdAt;
  final DateTime? syncedAt;
  const StockMovement({
    required this.id,
    required this.productId,
    required this.productName,
    required this.type,
    required this.qtyChange,
    required this.stockAfter,
    this.source,
    this.note,
    required this.createdAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['product_id'] = Variable<String>(productId);
    map['product_name'] = Variable<String>(productName);
    map['type'] = Variable<String>(type);
    map['qty_change'] = Variable<int>(qtyChange);
    map['stock_after'] = Variable<int>(stockAfter);
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  StockMovementsCompanion toCompanion(bool nullToAbsent) {
    return StockMovementsCompanion(
      id: Value(id),
      productId: Value(productId),
      productName: Value(productName),
      type: Value(type),
      qtyChange: Value(qtyChange),
      stockAfter: Value(stockAfter),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory StockMovement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockMovement(
      id: serializer.fromJson<String>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      productName: serializer.fromJson<String>(json['productName']),
      type: serializer.fromJson<String>(json['type']),
      qtyChange: serializer.fromJson<int>(json['qtyChange']),
      stockAfter: serializer.fromJson<int>(json['stockAfter']),
      source: serializer.fromJson<String?>(json['source']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productId': serializer.toJson<String>(productId),
      'productName': serializer.toJson<String>(productName),
      'type': serializer.toJson<String>(type),
      'qtyChange': serializer.toJson<int>(qtyChange),
      'stockAfter': serializer.toJson<int>(stockAfter),
      'source': serializer.toJson<String?>(source),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  StockMovement copyWith({
    String? id,
    String? productId,
    String? productName,
    String? type,
    int? qtyChange,
    int? stockAfter,
    Value<String?> source = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => StockMovement(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    productName: productName ?? this.productName,
    type: type ?? this.type,
    qtyChange: qtyChange ?? this.qtyChange,
    stockAfter: stockAfter ?? this.stockAfter,
    source: source.present ? source.value : this.source,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  StockMovement copyWithCompanion(StockMovementsCompanion data) {
    return StockMovement(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      type: data.type.present ? data.type.value : this.type,
      qtyChange: data.qtyChange.present ? data.qtyChange.value : this.qtyChange,
      stockAfter: data.stockAfter.present
          ? data.stockAfter.value
          : this.stockAfter,
      source: data.source.present ? data.source.value : this.source,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockMovement(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('type: $type, ')
          ..write('qtyChange: $qtyChange, ')
          ..write('stockAfter: $stockAfter, ')
          ..write('source: $source, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    productName,
    type,
    qtyChange,
    stockAfter,
    source,
    note,
    createdAt,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockMovement &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.productName == this.productName &&
          other.type == this.type &&
          other.qtyChange == this.qtyChange &&
          other.stockAfter == this.stockAfter &&
          other.source == this.source &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.syncedAt == this.syncedAt);
}

class StockMovementsCompanion extends UpdateCompanion<StockMovement> {
  final Value<String> id;
  final Value<String> productId;
  final Value<String> productName;
  final Value<String> type;
  final Value<int> qtyChange;
  final Value<int> stockAfter;
  final Value<String?> source;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime?> syncedAt;
  final Value<int> rowid;
  const StockMovementsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.type = const Value.absent(),
    this.qtyChange = const Value.absent(),
    this.stockAfter = const Value.absent(),
    this.source = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StockMovementsCompanion.insert({
    required String id,
    required String productId,
    required String productName,
    required String type,
    required int qtyChange,
    required int stockAfter,
    this.source = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       productId = Value(productId),
       productName = Value(productName),
       type = Value(type),
       qtyChange = Value(qtyChange),
       stockAfter = Value(stockAfter);
  static Insertable<StockMovement> custom({
    Expression<String>? id,
    Expression<String>? productId,
    Expression<String>? productName,
    Expression<String>? type,
    Expression<int>? qtyChange,
    Expression<int>? stockAfter,
    Expression<String>? source,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (type != null) 'type': type,
      if (qtyChange != null) 'qty_change': qtyChange,
      if (stockAfter != null) 'stock_after': stockAfter,
      if (source != null) 'source': source,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StockMovementsCompanion copyWith({
    Value<String>? id,
    Value<String>? productId,
    Value<String>? productName,
    Value<String>? type,
    Value<int>? qtyChange,
    Value<int>? stockAfter,
    Value<String?>? source,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime?>? syncedAt,
    Value<int>? rowid,
  }) {
    return StockMovementsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      type: type ?? this.type,
      qtyChange: qtyChange ?? this.qtyChange,
      stockAfter: stockAfter ?? this.stockAfter,
      source: source ?? this.source,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (qtyChange.present) {
      map['qty_change'] = Variable<int>(qtyChange.value);
    }
    if (stockAfter.present) {
      map['stock_after'] = Variable<int>(stockAfter.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockMovementsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('type: $type, ')
          ..write('qtyChange: $qtyChange, ')
          ..write('stockAfter: $stockAfter, ')
          ..write('source: $source, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RolesTable extends Roles with TableInfo<$RolesTable, Role> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RolesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    code,
    description,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'roles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Role> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Role map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Role(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $RolesTable createAlias(String alias) {
    return $RolesTable(attachedDatabase, alias);
  }
}

class Role extends DataClass implements Insertable<Role> {
  final String id;
  final String name;
  final String code;
  final String? description;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Role({
    required this.id,
    required this.name,
    required this.code,
    this.description,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  RolesCompanion toCompanion(bool nullToAbsent) {
    return RolesCompanion(
      id: Value(id),
      name: Value(name),
      code: Value(code),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Role.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Role(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String>(json['code']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String>(code),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Role copyWith({
    String? id,
    String? name,
    String? code,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Role(
    id: id ?? this.id,
    name: name ?? this.name,
    code: code ?? this.code,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Role copyWithCompanion(RolesCompanion data) {
    return Role(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Role(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, code, description, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Role &&
          other.id == this.id &&
          other.name == this.name &&
          other.code == this.code &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RolesCompanion extends UpdateCompanion<Role> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> code;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const RolesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RolesCompanion.insert({
    required String id,
    required String name,
    required String code,
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       code = Value(code);
  static Insertable<Role> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? code,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RolesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? code,
    Value<String?>? description,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return RolesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RolesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PermissionsTable extends Permissions
    with TableInfo<$PermissionsTable, Permission> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PermissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    code,
    description,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'permissions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Permission> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Permission map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Permission(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $PermissionsTable createAlias(String alias) {
    return $PermissionsTable(attachedDatabase, alias);
  }
}

class Permission extends DataClass implements Insertable<Permission> {
  final String id;
  final String name;
  final String code;
  final String? description;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Permission({
    required this.id,
    required this.name,
    required this.code,
    this.description,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  PermissionsCompanion toCompanion(bool nullToAbsent) {
    return PermissionsCompanion(
      id: Value(id),
      name: Value(name),
      code: Value(code),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Permission.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Permission(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String>(json['code']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String>(code),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Permission copyWith({
    String? id,
    String? name,
    String? code,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Permission(
    id: id ?? this.id,
    name: name ?? this.name,
    code: code ?? this.code,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Permission copyWithCompanion(PermissionsCompanion data) {
    return Permission(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Permission(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, code, description, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Permission &&
          other.id == this.id &&
          other.name == this.name &&
          other.code == this.code &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PermissionsCompanion extends UpdateCompanion<Permission> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> code;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const PermissionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PermissionsCompanion.insert({
    required String id,
    required String name,
    required String code,
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       code = Value(code);
  static Insertable<Permission> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? code,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PermissionsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? code,
    Value<String?>? description,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return PermissionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PermissionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RolePermissionsTable extends RolePermissions
    with TableInfo<$RolePermissionsTable, RolePermission> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RolePermissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _roleIdMeta = const VerificationMeta('roleId');
  @override
  late final GeneratedColumn<String> roleId = GeneratedColumn<String>(
    'role_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES roles (id)',
    ),
  );
  static const VerificationMeta _permissionIdMeta = const VerificationMeta(
    'permissionId',
  );
  @override
  late final GeneratedColumn<String> permissionId = GeneratedColumn<String>(
    'permission_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES permissions (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [roleId, permissionId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'role_permissions';
  @override
  VerificationContext validateIntegrity(
    Insertable<RolePermission> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('role_id')) {
      context.handle(
        _roleIdMeta,
        roleId.isAcceptableOrUnknown(data['role_id']!, _roleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_roleIdMeta);
    }
    if (data.containsKey('permission_id')) {
      context.handle(
        _permissionIdMeta,
        permissionId.isAcceptableOrUnknown(
          data['permission_id']!,
          _permissionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_permissionIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {roleId, permissionId};
  @override
  RolePermission map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RolePermission(
      roleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role_id'],
      )!,
      permissionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}permission_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RolePermissionsTable createAlias(String alias) {
    return $RolePermissionsTable(attachedDatabase, alias);
  }
}

class RolePermission extends DataClass implements Insertable<RolePermission> {
  final String roleId;
  final String permissionId;
  final DateTime createdAt;
  const RolePermission({
    required this.roleId,
    required this.permissionId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['role_id'] = Variable<String>(roleId);
    map['permission_id'] = Variable<String>(permissionId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RolePermissionsCompanion toCompanion(bool nullToAbsent) {
    return RolePermissionsCompanion(
      roleId: Value(roleId),
      permissionId: Value(permissionId),
      createdAt: Value(createdAt),
    );
  }

  factory RolePermission.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RolePermission(
      roleId: serializer.fromJson<String>(json['roleId']),
      permissionId: serializer.fromJson<String>(json['permissionId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'roleId': serializer.toJson<String>(roleId),
      'permissionId': serializer.toJson<String>(permissionId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RolePermission copyWith({
    String? roleId,
    String? permissionId,
    DateTime? createdAt,
  }) => RolePermission(
    roleId: roleId ?? this.roleId,
    permissionId: permissionId ?? this.permissionId,
    createdAt: createdAt ?? this.createdAt,
  );
  RolePermission copyWithCompanion(RolePermissionsCompanion data) {
    return RolePermission(
      roleId: data.roleId.present ? data.roleId.value : this.roleId,
      permissionId: data.permissionId.present
          ? data.permissionId.value
          : this.permissionId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RolePermission(')
          ..write('roleId: $roleId, ')
          ..write('permissionId: $permissionId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(roleId, permissionId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RolePermission &&
          other.roleId == this.roleId &&
          other.permissionId == this.permissionId &&
          other.createdAt == this.createdAt);
}

class RolePermissionsCompanion extends UpdateCompanion<RolePermission> {
  final Value<String> roleId;
  final Value<String> permissionId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RolePermissionsCompanion({
    this.roleId = const Value.absent(),
    this.permissionId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RolePermissionsCompanion.insert({
    required String roleId,
    required String permissionId,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : roleId = Value(roleId),
       permissionId = Value(permissionId);
  static Insertable<RolePermission> custom({
    Expression<String>? roleId,
    Expression<String>? permissionId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (roleId != null) 'role_id': roleId,
      if (permissionId != null) 'permission_id': permissionId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RolePermissionsCompanion copyWith({
    Value<String>? roleId,
    Value<String>? permissionId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return RolePermissionsCompanion(
      roleId: roleId ?? this.roleId,
      permissionId: permissionId ?? this.permissionId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (roleId.present) {
      map['role_id'] = Variable<String>(roleId.value);
    }
    if (permissionId.present) {
      map['permission_id'] = Variable<String>(permissionId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RolePermissionsCompanion(')
          ..write('roleId: $roleId, ')
          ..write('permissionId: $permissionId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleIdMeta = const VerificationMeta('roleId');
  @override
  late final GeneratedColumn<String> roleId = GeneratedColumn<String>(
    'role_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES roles (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pinHashMeta = const VerificationMeta(
    'pinHash',
  );
  @override
  late final GeneratedColumn<String> pinHash = GeneratedColumn<String>(
    'pin_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    roleId,
    name,
    email,
    pinHash,
    isActive,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('role_id')) {
      context.handle(
        _roleIdMeta,
        roleId.isAcceptableOrUnknown(data['role_id']!, _roleIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('pin_hash')) {
      context.handle(
        _pinHashMeta,
        pinHash.isAcceptableOrUnknown(data['pin_hash']!, _pinHashMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      roleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      pinHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin_hash'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String? roleId;
  final String name;
  final String? email;
  final String? pinHash;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const User({
    required this.id,
    this.roleId,
    required this.name,
    this.email,
    this.pinHash,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || roleId != null) {
      map['role_id'] = Variable<String>(roleId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || pinHash != null) {
      map['pin_hash'] = Variable<String>(pinHash);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      roleId: roleId == null && nullToAbsent
          ? const Value.absent()
          : Value(roleId),
      name: Value(name),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      pinHash: pinHash == null && nullToAbsent
          ? const Value.absent()
          : Value(pinHash),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      roleId: serializer.fromJson<String?>(json['roleId']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      pinHash: serializer.fromJson<String?>(json['pinHash']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'roleId': serializer.toJson<String?>(roleId),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String?>(email),
      'pinHash': serializer.toJson<String?>(pinHash),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  User copyWith({
    String? id,
    Value<String?> roleId = const Value.absent(),
    String? name,
    Value<String?> email = const Value.absent(),
    Value<String?> pinHash = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => User(
    id: id ?? this.id,
    roleId: roleId.present ? roleId.value : this.roleId,
    name: name ?? this.name,
    email: email.present ? email.value : this.email,
    pinHash: pinHash.present ? pinHash.value : this.pinHash,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      roleId: data.roleId.present ? data.roleId.value : this.roleId,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      pinHash: data.pinHash.present ? data.pinHash.value : this.pinHash,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('roleId: $roleId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('pinHash: $pinHash, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    roleId,
    name,
    email,
    pinHash,
    isActive,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.roleId == this.roleId &&
          other.name == this.name &&
          other.email == this.email &&
          other.pinHash == this.pinHash &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String?> roleId;
  final Value<String> name;
  final Value<String?> email;
  final Value<String?> pinHash;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.roleId = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.pinHash = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    this.roleId = const Value.absent(),
    required String name,
    this.email = const Value.absent(),
    this.pinHash = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? roleId,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? pinHash,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (roleId != null) 'role_id': roleId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (pinHash != null) 'pin_hash': pinHash,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String?>? roleId,
    Value<String>? name,
    Value<String?>? email,
    Value<String?>? pinHash,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      roleId: roleId ?? this.roleId,
      name: name ?? this.name,
      email: email ?? this.email,
      pinHash: pinHash ?? this.pinHash,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (roleId.present) {
      map['role_id'] = Variable<String>(roleId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (pinHash.present) {
      map['pin_hash'] = Variable<String>(pinHash.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('roleId: $roleId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('pinHash: $pinHash, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    phone,
    email,
    address,
    note,
    isActive,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final String id;
  final String name;
  final String? phone;
  final String? email;
  final String? address;
  final String? note;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const Customer({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    this.address,
    this.note,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      note: serializer.fromJson<String?>(json['note']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'note': serializer.toJson<String?>(note),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Customer copyWith({
    String? id,
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> note = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Customer(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    address: address.present ? address.value : this.address,
    note: note.present ? note.value : this.note,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      note: data.note.present ? data.note.value : this.note,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('note: $note, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    phone,
    email,
    address,
    note,
    isActive,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.address == this.address &&
          other.note == this.note &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> address;
  final Value<String?> note;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.note = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomersCompanion.insert({
    required String id,
    required String name,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.note = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Customer> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? address,
    Expression<String>? note,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (note != null) 'note': note,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? address,
    Value<String?>? note,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      note: note ?? this.note,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('note: $note, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CashSessionsTable extends CashSessions
    with TableInfo<$CashSessionsTable, CashSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openedByUserIdMeta = const VerificationMeta(
    'openedByUserId',
  );
  @override
  late final GeneratedColumn<String> openedByUserId = GeneratedColumn<String>(
    'opened_by_user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _closedByUserIdMeta = const VerificationMeta(
    'closedByUserId',
  );
  @override
  late final GeneratedColumn<String> closedByUserId = GeneratedColumn<String>(
    'closed_by_user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _openedAtMeta = const VerificationMeta(
    'openedAt',
  );
  @override
  late final GeneratedColumn<DateTime> openedAt = GeneratedColumn<DateTime>(
    'opened_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _closedAtMeta = const VerificationMeta(
    'closedAt',
  );
  @override
  late final GeneratedColumn<DateTime> closedAt = GeneratedColumn<DateTime>(
    'closed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _openingCashMeta = const VerificationMeta(
    'openingCash',
  );
  @override
  late final GeneratedColumn<int> openingCash = GeneratedColumn<int>(
    'opening_cash',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _closingCashMeta = const VerificationMeta(
    'closingCash',
  );
  @override
  late final GeneratedColumn<int> closingCash = GeneratedColumn<int>(
    'closing_cash',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expectedCashMeta = const VerificationMeta(
    'expectedCash',
  );
  @override
  late final GeneratedColumn<int> expectedCash = GeneratedColumn<int>(
    'expected_cash',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('open'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    openedByUserId,
    closedByUserId,
    openedAt,
    closedAt,
    openingCash,
    closingCash,
    expectedCash,
    note,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cash_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<CashSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('opened_by_user_id')) {
      context.handle(
        _openedByUserIdMeta,
        openedByUserId.isAcceptableOrUnknown(
          data['opened_by_user_id']!,
          _openedByUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_openedByUserIdMeta);
    }
    if (data.containsKey('closed_by_user_id')) {
      context.handle(
        _closedByUserIdMeta,
        closedByUserId.isAcceptableOrUnknown(
          data['closed_by_user_id']!,
          _closedByUserIdMeta,
        ),
      );
    }
    if (data.containsKey('opened_at')) {
      context.handle(
        _openedAtMeta,
        openedAt.isAcceptableOrUnknown(data['opened_at']!, _openedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_openedAtMeta);
    }
    if (data.containsKey('closed_at')) {
      context.handle(
        _closedAtMeta,
        closedAt.isAcceptableOrUnknown(data['closed_at']!, _closedAtMeta),
      );
    }
    if (data.containsKey('opening_cash')) {
      context.handle(
        _openingCashMeta,
        openingCash.isAcceptableOrUnknown(
          data['opening_cash']!,
          _openingCashMeta,
        ),
      );
    }
    if (data.containsKey('closing_cash')) {
      context.handle(
        _closingCashMeta,
        closingCash.isAcceptableOrUnknown(
          data['closing_cash']!,
          _closingCashMeta,
        ),
      );
    }
    if (data.containsKey('expected_cash')) {
      context.handle(
        _expectedCashMeta,
        expectedCash.isAcceptableOrUnknown(
          data['expected_cash']!,
          _expectedCashMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      openedByUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}opened_by_user_id'],
      )!,
      closedByUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}closed_by_user_id'],
      ),
      openedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}opened_at'],
      )!,
      closedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}closed_at'],
      ),
      openingCash: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}opening_cash'],
      )!,
      closingCash: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}closing_cash'],
      ),
      expectedCash: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expected_cash'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $CashSessionsTable createAlias(String alias) {
    return $CashSessionsTable(attachedDatabase, alias);
  }
}

class CashSession extends DataClass implements Insertable<CashSession> {
  final String id;
  final String openedByUserId;
  final String? closedByUserId;
  final DateTime openedAt;
  final DateTime? closedAt;
  final int openingCash;
  final int? closingCash;
  final int? expectedCash;
  final String? note;
  final String status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const CashSession({
    required this.id,
    required this.openedByUserId,
    this.closedByUserId,
    required this.openedAt,
    this.closedAt,
    required this.openingCash,
    this.closingCash,
    this.expectedCash,
    this.note,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['opened_by_user_id'] = Variable<String>(openedByUserId);
    if (!nullToAbsent || closedByUserId != null) {
      map['closed_by_user_id'] = Variable<String>(closedByUserId);
    }
    map['opened_at'] = Variable<DateTime>(openedAt);
    if (!nullToAbsent || closedAt != null) {
      map['closed_at'] = Variable<DateTime>(closedAt);
    }
    map['opening_cash'] = Variable<int>(openingCash);
    if (!nullToAbsent || closingCash != null) {
      map['closing_cash'] = Variable<int>(closingCash);
    }
    if (!nullToAbsent || expectedCash != null) {
      map['expected_cash'] = Variable<int>(expectedCash);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  CashSessionsCompanion toCompanion(bool nullToAbsent) {
    return CashSessionsCompanion(
      id: Value(id),
      openedByUserId: Value(openedByUserId),
      closedByUserId: closedByUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(closedByUserId),
      openedAt: Value(openedAt),
      closedAt: closedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(closedAt),
      openingCash: Value(openingCash),
      closingCash: closingCash == null && nullToAbsent
          ? const Value.absent()
          : Value(closingCash),
      expectedCash: expectedCash == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedCash),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory CashSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashSession(
      id: serializer.fromJson<String>(json['id']),
      openedByUserId: serializer.fromJson<String>(json['openedByUserId']),
      closedByUserId: serializer.fromJson<String?>(json['closedByUserId']),
      openedAt: serializer.fromJson<DateTime>(json['openedAt']),
      closedAt: serializer.fromJson<DateTime?>(json['closedAt']),
      openingCash: serializer.fromJson<int>(json['openingCash']),
      closingCash: serializer.fromJson<int?>(json['closingCash']),
      expectedCash: serializer.fromJson<int?>(json['expectedCash']),
      note: serializer.fromJson<String?>(json['note']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'openedByUserId': serializer.toJson<String>(openedByUserId),
      'closedByUserId': serializer.toJson<String?>(closedByUserId),
      'openedAt': serializer.toJson<DateTime>(openedAt),
      'closedAt': serializer.toJson<DateTime?>(closedAt),
      'openingCash': serializer.toJson<int>(openingCash),
      'closingCash': serializer.toJson<int?>(closingCash),
      'expectedCash': serializer.toJson<int?>(expectedCash),
      'note': serializer.toJson<String?>(note),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  CashSession copyWith({
    String? id,
    String? openedByUserId,
    Value<String?> closedByUserId = const Value.absent(),
    DateTime? openedAt,
    Value<DateTime?> closedAt = const Value.absent(),
    int? openingCash,
    Value<int?> closingCash = const Value.absent(),
    Value<int?> expectedCash = const Value.absent(),
    Value<String?> note = const Value.absent(),
    String? status,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => CashSession(
    id: id ?? this.id,
    openedByUserId: openedByUserId ?? this.openedByUserId,
    closedByUserId: closedByUserId.present
        ? closedByUserId.value
        : this.closedByUserId,
    openedAt: openedAt ?? this.openedAt,
    closedAt: closedAt.present ? closedAt.value : this.closedAt,
    openingCash: openingCash ?? this.openingCash,
    closingCash: closingCash.present ? closingCash.value : this.closingCash,
    expectedCash: expectedCash.present ? expectedCash.value : this.expectedCash,
    note: note.present ? note.value : this.note,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  CashSession copyWithCompanion(CashSessionsCompanion data) {
    return CashSession(
      id: data.id.present ? data.id.value : this.id,
      openedByUserId: data.openedByUserId.present
          ? data.openedByUserId.value
          : this.openedByUserId,
      closedByUserId: data.closedByUserId.present
          ? data.closedByUserId.value
          : this.closedByUserId,
      openedAt: data.openedAt.present ? data.openedAt.value : this.openedAt,
      closedAt: data.closedAt.present ? data.closedAt.value : this.closedAt,
      openingCash: data.openingCash.present
          ? data.openingCash.value
          : this.openingCash,
      closingCash: data.closingCash.present
          ? data.closingCash.value
          : this.closingCash,
      expectedCash: data.expectedCash.present
          ? data.expectedCash.value
          : this.expectedCash,
      note: data.note.present ? data.note.value : this.note,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashSession(')
          ..write('id: $id, ')
          ..write('openedByUserId: $openedByUserId, ')
          ..write('closedByUserId: $closedByUserId, ')
          ..write('openedAt: $openedAt, ')
          ..write('closedAt: $closedAt, ')
          ..write('openingCash: $openingCash, ')
          ..write('closingCash: $closingCash, ')
          ..write('expectedCash: $expectedCash, ')
          ..write('note: $note, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    openedByUserId,
    closedByUserId,
    openedAt,
    closedAt,
    openingCash,
    closingCash,
    expectedCash,
    note,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashSession &&
          other.id == this.id &&
          other.openedByUserId == this.openedByUserId &&
          other.closedByUserId == this.closedByUserId &&
          other.openedAt == this.openedAt &&
          other.closedAt == this.closedAt &&
          other.openingCash == this.openingCash &&
          other.closingCash == this.closingCash &&
          other.expectedCash == this.expectedCash &&
          other.note == this.note &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CashSessionsCompanion extends UpdateCompanion<CashSession> {
  final Value<String> id;
  final Value<String> openedByUserId;
  final Value<String?> closedByUserId;
  final Value<DateTime> openedAt;
  final Value<DateTime?> closedAt;
  final Value<int> openingCash;
  final Value<int?> closingCash;
  final Value<int?> expectedCash;
  final Value<String?> note;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const CashSessionsCompanion({
    this.id = const Value.absent(),
    this.openedByUserId = const Value.absent(),
    this.closedByUserId = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.openingCash = const Value.absent(),
    this.closingCash = const Value.absent(),
    this.expectedCash = const Value.absent(),
    this.note = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CashSessionsCompanion.insert({
    required String id,
    required String openedByUserId,
    this.closedByUserId = const Value.absent(),
    required DateTime openedAt,
    this.closedAt = const Value.absent(),
    this.openingCash = const Value.absent(),
    this.closingCash = const Value.absent(),
    this.expectedCash = const Value.absent(),
    this.note = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       openedByUserId = Value(openedByUserId),
       openedAt = Value(openedAt);
  static Insertable<CashSession> custom({
    Expression<String>? id,
    Expression<String>? openedByUserId,
    Expression<String>? closedByUserId,
    Expression<DateTime>? openedAt,
    Expression<DateTime>? closedAt,
    Expression<int>? openingCash,
    Expression<int>? closingCash,
    Expression<int>? expectedCash,
    Expression<String>? note,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (openedByUserId != null) 'opened_by_user_id': openedByUserId,
      if (closedByUserId != null) 'closed_by_user_id': closedByUserId,
      if (openedAt != null) 'opened_at': openedAt,
      if (closedAt != null) 'closed_at': closedAt,
      if (openingCash != null) 'opening_cash': openingCash,
      if (closingCash != null) 'closing_cash': closingCash,
      if (expectedCash != null) 'expected_cash': expectedCash,
      if (note != null) 'note': note,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CashSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? openedByUserId,
    Value<String?>? closedByUserId,
    Value<DateTime>? openedAt,
    Value<DateTime?>? closedAt,
    Value<int>? openingCash,
    Value<int?>? closingCash,
    Value<int?>? expectedCash,
    Value<String?>? note,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return CashSessionsCompanion(
      id: id ?? this.id,
      openedByUserId: openedByUserId ?? this.openedByUserId,
      closedByUserId: closedByUserId ?? this.closedByUserId,
      openedAt: openedAt ?? this.openedAt,
      closedAt: closedAt ?? this.closedAt,
      openingCash: openingCash ?? this.openingCash,
      closingCash: closingCash ?? this.closingCash,
      expectedCash: expectedCash ?? this.expectedCash,
      note: note ?? this.note,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (openedByUserId.present) {
      map['opened_by_user_id'] = Variable<String>(openedByUserId.value);
    }
    if (closedByUserId.present) {
      map['closed_by_user_id'] = Variable<String>(closedByUserId.value);
    }
    if (openedAt.present) {
      map['opened_at'] = Variable<DateTime>(openedAt.value);
    }
    if (closedAt.present) {
      map['closed_at'] = Variable<DateTime>(closedAt.value);
    }
    if (openingCash.present) {
      map['opening_cash'] = Variable<int>(openingCash.value);
    }
    if (closingCash.present) {
      map['closing_cash'] = Variable<int>(closingCash.value);
    }
    if (expectedCash.present) {
      map['expected_cash'] = Variable<int>(expectedCash.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CashSessionsCompanion(')
          ..write('id: $id, ')
          ..write('openedByUserId: $openedByUserId, ')
          ..write('closedByUserId: $closedByUserId, ')
          ..write('openedAt: $openedAt, ')
          ..write('closedAt: $closedAt, ')
          ..write('openingCash: $openingCash, ')
          ..write('closingCash: $closingCash, ')
          ..write('expectedCash: $expectedCash, ')
          ..write('note: $note, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cashSessionIdMeta = const VerificationMeta(
    'cashSessionId',
  );
  @override
  late final GeneratedColumn<String> cashSessionId = GeneratedColumn<String>(
    'cash_session_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cash_sessions (id)',
    ),
  );
  static const VerificationMeta _cashierUserIdMeta = const VerificationMeta(
    'cashierUserId',
  );
  @override
  late final GeneratedColumn<String> cashierUserId = GeneratedColumn<String>(
    'cashier_user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _orderNumberMeta = const VerificationMeta(
    'orderNumber',
  );
  @override
  late final GeneratedColumn<String> orderNumber = GeneratedColumn<String>(
    'order_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('completed'),
  );
  static const VerificationMeta _orderTypeMeta = const VerificationMeta(
    'orderType',
  );
  @override
  late final GeneratedColumn<String> orderType = GeneratedColumn<String>(
    'order_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('takeaway'),
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<int> subtotal = GeneratedColumn<int>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _manualDiscountTotalMeta =
      const VerificationMeta('manualDiscountTotal');
  @override
  late final GeneratedColumn<int> manualDiscountTotal = GeneratedColumn<int>(
    'manual_discount_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _discountTotalMeta = const VerificationMeta(
    'discountTotal',
  );
  @override
  late final GeneratedColumn<int> discountTotal = GeneratedColumn<int>(
    'discount_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _promoNameMeta = const VerificationMeta(
    'promoName',
  );
  @override
  late final GeneratedColumn<String> promoName = GeneratedColumn<String>(
    'promo_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _taxTotalMeta = const VerificationMeta(
    'taxTotal',
  );
  @override
  late final GeneratedColumn<int> taxTotal = GeneratedColumn<int>(
    'tax_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _grandTotalMeta = const VerificationMeta(
    'grandTotal',
  );
  @override
  late final GeneratedColumn<int> grandTotal = GeneratedColumn<int>(
    'grand_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderedAtMeta = const VerificationMeta(
    'orderedAt',
  );
  @override
  late final GeneratedColumn<DateTime> orderedAt = GeneratedColumn<DateTime>(
    'ordered_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cashSessionId,
    cashierUserId,
    customerId,
    orderNumber,
    status,
    orderType,
    subtotal,
    manualDiscountTotal,
    discountTotal,
    promoName,
    taxTotal,
    grandTotal,
    note,
    orderedAt,
    createdAt,
    updatedAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Order> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('cash_session_id')) {
      context.handle(
        _cashSessionIdMeta,
        cashSessionId.isAcceptableOrUnknown(
          data['cash_session_id']!,
          _cashSessionIdMeta,
        ),
      );
    }
    if (data.containsKey('cashier_user_id')) {
      context.handle(
        _cashierUserIdMeta,
        cashierUserId.isAcceptableOrUnknown(
          data['cashier_user_id']!,
          _cashierUserIdMeta,
        ),
      );
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('order_number')) {
      context.handle(
        _orderNumberMeta,
        orderNumber.isAcceptableOrUnknown(
          data['order_number']!,
          _orderNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_orderNumberMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('order_type')) {
      context.handle(
        _orderTypeMeta,
        orderType.isAcceptableOrUnknown(data['order_type']!, _orderTypeMeta),
      );
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    }
    if (data.containsKey('manual_discount_total')) {
      context.handle(
        _manualDiscountTotalMeta,
        manualDiscountTotal.isAcceptableOrUnknown(
          data['manual_discount_total']!,
          _manualDiscountTotalMeta,
        ),
      );
    }
    if (data.containsKey('discount_total')) {
      context.handle(
        _discountTotalMeta,
        discountTotal.isAcceptableOrUnknown(
          data['discount_total']!,
          _discountTotalMeta,
        ),
      );
    }
    if (data.containsKey('promo_name')) {
      context.handle(
        _promoNameMeta,
        promoName.isAcceptableOrUnknown(data['promo_name']!, _promoNameMeta),
      );
    }
    if (data.containsKey('tax_total')) {
      context.handle(
        _taxTotalMeta,
        taxTotal.isAcceptableOrUnknown(data['tax_total']!, _taxTotalMeta),
      );
    }
    if (data.containsKey('grand_total')) {
      context.handle(
        _grandTotalMeta,
        grandTotal.isAcceptableOrUnknown(data['grand_total']!, _grandTotalMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('ordered_at')) {
      context.handle(
        _orderedAtMeta,
        orderedAt.isAcceptableOrUnknown(data['ordered_at']!, _orderedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_orderedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Order(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      cashSessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cash_session_id'],
      ),
      cashierUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cashier_user_id'],
      ),
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      ),
      orderNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_number'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      orderType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_type'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal'],
      )!,
      manualDiscountTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}manual_discount_total'],
      )!,
      discountTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_total'],
      )!,
      promoName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}promo_name'],
      ),
      taxTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tax_total'],
      )!,
      grandTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grand_total'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      orderedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ordered_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class Order extends DataClass implements Insertable<Order> {
  final String id;
  final String? cashSessionId;
  final String? cashierUserId;
  final String? customerId;
  final String orderNumber;
  final String status;
  final String orderType;
  final int subtotal;
  final int manualDiscountTotal;
  final int discountTotal;
  final String? promoName;
  final int taxTotal;
  final int grandTotal;
  final String? note;
  final DateTime orderedAt;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? syncedAt;
  const Order({
    required this.id,
    this.cashSessionId,
    this.cashierUserId,
    this.customerId,
    required this.orderNumber,
    required this.status,
    required this.orderType,
    required this.subtotal,
    required this.manualDiscountTotal,
    required this.discountTotal,
    this.promoName,
    required this.taxTotal,
    required this.grandTotal,
    this.note,
    required this.orderedAt,
    required this.createdAt,
    this.updatedAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || cashSessionId != null) {
      map['cash_session_id'] = Variable<String>(cashSessionId);
    }
    if (!nullToAbsent || cashierUserId != null) {
      map['cashier_user_id'] = Variable<String>(cashierUserId);
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<String>(customerId);
    }
    map['order_number'] = Variable<String>(orderNumber);
    map['status'] = Variable<String>(status);
    map['order_type'] = Variable<String>(orderType);
    map['subtotal'] = Variable<int>(subtotal);
    map['manual_discount_total'] = Variable<int>(manualDiscountTotal);
    map['discount_total'] = Variable<int>(discountTotal);
    if (!nullToAbsent || promoName != null) {
      map['promo_name'] = Variable<String>(promoName);
    }
    map['tax_total'] = Variable<int>(taxTotal);
    map['grand_total'] = Variable<int>(grandTotal);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['ordered_at'] = Variable<DateTime>(orderedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      cashSessionId: cashSessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(cashSessionId),
      cashierUserId: cashierUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(cashierUserId),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      orderNumber: Value(orderNumber),
      status: Value(status),
      orderType: Value(orderType),
      subtotal: Value(subtotal),
      manualDiscountTotal: Value(manualDiscountTotal),
      discountTotal: Value(discountTotal),
      promoName: promoName == null && nullToAbsent
          ? const Value.absent()
          : Value(promoName),
      taxTotal: Value(taxTotal),
      grandTotal: Value(grandTotal),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      orderedAt: Value(orderedAt),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory Order.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Order(
      id: serializer.fromJson<String>(json['id']),
      cashSessionId: serializer.fromJson<String?>(json['cashSessionId']),
      cashierUserId: serializer.fromJson<String?>(json['cashierUserId']),
      customerId: serializer.fromJson<String?>(json['customerId']),
      orderNumber: serializer.fromJson<String>(json['orderNumber']),
      status: serializer.fromJson<String>(json['status']),
      orderType: serializer.fromJson<String>(json['orderType']),
      subtotal: serializer.fromJson<int>(json['subtotal']),
      manualDiscountTotal: serializer.fromJson<int>(
        json['manualDiscountTotal'],
      ),
      discountTotal: serializer.fromJson<int>(json['discountTotal']),
      promoName: serializer.fromJson<String?>(json['promoName']),
      taxTotal: serializer.fromJson<int>(json['taxTotal']),
      grandTotal: serializer.fromJson<int>(json['grandTotal']),
      note: serializer.fromJson<String?>(json['note']),
      orderedAt: serializer.fromJson<DateTime>(json['orderedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'cashSessionId': serializer.toJson<String?>(cashSessionId),
      'cashierUserId': serializer.toJson<String?>(cashierUserId),
      'customerId': serializer.toJson<String?>(customerId),
      'orderNumber': serializer.toJson<String>(orderNumber),
      'status': serializer.toJson<String>(status),
      'orderType': serializer.toJson<String>(orderType),
      'subtotal': serializer.toJson<int>(subtotal),
      'manualDiscountTotal': serializer.toJson<int>(manualDiscountTotal),
      'discountTotal': serializer.toJson<int>(discountTotal),
      'promoName': serializer.toJson<String?>(promoName),
      'taxTotal': serializer.toJson<int>(taxTotal),
      'grandTotal': serializer.toJson<int>(grandTotal),
      'note': serializer.toJson<String?>(note),
      'orderedAt': serializer.toJson<DateTime>(orderedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  Order copyWith({
    String? id,
    Value<String?> cashSessionId = const Value.absent(),
    Value<String?> cashierUserId = const Value.absent(),
    Value<String?> customerId = const Value.absent(),
    String? orderNumber,
    String? status,
    String? orderType,
    int? subtotal,
    int? manualDiscountTotal,
    int? discountTotal,
    Value<String?> promoName = const Value.absent(),
    int? taxTotal,
    int? grandTotal,
    Value<String?> note = const Value.absent(),
    DateTime? orderedAt,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => Order(
    id: id ?? this.id,
    cashSessionId: cashSessionId.present
        ? cashSessionId.value
        : this.cashSessionId,
    cashierUserId: cashierUserId.present
        ? cashierUserId.value
        : this.cashierUserId,
    customerId: customerId.present ? customerId.value : this.customerId,
    orderNumber: orderNumber ?? this.orderNumber,
    status: status ?? this.status,
    orderType: orderType ?? this.orderType,
    subtotal: subtotal ?? this.subtotal,
    manualDiscountTotal: manualDiscountTotal ?? this.manualDiscountTotal,
    discountTotal: discountTotal ?? this.discountTotal,
    promoName: promoName.present ? promoName.value : this.promoName,
    taxTotal: taxTotal ?? this.taxTotal,
    grandTotal: grandTotal ?? this.grandTotal,
    note: note.present ? note.value : this.note,
    orderedAt: orderedAt ?? this.orderedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  Order copyWithCompanion(OrdersCompanion data) {
    return Order(
      id: data.id.present ? data.id.value : this.id,
      cashSessionId: data.cashSessionId.present
          ? data.cashSessionId.value
          : this.cashSessionId,
      cashierUserId: data.cashierUserId.present
          ? data.cashierUserId.value
          : this.cashierUserId,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      orderNumber: data.orderNumber.present
          ? data.orderNumber.value
          : this.orderNumber,
      status: data.status.present ? data.status.value : this.status,
      orderType: data.orderType.present ? data.orderType.value : this.orderType,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      manualDiscountTotal: data.manualDiscountTotal.present
          ? data.manualDiscountTotal.value
          : this.manualDiscountTotal,
      discountTotal: data.discountTotal.present
          ? data.discountTotal.value
          : this.discountTotal,
      promoName: data.promoName.present ? data.promoName.value : this.promoName,
      taxTotal: data.taxTotal.present ? data.taxTotal.value : this.taxTotal,
      grandTotal: data.grandTotal.present
          ? data.grandTotal.value
          : this.grandTotal,
      note: data.note.present ? data.note.value : this.note,
      orderedAt: data.orderedAt.present ? data.orderedAt.value : this.orderedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('id: $id, ')
          ..write('cashSessionId: $cashSessionId, ')
          ..write('cashierUserId: $cashierUserId, ')
          ..write('customerId: $customerId, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('status: $status, ')
          ..write('orderType: $orderType, ')
          ..write('subtotal: $subtotal, ')
          ..write('manualDiscountTotal: $manualDiscountTotal, ')
          ..write('discountTotal: $discountTotal, ')
          ..write('promoName: $promoName, ')
          ..write('taxTotal: $taxTotal, ')
          ..write('grandTotal: $grandTotal, ')
          ..write('note: $note, ')
          ..write('orderedAt: $orderedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cashSessionId,
    cashierUserId,
    customerId,
    orderNumber,
    status,
    orderType,
    subtotal,
    manualDiscountTotal,
    discountTotal,
    promoName,
    taxTotal,
    grandTotal,
    note,
    orderedAt,
    createdAt,
    updatedAt,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          other.id == this.id &&
          other.cashSessionId == this.cashSessionId &&
          other.cashierUserId == this.cashierUserId &&
          other.customerId == this.customerId &&
          other.orderNumber == this.orderNumber &&
          other.status == this.status &&
          other.orderType == this.orderType &&
          other.subtotal == this.subtotal &&
          other.manualDiscountTotal == this.manualDiscountTotal &&
          other.discountTotal == this.discountTotal &&
          other.promoName == this.promoName &&
          other.taxTotal == this.taxTotal &&
          other.grandTotal == this.grandTotal &&
          other.note == this.note &&
          other.orderedAt == this.orderedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncedAt == this.syncedAt);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<String> id;
  final Value<String?> cashSessionId;
  final Value<String?> cashierUserId;
  final Value<String?> customerId;
  final Value<String> orderNumber;
  final Value<String> status;
  final Value<String> orderType;
  final Value<int> subtotal;
  final Value<int> manualDiscountTotal;
  final Value<int> discountTotal;
  final Value<String?> promoName;
  final Value<int> taxTotal;
  final Value<int> grandTotal;
  final Value<String?> note;
  final Value<DateTime> orderedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> syncedAt;
  final Value<int> rowid;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.cashSessionId = const Value.absent(),
    this.cashierUserId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.orderNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.orderType = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.manualDiscountTotal = const Value.absent(),
    this.discountTotal = const Value.absent(),
    this.promoName = const Value.absent(),
    this.taxTotal = const Value.absent(),
    this.grandTotal = const Value.absent(),
    this.note = const Value.absent(),
    this.orderedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrdersCompanion.insert({
    required String id,
    this.cashSessionId = const Value.absent(),
    this.cashierUserId = const Value.absent(),
    this.customerId = const Value.absent(),
    required String orderNumber,
    this.status = const Value.absent(),
    this.orderType = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.manualDiscountTotal = const Value.absent(),
    this.discountTotal = const Value.absent(),
    this.promoName = const Value.absent(),
    this.taxTotal = const Value.absent(),
    this.grandTotal = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime orderedAt,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       orderNumber = Value(orderNumber),
       orderedAt = Value(orderedAt);
  static Insertable<Order> custom({
    Expression<String>? id,
    Expression<String>? cashSessionId,
    Expression<String>? cashierUserId,
    Expression<String>? customerId,
    Expression<String>? orderNumber,
    Expression<String>? status,
    Expression<String>? orderType,
    Expression<int>? subtotal,
    Expression<int>? manualDiscountTotal,
    Expression<int>? discountTotal,
    Expression<String>? promoName,
    Expression<int>? taxTotal,
    Expression<int>? grandTotal,
    Expression<String>? note,
    Expression<DateTime>? orderedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cashSessionId != null) 'cash_session_id': cashSessionId,
      if (cashierUserId != null) 'cashier_user_id': cashierUserId,
      if (customerId != null) 'customer_id': customerId,
      if (orderNumber != null) 'order_number': orderNumber,
      if (status != null) 'status': status,
      if (orderType != null) 'order_type': orderType,
      if (subtotal != null) 'subtotal': subtotal,
      if (manualDiscountTotal != null)
        'manual_discount_total': manualDiscountTotal,
      if (discountTotal != null) 'discount_total': discountTotal,
      if (promoName != null) 'promo_name': promoName,
      if (taxTotal != null) 'tax_total': taxTotal,
      if (grandTotal != null) 'grand_total': grandTotal,
      if (note != null) 'note': note,
      if (orderedAt != null) 'ordered_at': orderedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrdersCompanion copyWith({
    Value<String>? id,
    Value<String?>? cashSessionId,
    Value<String?>? cashierUserId,
    Value<String?>? customerId,
    Value<String>? orderNumber,
    Value<String>? status,
    Value<String>? orderType,
    Value<int>? subtotal,
    Value<int>? manualDiscountTotal,
    Value<int>? discountTotal,
    Value<String?>? promoName,
    Value<int>? taxTotal,
    Value<int>? grandTotal,
    Value<String?>? note,
    Value<DateTime>? orderedAt,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<DateTime?>? syncedAt,
    Value<int>? rowid,
  }) {
    return OrdersCompanion(
      id: id ?? this.id,
      cashSessionId: cashSessionId ?? this.cashSessionId,
      cashierUserId: cashierUserId ?? this.cashierUserId,
      customerId: customerId ?? this.customerId,
      orderNumber: orderNumber ?? this.orderNumber,
      status: status ?? this.status,
      orderType: orderType ?? this.orderType,
      subtotal: subtotal ?? this.subtotal,
      manualDiscountTotal: manualDiscountTotal ?? this.manualDiscountTotal,
      discountTotal: discountTotal ?? this.discountTotal,
      promoName: promoName ?? this.promoName,
      taxTotal: taxTotal ?? this.taxTotal,
      grandTotal: grandTotal ?? this.grandTotal,
      note: note ?? this.note,
      orderedAt: orderedAt ?? this.orderedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (cashSessionId.present) {
      map['cash_session_id'] = Variable<String>(cashSessionId.value);
    }
    if (cashierUserId.present) {
      map['cashier_user_id'] = Variable<String>(cashierUserId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (orderNumber.present) {
      map['order_number'] = Variable<String>(orderNumber.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (orderType.present) {
      map['order_type'] = Variable<String>(orderType.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<int>(subtotal.value);
    }
    if (manualDiscountTotal.present) {
      map['manual_discount_total'] = Variable<int>(manualDiscountTotal.value);
    }
    if (discountTotal.present) {
      map['discount_total'] = Variable<int>(discountTotal.value);
    }
    if (promoName.present) {
      map['promo_name'] = Variable<String>(promoName.value);
    }
    if (taxTotal.present) {
      map['tax_total'] = Variable<int>(taxTotal.value);
    }
    if (grandTotal.present) {
      map['grand_total'] = Variable<int>(grandTotal.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (orderedAt.present) {
      map['ordered_at'] = Variable<DateTime>(orderedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('cashSessionId: $cashSessionId, ')
          ..write('cashierUserId: $cashierUserId, ')
          ..write('customerId: $customerId, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('status: $status, ')
          ..write('orderType: $orderType, ')
          ..write('subtotal: $subtotal, ')
          ..write('manualDiscountTotal: $manualDiscountTotal, ')
          ..write('discountTotal: $discountTotal, ')
          ..write('promoName: $promoName, ')
          ..write('taxTotal: $taxTotal, ')
          ..write('grandTotal: $grandTotal, ')
          ..write('note: $note, ')
          ..write('orderedAt: $orderedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrderItemsTable extends OrderItems
    with TableInfo<$OrderItemsTable, OrderItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES orders (id)',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<int> qty = GeneratedColumn<int>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<int> unitPrice = GeneratedColumn<int>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountTotalMeta = const VerificationMeta(
    'discountTotal',
  );
  @override
  late final GeneratedColumn<int> discountTotal = GeneratedColumn<int>(
    'discount_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lineTotalMeta = const VerificationMeta(
    'lineTotal',
  );
  @override
  late final GeneratedColumn<int> lineTotal = GeneratedColumn<int>(
    'line_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kitchenStatusMeta = const VerificationMeta(
    'kitchenStatus',
  );
  @override
  late final GeneratedColumn<String> kitchenStatus = GeneratedColumn<String>(
    'kitchen_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderId,
    productId,
    productName,
    qty,
    unitPrice,
    discountTotal,
    lineTotal,
    kitchenStatus,
    note,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrderItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('discount_total')) {
      context.handle(
        _discountTotalMeta,
        discountTotal.isAcceptableOrUnknown(
          data['discount_total']!,
          _discountTotalMeta,
        ),
      );
    }
    if (data.containsKey('line_total')) {
      context.handle(
        _lineTotalMeta,
        lineTotal.isAcceptableOrUnknown(data['line_total']!, _lineTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_lineTotalMeta);
    }
    if (data.containsKey('kitchen_status')) {
      context.handle(
        _kitchenStatusMeta,
        kitchenStatus.isAcceptableOrUnknown(
          data['kitchen_status']!,
          _kitchenStatusMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      ),
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      qty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}qty'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_price'],
      )!,
      discountTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_total'],
      )!,
      lineTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_total'],
      )!,
      kitchenStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kitchen_status'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $OrderItemsTable createAlias(String alias) {
    return $OrderItemsTable(attachedDatabase, alias);
  }
}

class OrderItem extends DataClass implements Insertable<OrderItem> {
  final String id;
  final String orderId;
  final String? productId;
  final String productName;
  final int qty;
  final int unitPrice;
  final int discountTotal;
  final int lineTotal;
  final String kitchenStatus;
  final String? note;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const OrderItem({
    required this.id,
    required this.orderId,
    this.productId,
    required this.productName,
    required this.qty,
    required this.unitPrice,
    required this.discountTotal,
    required this.lineTotal,
    required this.kitchenStatus,
    this.note,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['order_id'] = Variable<String>(orderId);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<String>(productId);
    }
    map['product_name'] = Variable<String>(productName);
    map['qty'] = Variable<int>(qty);
    map['unit_price'] = Variable<int>(unitPrice);
    map['discount_total'] = Variable<int>(discountTotal);
    map['line_total'] = Variable<int>(lineTotal);
    map['kitchen_status'] = Variable<String>(kitchenStatus);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  OrderItemsCompanion toCompanion(bool nullToAbsent) {
    return OrderItemsCompanion(
      id: Value(id),
      orderId: Value(orderId),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      productName: Value(productName),
      qty: Value(qty),
      unitPrice: Value(unitPrice),
      discountTotal: Value(discountTotal),
      lineTotal: Value(lineTotal),
      kitchenStatus: Value(kitchenStatus),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory OrderItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderItem(
      id: serializer.fromJson<String>(json['id']),
      orderId: serializer.fromJson<String>(json['orderId']),
      productId: serializer.fromJson<String?>(json['productId']),
      productName: serializer.fromJson<String>(json['productName']),
      qty: serializer.fromJson<int>(json['qty']),
      unitPrice: serializer.fromJson<int>(json['unitPrice']),
      discountTotal: serializer.fromJson<int>(json['discountTotal']),
      lineTotal: serializer.fromJson<int>(json['lineTotal']),
      kitchenStatus: serializer.fromJson<String>(json['kitchenStatus']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'orderId': serializer.toJson<String>(orderId),
      'productId': serializer.toJson<String?>(productId),
      'productName': serializer.toJson<String>(productName),
      'qty': serializer.toJson<int>(qty),
      'unitPrice': serializer.toJson<int>(unitPrice),
      'discountTotal': serializer.toJson<int>(discountTotal),
      'lineTotal': serializer.toJson<int>(lineTotal),
      'kitchenStatus': serializer.toJson<String>(kitchenStatus),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  OrderItem copyWith({
    String? id,
    String? orderId,
    Value<String?> productId = const Value.absent(),
    String? productName,
    int? qty,
    int? unitPrice,
    int? discountTotal,
    int? lineTotal,
    String? kitchenStatus,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => OrderItem(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    productId: productId.present ? productId.value : this.productId,
    productName: productName ?? this.productName,
    qty: qty ?? this.qty,
    unitPrice: unitPrice ?? this.unitPrice,
    discountTotal: discountTotal ?? this.discountTotal,
    lineTotal: lineTotal ?? this.lineTotal,
    kitchenStatus: kitchenStatus ?? this.kitchenStatus,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  OrderItem copyWithCompanion(OrderItemsCompanion data) {
    return OrderItem(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      productId: data.productId.present ? data.productId.value : this.productId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      qty: data.qty.present ? data.qty.value : this.qty,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      discountTotal: data.discountTotal.present
          ? data.discountTotal.value
          : this.discountTotal,
      lineTotal: data.lineTotal.present ? data.lineTotal.value : this.lineTotal,
      kitchenStatus: data.kitchenStatus.present
          ? data.kitchenStatus.value
          : this.kitchenStatus,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderItem(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('qty: $qty, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('discountTotal: $discountTotal, ')
          ..write('lineTotal: $lineTotal, ')
          ..write('kitchenStatus: $kitchenStatus, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    orderId,
    productId,
    productName,
    qty,
    unitPrice,
    discountTotal,
    lineTotal,
    kitchenStatus,
    note,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderItem &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.productId == this.productId &&
          other.productName == this.productName &&
          other.qty == this.qty &&
          other.unitPrice == this.unitPrice &&
          other.discountTotal == this.discountTotal &&
          other.lineTotal == this.lineTotal &&
          other.kitchenStatus == this.kitchenStatus &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class OrderItemsCompanion extends UpdateCompanion<OrderItem> {
  final Value<String> id;
  final Value<String> orderId;
  final Value<String?> productId;
  final Value<String> productName;
  final Value<int> qty;
  final Value<int> unitPrice;
  final Value<int> discountTotal;
  final Value<int> lineTotal;
  final Value<String> kitchenStatus;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const OrderItemsCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.qty = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.discountTotal = const Value.absent(),
    this.lineTotal = const Value.absent(),
    this.kitchenStatus = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrderItemsCompanion.insert({
    required String id,
    required String orderId,
    this.productId = const Value.absent(),
    required String productName,
    required int qty,
    required int unitPrice,
    this.discountTotal = const Value.absent(),
    required int lineTotal,
    this.kitchenStatus = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       orderId = Value(orderId),
       productName = Value(productName),
       qty = Value(qty),
       unitPrice = Value(unitPrice),
       lineTotal = Value(lineTotal);
  static Insertable<OrderItem> custom({
    Expression<String>? id,
    Expression<String>? orderId,
    Expression<String>? productId,
    Expression<String>? productName,
    Expression<int>? qty,
    Expression<int>? unitPrice,
    Expression<int>? discountTotal,
    Expression<int>? lineTotal,
    Expression<String>? kitchenStatus,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (qty != null) 'qty': qty,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (discountTotal != null) 'discount_total': discountTotal,
      if (lineTotal != null) 'line_total': lineTotal,
      if (kitchenStatus != null) 'kitchen_status': kitchenStatus,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrderItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? orderId,
    Value<String?>? productId,
    Value<String>? productName,
    Value<int>? qty,
    Value<int>? unitPrice,
    Value<int>? discountTotal,
    Value<int>? lineTotal,
    Value<String>? kitchenStatus,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return OrderItemsCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      qty: qty ?? this.qty,
      unitPrice: unitPrice ?? this.unitPrice,
      discountTotal: discountTotal ?? this.discountTotal,
      lineTotal: lineTotal ?? this.lineTotal,
      kitchenStatus: kitchenStatus ?? this.kitchenStatus,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (qty.present) {
      map['qty'] = Variable<int>(qty.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<int>(unitPrice.value);
    }
    if (discountTotal.present) {
      map['discount_total'] = Variable<int>(discountTotal.value);
    }
    if (lineTotal.present) {
      map['line_total'] = Variable<int>(lineTotal.value);
    }
    if (kitchenStatus.present) {
      map['kitchen_status'] = Variable<String>(kitchenStatus.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderItemsCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('qty: $qty, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('discountTotal: $discountTotal, ')
          ..write('lineTotal: $lineTotal, ')
          ..write('kitchenStatus: $kitchenStatus, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments with TableInfo<$PaymentsTable, Payment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES orders (id)',
    ),
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceNumberMeta = const VerificationMeta(
    'referenceNumber',
  );
  @override
  late final GeneratedColumn<String> referenceNumber = GeneratedColumn<String>(
    'reference_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('paid'),
  );
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
    'paid_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderId,
    method,
    amount,
    referenceNumber,
    status,
    paidAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Payment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('reference_number')) {
      context.handle(
        _referenceNumberMeta,
        referenceNumber.isAcceptableOrUnknown(
          data['reference_number']!,
          _referenceNumberMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('paid_at')) {
      context.handle(
        _paidAtMeta,
        paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta),
      );
    } else if (isInserting) {
      context.missing(_paidAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Payment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_id'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      referenceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_number'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      paidAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class Payment extends DataClass implements Insertable<Payment> {
  final String id;
  final String orderId;
  final String method;
  final int amount;
  final String? referenceNumber;
  final String status;
  final DateTime paidAt;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Payment({
    required this.id,
    required this.orderId,
    required this.method,
    required this.amount,
    this.referenceNumber,
    required this.status,
    required this.paidAt,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['order_id'] = Variable<String>(orderId);
    map['method'] = Variable<String>(method);
    map['amount'] = Variable<int>(amount);
    if (!nullToAbsent || referenceNumber != null) {
      map['reference_number'] = Variable<String>(referenceNumber);
    }
    map['status'] = Variable<String>(status);
    map['paid_at'] = Variable<DateTime>(paidAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      orderId: Value(orderId),
      method: Value(method),
      amount: Value(amount),
      referenceNumber: referenceNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceNumber),
      status: Value(status),
      paidAt: Value(paidAt),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Payment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payment(
      id: serializer.fromJson<String>(json['id']),
      orderId: serializer.fromJson<String>(json['orderId']),
      method: serializer.fromJson<String>(json['method']),
      amount: serializer.fromJson<int>(json['amount']),
      referenceNumber: serializer.fromJson<String?>(json['referenceNumber']),
      status: serializer.fromJson<String>(json['status']),
      paidAt: serializer.fromJson<DateTime>(json['paidAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'orderId': serializer.toJson<String>(orderId),
      'method': serializer.toJson<String>(method),
      'amount': serializer.toJson<int>(amount),
      'referenceNumber': serializer.toJson<String?>(referenceNumber),
      'status': serializer.toJson<String>(status),
      'paidAt': serializer.toJson<DateTime>(paidAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Payment copyWith({
    String? id,
    String? orderId,
    String? method,
    int? amount,
    Value<String?> referenceNumber = const Value.absent(),
    String? status,
    DateTime? paidAt,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Payment(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    method: method ?? this.method,
    amount: amount ?? this.amount,
    referenceNumber: referenceNumber.present
        ? referenceNumber.value
        : this.referenceNumber,
    status: status ?? this.status,
    paidAt: paidAt ?? this.paidAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Payment copyWithCompanion(PaymentsCompanion data) {
    return Payment(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      method: data.method.present ? data.method.value : this.method,
      amount: data.amount.present ? data.amount.value : this.amount,
      referenceNumber: data.referenceNumber.present
          ? data.referenceNumber.value
          : this.referenceNumber,
      status: data.status.present ? data.status.value : this.status,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payment(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('method: $method, ')
          ..write('amount: $amount, ')
          ..write('referenceNumber: $referenceNumber, ')
          ..write('status: $status, ')
          ..write('paidAt: $paidAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    orderId,
    method,
    amount,
    referenceNumber,
    status,
    paidAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.method == this.method &&
          other.amount == this.amount &&
          other.referenceNumber == this.referenceNumber &&
          other.status == this.status &&
          other.paidAt == this.paidAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PaymentsCompanion extends UpdateCompanion<Payment> {
  final Value<String> id;
  final Value<String> orderId;
  final Value<String> method;
  final Value<int> amount;
  final Value<String?> referenceNumber;
  final Value<String> status;
  final Value<DateTime> paidAt;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.method = const Value.absent(),
    this.amount = const Value.absent(),
    this.referenceNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentsCompanion.insert({
    required String id,
    required String orderId,
    required String method,
    required int amount,
    this.referenceNumber = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime paidAt,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       orderId = Value(orderId),
       method = Value(method),
       amount = Value(amount),
       paidAt = Value(paidAt);
  static Insertable<Payment> custom({
    Expression<String>? id,
    Expression<String>? orderId,
    Expression<String>? method,
    Expression<int>? amount,
    Expression<String>? referenceNumber,
    Expression<String>? status,
    Expression<DateTime>? paidAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (method != null) 'method': method,
      if (amount != null) 'amount': amount,
      if (referenceNumber != null) 'reference_number': referenceNumber,
      if (status != null) 'status': status,
      if (paidAt != null) 'paid_at': paidAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentsCompanion copyWith({
    Value<String>? id,
    Value<String>? orderId,
    Value<String>? method,
    Value<int>? amount,
    Value<String?>? referenceNumber,
    Value<String>? status,
    Value<DateTime>? paidAt,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return PaymentsCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      method: method ?? this.method,
      amount: amount ?? this.amount,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      status: status ?? this.status,
      paidAt: paidAt ?? this.paidAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (referenceNumber.present) {
      map['reference_number'] = Variable<String>(referenceNumber.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('method: $method, ')
          ..write('amount: $amount, ')
          ..write('referenceNumber: $referenceNumber, ')
          ..write('status: $status, ')
          ..write('paidAt: $paidAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    entityId,
    action,
    payloadJson,
    retryCount,
    lastError,
    createdAt,
    updatedAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final String id;
  final String entityType;
  final String entityId;
  final String action;
  final String payloadJson;
  final int retryCount;
  final String? lastError;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? syncedAt;
  const SyncQueueData({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.action,
    required this.payloadJson,
    required this.retryCount,
    this.lastError,
    required this.createdAt,
    this.updatedAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['action'] = Variable<String>(action);
    map['payload_json'] = Variable<String>(payloadJson);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      action: Value(action),
      payloadJson: Value(payloadJson),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<String>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      action: serializer.fromJson<String>(json['action']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'action': serializer.toJson<String>(action),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  SyncQueueData copyWith({
    String? id,
    String? entityType,
    String? entityId,
    String? action,
    String? payloadJson,
    int? retryCount,
    Value<String?> lastError = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => SyncQueueData(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    action: action ?? this.action,
    payloadJson: payloadJson ?? this.payloadJson,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError.present ? lastError.value : this.lastError,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      action: data.action.present ? data.action.value : this.action,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('action: $action, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    entityId,
    action,
    payloadJson,
    retryCount,
    lastError,
    createdAt,
    updatedAt,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.action == this.action &&
          other.payloadJson == this.payloadJson &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncedAt == this.syncedAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<String> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> action;
  final Value<String> payloadJson;
  final Value<int> retryCount;
  final Value<String?> lastError;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> syncedAt;
  final Value<int> rowid;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.action = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    required String id,
    required String entityType,
    required String entityId,
    required String action,
    required String payloadJson,
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       entityType = Value(entityType),
       entityId = Value(entityId),
       action = Value(action),
       payloadJson = Value(payloadJson);
  static Insertable<SyncQueueData> custom({
    Expression<String>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? action,
    Expression<String>? payloadJson,
    Expression<int>? retryCount,
    Expression<String>? lastError,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (action != null) 'action': action,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueCompanion copyWith({
    Value<String>? id,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? action,
    Value<String>? payloadJson,
    Value<int>? retryCount,
    Value<String?>? lastError,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<DateTime?>? syncedAt,
    Value<int>? rowid,
  }) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      action: action ?? this.action,
      payloadJson: payloadJson ?? this.payloadJson,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('action: $action, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _outletNameMeta = const VerificationMeta(
    'outletName',
  );
  @override
  late final GeneratedColumn<String> outletName = GeneratedColumn<String>(
    'outlet_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Patali Demo Outlet'),
  );
  static const VerificationMeta _outletAddressMeta = const VerificationMeta(
    'outletAddress',
  );
  @override
  late final GeneratedColumn<String> outletAddress = GeneratedColumn<String>(
    'outlet_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _outletPhoneMeta = const VerificationMeta(
    'outletPhone',
  );
  @override
  late final GeneratedColumn<String> outletPhone = GeneratedColumn<String>(
    'outlet_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _receiptHeaderMeta = const VerificationMeta(
    'receiptHeader',
  );
  @override
  late final GeneratedColumn<String> receiptHeader = GeneratedColumn<String>(
    'receipt_header',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _receiptFooterMeta = const VerificationMeta(
    'receiptFooter',
  );
  @override
  late final GeneratedColumn<String> receiptFooter = GeneratedColumn<String>(
    'receipt_footer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Terima kasih'),
  );
  static const VerificationMeta _taxEnabledMeta = const VerificationMeta(
    'taxEnabled',
  );
  @override
  late final GeneratedColumn<bool> taxEnabled = GeneratedColumn<bool>(
    'tax_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("tax_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _taxRateMeta = const VerificationMeta(
    'taxRate',
  );
  @override
  late final GeneratedColumn<int> taxRate = GeneratedColumn<int>(
    'tax_rate',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _serviceEnabledMeta = const VerificationMeta(
    'serviceEnabled',
  );
  @override
  late final GeneratedColumn<bool> serviceEnabled = GeneratedColumn<bool>(
    'service_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("service_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _serviceRateMeta = const VerificationMeta(
    'serviceRate',
  );
  @override
  late final GeneratedColumn<int> serviceRate = GeneratedColumn<int>(
    'service_rate',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _showOutletAddressMeta = const VerificationMeta(
    'showOutletAddress',
  );
  @override
  late final GeneratedColumn<bool> showOutletAddress = GeneratedColumn<bool>(
    'show_outlet_address',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_outlet_address" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    outletName,
    outletAddress,
    outletPhone,
    receiptHeader,
    receiptFooter,
    taxEnabled,
    taxRate,
    serviceEnabled,
    serviceRate,
    showOutletAddress,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('outlet_name')) {
      context.handle(
        _outletNameMeta,
        outletName.isAcceptableOrUnknown(data['outlet_name']!, _outletNameMeta),
      );
    }
    if (data.containsKey('outlet_address')) {
      context.handle(
        _outletAddressMeta,
        outletAddress.isAcceptableOrUnknown(
          data['outlet_address']!,
          _outletAddressMeta,
        ),
      );
    }
    if (data.containsKey('outlet_phone')) {
      context.handle(
        _outletPhoneMeta,
        outletPhone.isAcceptableOrUnknown(
          data['outlet_phone']!,
          _outletPhoneMeta,
        ),
      );
    }
    if (data.containsKey('receipt_header')) {
      context.handle(
        _receiptHeaderMeta,
        receiptHeader.isAcceptableOrUnknown(
          data['receipt_header']!,
          _receiptHeaderMeta,
        ),
      );
    }
    if (data.containsKey('receipt_footer')) {
      context.handle(
        _receiptFooterMeta,
        receiptFooter.isAcceptableOrUnknown(
          data['receipt_footer']!,
          _receiptFooterMeta,
        ),
      );
    }
    if (data.containsKey('tax_enabled')) {
      context.handle(
        _taxEnabledMeta,
        taxEnabled.isAcceptableOrUnknown(data['tax_enabled']!, _taxEnabledMeta),
      );
    }
    if (data.containsKey('tax_rate')) {
      context.handle(
        _taxRateMeta,
        taxRate.isAcceptableOrUnknown(data['tax_rate']!, _taxRateMeta),
      );
    }
    if (data.containsKey('service_enabled')) {
      context.handle(
        _serviceEnabledMeta,
        serviceEnabled.isAcceptableOrUnknown(
          data['service_enabled']!,
          _serviceEnabledMeta,
        ),
      );
    }
    if (data.containsKey('service_rate')) {
      context.handle(
        _serviceRateMeta,
        serviceRate.isAcceptableOrUnknown(
          data['service_rate']!,
          _serviceRateMeta,
        ),
      );
    }
    if (data.containsKey('show_outlet_address')) {
      context.handle(
        _showOutletAddressMeta,
        showOutletAddress.isAcceptableOrUnknown(
          data['show_outlet_address']!,
          _showOutletAddressMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      outletName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outlet_name'],
      )!,
      outletAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outlet_address'],
      ),
      outletPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outlet_phone'],
      ),
      receiptHeader: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_header'],
      ),
      receiptFooter: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_footer'],
      )!,
      taxEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}tax_enabled'],
      )!,
      taxRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tax_rate'],
      )!,
      serviceEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}service_enabled'],
      )!,
      serviceRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}service_rate'],
      )!,
      showOutletAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_outlet_address'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String id;
  final String outletName;
  final String? outletAddress;
  final String? outletPhone;
  final String? receiptHeader;
  final String receiptFooter;
  final bool taxEnabled;
  final int taxRate;
  final bool serviceEnabled;
  final int serviceRate;
  final bool showOutletAddress;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const AppSetting({
    required this.id,
    required this.outletName,
    this.outletAddress,
    this.outletPhone,
    this.receiptHeader,
    required this.receiptFooter,
    required this.taxEnabled,
    required this.taxRate,
    required this.serviceEnabled,
    required this.serviceRate,
    required this.showOutletAddress,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['outlet_name'] = Variable<String>(outletName);
    if (!nullToAbsent || outletAddress != null) {
      map['outlet_address'] = Variable<String>(outletAddress);
    }
    if (!nullToAbsent || outletPhone != null) {
      map['outlet_phone'] = Variable<String>(outletPhone);
    }
    if (!nullToAbsent || receiptHeader != null) {
      map['receipt_header'] = Variable<String>(receiptHeader);
    }
    map['receipt_footer'] = Variable<String>(receiptFooter);
    map['tax_enabled'] = Variable<bool>(taxEnabled);
    map['tax_rate'] = Variable<int>(taxRate);
    map['service_enabled'] = Variable<bool>(serviceEnabled);
    map['service_rate'] = Variable<int>(serviceRate);
    map['show_outlet_address'] = Variable<bool>(showOutletAddress);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      outletName: Value(outletName),
      outletAddress: outletAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(outletAddress),
      outletPhone: outletPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(outletPhone),
      receiptHeader: receiptHeader == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptHeader),
      receiptFooter: Value(receiptFooter),
      taxEnabled: Value(taxEnabled),
      taxRate: Value(taxRate),
      serviceEnabled: Value(serviceEnabled),
      serviceRate: Value(serviceRate),
      showOutletAddress: Value(showOutletAddress),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<String>(json['id']),
      outletName: serializer.fromJson<String>(json['outletName']),
      outletAddress: serializer.fromJson<String?>(json['outletAddress']),
      outletPhone: serializer.fromJson<String?>(json['outletPhone']),
      receiptHeader: serializer.fromJson<String?>(json['receiptHeader']),
      receiptFooter: serializer.fromJson<String>(json['receiptFooter']),
      taxEnabled: serializer.fromJson<bool>(json['taxEnabled']),
      taxRate: serializer.fromJson<int>(json['taxRate']),
      serviceEnabled: serializer.fromJson<bool>(json['serviceEnabled']),
      serviceRate: serializer.fromJson<int>(json['serviceRate']),
      showOutletAddress: serializer.fromJson<bool>(json['showOutletAddress']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'outletName': serializer.toJson<String>(outletName),
      'outletAddress': serializer.toJson<String?>(outletAddress),
      'outletPhone': serializer.toJson<String?>(outletPhone),
      'receiptHeader': serializer.toJson<String?>(receiptHeader),
      'receiptFooter': serializer.toJson<String>(receiptFooter),
      'taxEnabled': serializer.toJson<bool>(taxEnabled),
      'taxRate': serializer.toJson<int>(taxRate),
      'serviceEnabled': serializer.toJson<bool>(serviceEnabled),
      'serviceRate': serializer.toJson<int>(serviceRate),
      'showOutletAddress': serializer.toJson<bool>(showOutletAddress),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  AppSetting copyWith({
    String? id,
    String? outletName,
    Value<String?> outletAddress = const Value.absent(),
    Value<String?> outletPhone = const Value.absent(),
    Value<String?> receiptHeader = const Value.absent(),
    String? receiptFooter,
    bool? taxEnabled,
    int? taxRate,
    bool? serviceEnabled,
    int? serviceRate,
    bool? showOutletAddress,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => AppSetting(
    id: id ?? this.id,
    outletName: outletName ?? this.outletName,
    outletAddress: outletAddress.present
        ? outletAddress.value
        : this.outletAddress,
    outletPhone: outletPhone.present ? outletPhone.value : this.outletPhone,
    receiptHeader: receiptHeader.present
        ? receiptHeader.value
        : this.receiptHeader,
    receiptFooter: receiptFooter ?? this.receiptFooter,
    taxEnabled: taxEnabled ?? this.taxEnabled,
    taxRate: taxRate ?? this.taxRate,
    serviceEnabled: serviceEnabled ?? this.serviceEnabled,
    serviceRate: serviceRate ?? this.serviceRate,
    showOutletAddress: showOutletAddress ?? this.showOutletAddress,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      outletName: data.outletName.present
          ? data.outletName.value
          : this.outletName,
      outletAddress: data.outletAddress.present
          ? data.outletAddress.value
          : this.outletAddress,
      outletPhone: data.outletPhone.present
          ? data.outletPhone.value
          : this.outletPhone,
      receiptHeader: data.receiptHeader.present
          ? data.receiptHeader.value
          : this.receiptHeader,
      receiptFooter: data.receiptFooter.present
          ? data.receiptFooter.value
          : this.receiptFooter,
      taxEnabled: data.taxEnabled.present
          ? data.taxEnabled.value
          : this.taxEnabled,
      taxRate: data.taxRate.present ? data.taxRate.value : this.taxRate,
      serviceEnabled: data.serviceEnabled.present
          ? data.serviceEnabled.value
          : this.serviceEnabled,
      serviceRate: data.serviceRate.present
          ? data.serviceRate.value
          : this.serviceRate,
      showOutletAddress: data.showOutletAddress.present
          ? data.showOutletAddress.value
          : this.showOutletAddress,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('outletName: $outletName, ')
          ..write('outletAddress: $outletAddress, ')
          ..write('outletPhone: $outletPhone, ')
          ..write('receiptHeader: $receiptHeader, ')
          ..write('receiptFooter: $receiptFooter, ')
          ..write('taxEnabled: $taxEnabled, ')
          ..write('taxRate: $taxRate, ')
          ..write('serviceEnabled: $serviceEnabled, ')
          ..write('serviceRate: $serviceRate, ')
          ..write('showOutletAddress: $showOutletAddress, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    outletName,
    outletAddress,
    outletPhone,
    receiptHeader,
    receiptFooter,
    taxEnabled,
    taxRate,
    serviceEnabled,
    serviceRate,
    showOutletAddress,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.outletName == this.outletName &&
          other.outletAddress == this.outletAddress &&
          other.outletPhone == this.outletPhone &&
          other.receiptHeader == this.receiptHeader &&
          other.receiptFooter == this.receiptFooter &&
          other.taxEnabled == this.taxEnabled &&
          other.taxRate == this.taxRate &&
          other.serviceEnabled == this.serviceEnabled &&
          other.serviceRate == this.serviceRate &&
          other.showOutletAddress == this.showOutletAddress &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> id;
  final Value<String> outletName;
  final Value<String?> outletAddress;
  final Value<String?> outletPhone;
  final Value<String?> receiptHeader;
  final Value<String> receiptFooter;
  final Value<bool> taxEnabled;
  final Value<int> taxRate;
  final Value<bool> serviceEnabled;
  final Value<int> serviceRate;
  final Value<bool> showOutletAddress;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.outletName = const Value.absent(),
    this.outletAddress = const Value.absent(),
    this.outletPhone = const Value.absent(),
    this.receiptHeader = const Value.absent(),
    this.receiptFooter = const Value.absent(),
    this.taxEnabled = const Value.absent(),
    this.taxRate = const Value.absent(),
    this.serviceEnabled = const Value.absent(),
    this.serviceRate = const Value.absent(),
    this.showOutletAddress = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String id,
    this.outletName = const Value.absent(),
    this.outletAddress = const Value.absent(),
    this.outletPhone = const Value.absent(),
    this.receiptHeader = const Value.absent(),
    this.receiptFooter = const Value.absent(),
    this.taxEnabled = const Value.absent(),
    this.taxRate = const Value.absent(),
    this.serviceEnabled = const Value.absent(),
    this.serviceRate = const Value.absent(),
    this.showOutletAddress = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<AppSetting> custom({
    Expression<String>? id,
    Expression<String>? outletName,
    Expression<String>? outletAddress,
    Expression<String>? outletPhone,
    Expression<String>? receiptHeader,
    Expression<String>? receiptFooter,
    Expression<bool>? taxEnabled,
    Expression<int>? taxRate,
    Expression<bool>? serviceEnabled,
    Expression<int>? serviceRate,
    Expression<bool>? showOutletAddress,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (outletName != null) 'outlet_name': outletName,
      if (outletAddress != null) 'outlet_address': outletAddress,
      if (outletPhone != null) 'outlet_phone': outletPhone,
      if (receiptHeader != null) 'receipt_header': receiptHeader,
      if (receiptFooter != null) 'receipt_footer': receiptFooter,
      if (taxEnabled != null) 'tax_enabled': taxEnabled,
      if (taxRate != null) 'tax_rate': taxRate,
      if (serviceEnabled != null) 'service_enabled': serviceEnabled,
      if (serviceRate != null) 'service_rate': serviceRate,
      if (showOutletAddress != null) 'show_outlet_address': showOutletAddress,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? id,
    Value<String>? outletName,
    Value<String?>? outletAddress,
    Value<String?>? outletPhone,
    Value<String?>? receiptHeader,
    Value<String>? receiptFooter,
    Value<bool>? taxEnabled,
    Value<int>? taxRate,
    Value<bool>? serviceEnabled,
    Value<int>? serviceRate,
    Value<bool>? showOutletAddress,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      outletName: outletName ?? this.outletName,
      outletAddress: outletAddress ?? this.outletAddress,
      outletPhone: outletPhone ?? this.outletPhone,
      receiptHeader: receiptHeader ?? this.receiptHeader,
      receiptFooter: receiptFooter ?? this.receiptFooter,
      taxEnabled: taxEnabled ?? this.taxEnabled,
      taxRate: taxRate ?? this.taxRate,
      serviceEnabled: serviceEnabled ?? this.serviceEnabled,
      serviceRate: serviceRate ?? this.serviceRate,
      showOutletAddress: showOutletAddress ?? this.showOutletAddress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (outletName.present) {
      map['outlet_name'] = Variable<String>(outletName.value);
    }
    if (outletAddress.present) {
      map['outlet_address'] = Variable<String>(outletAddress.value);
    }
    if (outletPhone.present) {
      map['outlet_phone'] = Variable<String>(outletPhone.value);
    }
    if (receiptHeader.present) {
      map['receipt_header'] = Variable<String>(receiptHeader.value);
    }
    if (receiptFooter.present) {
      map['receipt_footer'] = Variable<String>(receiptFooter.value);
    }
    if (taxEnabled.present) {
      map['tax_enabled'] = Variable<bool>(taxEnabled.value);
    }
    if (taxRate.present) {
      map['tax_rate'] = Variable<int>(taxRate.value);
    }
    if (serviceEnabled.present) {
      map['service_enabled'] = Variable<bool>(serviceEnabled.value);
    }
    if (serviceRate.present) {
      map['service_rate'] = Variable<int>(serviceRate.value);
    }
    if (showOutletAddress.present) {
      map['show_outlet_address'] = Variable<bool>(showOutletAddress.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('outletName: $outletName, ')
          ..write('outletAddress: $outletAddress, ')
          ..write('outletPhone: $outletPhone, ')
          ..write('receiptHeader: $receiptHeader, ')
          ..write('receiptFooter: $receiptFooter, ')
          ..write('taxEnabled: $taxEnabled, ')
          ..write('taxRate: $taxRate, ')
          ..write('serviceEnabled: $serviceEnabled, ')
          ..write('serviceRate: $serviceRate, ')
          ..write('showOutletAddress: $showOutletAddress, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DeviceSettingsTable extends DeviceSettings
    with TableInfo<$DeviceSettingsTable, DeviceSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeviceSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _printerTypeMeta = const VerificationMeta(
    'printerType',
  );
  @override
  late final GeneratedColumn<String> printerType = GeneratedColumn<String>(
    'printer_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('bluetooth'),
  );
  static const VerificationMeta _printerNameMeta = const VerificationMeta(
    'printerName',
  );
  @override
  late final GeneratedColumn<String> printerName = GeneratedColumn<String>(
    'printer_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _printerAddressMeta = const VerificationMeta(
    'printerAddress',
  );
  @override
  late final GeneratedColumn<String> printerAddress = GeneratedColumn<String>(
    'printer_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _printerIpMeta = const VerificationMeta(
    'printerIp',
  );
  @override
  late final GeneratedColumn<String> printerIp = GeneratedColumn<String>(
    'printer_ip',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _printerPortMeta = const VerificationMeta(
    'printerPort',
  );
  @override
  late final GeneratedColumn<int> printerPort = GeneratedColumn<int>(
    'printer_port',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(9100),
  );
  static const VerificationMeta _paperWidthMeta = const VerificationMeta(
    'paperWidth',
  );
  @override
  late final GeneratedColumn<int> paperWidth = GeneratedColumn<int>(
    'paper_width',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(58),
  );
  static const VerificationMeta _cashDrawerEnabledMeta = const VerificationMeta(
    'cashDrawerEnabled',
  );
  @override
  late final GeneratedColumn<bool> cashDrawerEnabled = GeneratedColumn<bool>(
    'cash_drawer_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("cash_drawer_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _barcodeScannerEnabledMeta =
      const VerificationMeta('barcodeScannerEnabled');
  @override
  late final GeneratedColumn<bool> barcodeScannerEnabled =
      GeneratedColumn<bool>(
        'barcode_scanner_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("barcode_scanner_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(true),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    printerType,
    printerName,
    printerAddress,
    printerIp,
    printerPort,
    paperWidth,
    cashDrawerEnabled,
    barcodeScannerEnabled,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'device_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeviceSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('printer_type')) {
      context.handle(
        _printerTypeMeta,
        printerType.isAcceptableOrUnknown(
          data['printer_type']!,
          _printerTypeMeta,
        ),
      );
    }
    if (data.containsKey('printer_name')) {
      context.handle(
        _printerNameMeta,
        printerName.isAcceptableOrUnknown(
          data['printer_name']!,
          _printerNameMeta,
        ),
      );
    }
    if (data.containsKey('printer_address')) {
      context.handle(
        _printerAddressMeta,
        printerAddress.isAcceptableOrUnknown(
          data['printer_address']!,
          _printerAddressMeta,
        ),
      );
    }
    if (data.containsKey('printer_ip')) {
      context.handle(
        _printerIpMeta,
        printerIp.isAcceptableOrUnknown(data['printer_ip']!, _printerIpMeta),
      );
    }
    if (data.containsKey('printer_port')) {
      context.handle(
        _printerPortMeta,
        printerPort.isAcceptableOrUnknown(
          data['printer_port']!,
          _printerPortMeta,
        ),
      );
    }
    if (data.containsKey('paper_width')) {
      context.handle(
        _paperWidthMeta,
        paperWidth.isAcceptableOrUnknown(data['paper_width']!, _paperWidthMeta),
      );
    }
    if (data.containsKey('cash_drawer_enabled')) {
      context.handle(
        _cashDrawerEnabledMeta,
        cashDrawerEnabled.isAcceptableOrUnknown(
          data['cash_drawer_enabled']!,
          _cashDrawerEnabledMeta,
        ),
      );
    }
    if (data.containsKey('barcode_scanner_enabled')) {
      context.handle(
        _barcodeScannerEnabledMeta,
        barcodeScannerEnabled.isAcceptableOrUnknown(
          data['barcode_scanner_enabled']!,
          _barcodeScannerEnabledMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeviceSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeviceSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      printerType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}printer_type'],
      )!,
      printerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}printer_name'],
      ),
      printerAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}printer_address'],
      ),
      printerIp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}printer_ip'],
      ),
      printerPort: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}printer_port'],
      )!,
      paperWidth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}paper_width'],
      )!,
      cashDrawerEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}cash_drawer_enabled'],
      )!,
      barcodeScannerEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}barcode_scanner_enabled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $DeviceSettingsTable createAlias(String alias) {
    return $DeviceSettingsTable(attachedDatabase, alias);
  }
}

class DeviceSetting extends DataClass implements Insertable<DeviceSetting> {
  final String id;
  final String printerType;
  final String? printerName;
  final String? printerAddress;
  final String? printerIp;
  final int printerPort;
  final int paperWidth;
  final bool cashDrawerEnabled;
  final bool barcodeScannerEnabled;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const DeviceSetting({
    required this.id,
    required this.printerType,
    this.printerName,
    this.printerAddress,
    this.printerIp,
    required this.printerPort,
    required this.paperWidth,
    required this.cashDrawerEnabled,
    required this.barcodeScannerEnabled,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['printer_type'] = Variable<String>(printerType);
    if (!nullToAbsent || printerName != null) {
      map['printer_name'] = Variable<String>(printerName);
    }
    if (!nullToAbsent || printerAddress != null) {
      map['printer_address'] = Variable<String>(printerAddress);
    }
    if (!nullToAbsent || printerIp != null) {
      map['printer_ip'] = Variable<String>(printerIp);
    }
    map['printer_port'] = Variable<int>(printerPort);
    map['paper_width'] = Variable<int>(paperWidth);
    map['cash_drawer_enabled'] = Variable<bool>(cashDrawerEnabled);
    map['barcode_scanner_enabled'] = Variable<bool>(barcodeScannerEnabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  DeviceSettingsCompanion toCompanion(bool nullToAbsent) {
    return DeviceSettingsCompanion(
      id: Value(id),
      printerType: Value(printerType),
      printerName: printerName == null && nullToAbsent
          ? const Value.absent()
          : Value(printerName),
      printerAddress: printerAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(printerAddress),
      printerIp: printerIp == null && nullToAbsent
          ? const Value.absent()
          : Value(printerIp),
      printerPort: Value(printerPort),
      paperWidth: Value(paperWidth),
      cashDrawerEnabled: Value(cashDrawerEnabled),
      barcodeScannerEnabled: Value(barcodeScannerEnabled),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory DeviceSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeviceSetting(
      id: serializer.fromJson<String>(json['id']),
      printerType: serializer.fromJson<String>(json['printerType']),
      printerName: serializer.fromJson<String?>(json['printerName']),
      printerAddress: serializer.fromJson<String?>(json['printerAddress']),
      printerIp: serializer.fromJson<String?>(json['printerIp']),
      printerPort: serializer.fromJson<int>(json['printerPort']),
      paperWidth: serializer.fromJson<int>(json['paperWidth']),
      cashDrawerEnabled: serializer.fromJson<bool>(json['cashDrawerEnabled']),
      barcodeScannerEnabled: serializer.fromJson<bool>(
        json['barcodeScannerEnabled'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'printerType': serializer.toJson<String>(printerType),
      'printerName': serializer.toJson<String?>(printerName),
      'printerAddress': serializer.toJson<String?>(printerAddress),
      'printerIp': serializer.toJson<String?>(printerIp),
      'printerPort': serializer.toJson<int>(printerPort),
      'paperWidth': serializer.toJson<int>(paperWidth),
      'cashDrawerEnabled': serializer.toJson<bool>(cashDrawerEnabled),
      'barcodeScannerEnabled': serializer.toJson<bool>(barcodeScannerEnabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  DeviceSetting copyWith({
    String? id,
    String? printerType,
    Value<String?> printerName = const Value.absent(),
    Value<String?> printerAddress = const Value.absent(),
    Value<String?> printerIp = const Value.absent(),
    int? printerPort,
    int? paperWidth,
    bool? cashDrawerEnabled,
    bool? barcodeScannerEnabled,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => DeviceSetting(
    id: id ?? this.id,
    printerType: printerType ?? this.printerType,
    printerName: printerName.present ? printerName.value : this.printerName,
    printerAddress: printerAddress.present
        ? printerAddress.value
        : this.printerAddress,
    printerIp: printerIp.present ? printerIp.value : this.printerIp,
    printerPort: printerPort ?? this.printerPort,
    paperWidth: paperWidth ?? this.paperWidth,
    cashDrawerEnabled: cashDrawerEnabled ?? this.cashDrawerEnabled,
    barcodeScannerEnabled: barcodeScannerEnabled ?? this.barcodeScannerEnabled,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  DeviceSetting copyWithCompanion(DeviceSettingsCompanion data) {
    return DeviceSetting(
      id: data.id.present ? data.id.value : this.id,
      printerType: data.printerType.present
          ? data.printerType.value
          : this.printerType,
      printerName: data.printerName.present
          ? data.printerName.value
          : this.printerName,
      printerAddress: data.printerAddress.present
          ? data.printerAddress.value
          : this.printerAddress,
      printerIp: data.printerIp.present ? data.printerIp.value : this.printerIp,
      printerPort: data.printerPort.present
          ? data.printerPort.value
          : this.printerPort,
      paperWidth: data.paperWidth.present
          ? data.paperWidth.value
          : this.paperWidth,
      cashDrawerEnabled: data.cashDrawerEnabled.present
          ? data.cashDrawerEnabled.value
          : this.cashDrawerEnabled,
      barcodeScannerEnabled: data.barcodeScannerEnabled.present
          ? data.barcodeScannerEnabled.value
          : this.barcodeScannerEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeviceSetting(')
          ..write('id: $id, ')
          ..write('printerType: $printerType, ')
          ..write('printerName: $printerName, ')
          ..write('printerAddress: $printerAddress, ')
          ..write('printerIp: $printerIp, ')
          ..write('printerPort: $printerPort, ')
          ..write('paperWidth: $paperWidth, ')
          ..write('cashDrawerEnabled: $cashDrawerEnabled, ')
          ..write('barcodeScannerEnabled: $barcodeScannerEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    printerType,
    printerName,
    printerAddress,
    printerIp,
    printerPort,
    paperWidth,
    cashDrawerEnabled,
    barcodeScannerEnabled,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceSetting &&
          other.id == this.id &&
          other.printerType == this.printerType &&
          other.printerName == this.printerName &&
          other.printerAddress == this.printerAddress &&
          other.printerIp == this.printerIp &&
          other.printerPort == this.printerPort &&
          other.paperWidth == this.paperWidth &&
          other.cashDrawerEnabled == this.cashDrawerEnabled &&
          other.barcodeScannerEnabled == this.barcodeScannerEnabled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DeviceSettingsCompanion extends UpdateCompanion<DeviceSetting> {
  final Value<String> id;
  final Value<String> printerType;
  final Value<String?> printerName;
  final Value<String?> printerAddress;
  final Value<String?> printerIp;
  final Value<int> printerPort;
  final Value<int> paperWidth;
  final Value<bool> cashDrawerEnabled;
  final Value<bool> barcodeScannerEnabled;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const DeviceSettingsCompanion({
    this.id = const Value.absent(),
    this.printerType = const Value.absent(),
    this.printerName = const Value.absent(),
    this.printerAddress = const Value.absent(),
    this.printerIp = const Value.absent(),
    this.printerPort = const Value.absent(),
    this.paperWidth = const Value.absent(),
    this.cashDrawerEnabled = const Value.absent(),
    this.barcodeScannerEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DeviceSettingsCompanion.insert({
    required String id,
    this.printerType = const Value.absent(),
    this.printerName = const Value.absent(),
    this.printerAddress = const Value.absent(),
    this.printerIp = const Value.absent(),
    this.printerPort = const Value.absent(),
    this.paperWidth = const Value.absent(),
    this.cashDrawerEnabled = const Value.absent(),
    this.barcodeScannerEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<DeviceSetting> custom({
    Expression<String>? id,
    Expression<String>? printerType,
    Expression<String>? printerName,
    Expression<String>? printerAddress,
    Expression<String>? printerIp,
    Expression<int>? printerPort,
    Expression<int>? paperWidth,
    Expression<bool>? cashDrawerEnabled,
    Expression<bool>? barcodeScannerEnabled,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (printerType != null) 'printer_type': printerType,
      if (printerName != null) 'printer_name': printerName,
      if (printerAddress != null) 'printer_address': printerAddress,
      if (printerIp != null) 'printer_ip': printerIp,
      if (printerPort != null) 'printer_port': printerPort,
      if (paperWidth != null) 'paper_width': paperWidth,
      if (cashDrawerEnabled != null) 'cash_drawer_enabled': cashDrawerEnabled,
      if (barcodeScannerEnabled != null)
        'barcode_scanner_enabled': barcodeScannerEnabled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DeviceSettingsCompanion copyWith({
    Value<String>? id,
    Value<String>? printerType,
    Value<String?>? printerName,
    Value<String?>? printerAddress,
    Value<String?>? printerIp,
    Value<int>? printerPort,
    Value<int>? paperWidth,
    Value<bool>? cashDrawerEnabled,
    Value<bool>? barcodeScannerEnabled,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return DeviceSettingsCompanion(
      id: id ?? this.id,
      printerType: printerType ?? this.printerType,
      printerName: printerName ?? this.printerName,
      printerAddress: printerAddress ?? this.printerAddress,
      printerIp: printerIp ?? this.printerIp,
      printerPort: printerPort ?? this.printerPort,
      paperWidth: paperWidth ?? this.paperWidth,
      cashDrawerEnabled: cashDrawerEnabled ?? this.cashDrawerEnabled,
      barcodeScannerEnabled:
          barcodeScannerEnabled ?? this.barcodeScannerEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (printerType.present) {
      map['printer_type'] = Variable<String>(printerType.value);
    }
    if (printerName.present) {
      map['printer_name'] = Variable<String>(printerName.value);
    }
    if (printerAddress.present) {
      map['printer_address'] = Variable<String>(printerAddress.value);
    }
    if (printerIp.present) {
      map['printer_ip'] = Variable<String>(printerIp.value);
    }
    if (printerPort.present) {
      map['printer_port'] = Variable<int>(printerPort.value);
    }
    if (paperWidth.present) {
      map['paper_width'] = Variable<int>(paperWidth.value);
    }
    if (cashDrawerEnabled.present) {
      map['cash_drawer_enabled'] = Variable<bool>(cashDrawerEnabled.value);
    }
    if (barcodeScannerEnabled.present) {
      map['barcode_scanner_enabled'] = Variable<bool>(
        barcodeScannerEnabled.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeviceSettingsCompanion(')
          ..write('id: $id, ')
          ..write('printerType: $printerType, ')
          ..write('printerName: $printerName, ')
          ..write('printerAddress: $printerAddress, ')
          ..write('printerIp: $printerIp, ')
          ..write('printerPort: $printerPort, ')
          ..write('paperWidth: $paperWidth, ')
          ..write('cashDrawerEnabled: $cashDrawerEnabled, ')
          ..write('barcodeScannerEnabled: $barcodeScannerEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CashierSettingsTable extends CashierSettings
    with TableInfo<$CashierSettingsTable, CashierSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashierSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoicePrefixMeta = const VerificationMeta(
    'invoicePrefix',
  );
  @override
  late final GeneratedColumn<String> invoicePrefix = GeneratedColumn<String>(
    'invoice_prefix',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('INV'),
  );
  static const VerificationMeta _resetInvoiceDailyMeta = const VerificationMeta(
    'resetInvoiceDaily',
  );
  @override
  late final GeneratedColumn<bool> resetInvoiceDaily = GeneratedColumn<bool>(
    'reset_invoice_daily',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reset_invoice_daily" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _defaultPaymentMethodMeta =
      const VerificationMeta('defaultPaymentMethod');
  @override
  late final GeneratedColumn<String> defaultPaymentMethod =
      GeneratedColumn<String>(
        'default_payment_method',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('cash'),
      );
  static const VerificationMeta _defaultOrderTypeMeta = const VerificationMeta(
    'defaultOrderType',
  );
  @override
  late final GeneratedColumn<String> defaultOrderType = GeneratedColumn<String>(
    'default_order_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Bungkus'),
  );
  static const VerificationMeta _manualDiscountEnabledMeta =
      const VerificationMeta('manualDiscountEnabled');
  @override
  late final GeneratedColumn<bool> manualDiscountEnabled =
      GeneratedColumn<bool>(
        'manual_discount_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("manual_discount_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(true),
      );
  static const VerificationMeta _customerRequiredMeta = const VerificationMeta(
    'customerRequired',
  );
  @override
  late final GeneratedColumn<bool> customerRequired = GeneratedColumn<bool>(
    'customer_required',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("customer_required" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoicePrefix,
    resetInvoiceDaily,
    defaultPaymentMethod,
    defaultOrderType,
    manualDiscountEnabled,
    customerRequired,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cashier_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<CashierSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('invoice_prefix')) {
      context.handle(
        _invoicePrefixMeta,
        invoicePrefix.isAcceptableOrUnknown(
          data['invoice_prefix']!,
          _invoicePrefixMeta,
        ),
      );
    }
    if (data.containsKey('reset_invoice_daily')) {
      context.handle(
        _resetInvoiceDailyMeta,
        resetInvoiceDaily.isAcceptableOrUnknown(
          data['reset_invoice_daily']!,
          _resetInvoiceDailyMeta,
        ),
      );
    }
    if (data.containsKey('default_payment_method')) {
      context.handle(
        _defaultPaymentMethodMeta,
        defaultPaymentMethod.isAcceptableOrUnknown(
          data['default_payment_method']!,
          _defaultPaymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('default_order_type')) {
      context.handle(
        _defaultOrderTypeMeta,
        defaultOrderType.isAcceptableOrUnknown(
          data['default_order_type']!,
          _defaultOrderTypeMeta,
        ),
      );
    }
    if (data.containsKey('manual_discount_enabled')) {
      context.handle(
        _manualDiscountEnabledMeta,
        manualDiscountEnabled.isAcceptableOrUnknown(
          data['manual_discount_enabled']!,
          _manualDiscountEnabledMeta,
        ),
      );
    }
    if (data.containsKey('customer_required')) {
      context.handle(
        _customerRequiredMeta,
        customerRequired.isAcceptableOrUnknown(
          data['customer_required']!,
          _customerRequiredMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashierSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashierSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      invoicePrefix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_prefix'],
      )!,
      resetInvoiceDaily: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reset_invoice_daily'],
      )!,
      defaultPaymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_payment_method'],
      )!,
      defaultOrderType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_order_type'],
      )!,
      manualDiscountEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}manual_discount_enabled'],
      )!,
      customerRequired: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}customer_required'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $CashierSettingsTable createAlias(String alias) {
    return $CashierSettingsTable(attachedDatabase, alias);
  }
}

class CashierSetting extends DataClass implements Insertable<CashierSetting> {
  final String id;
  final String invoicePrefix;
  final bool resetInvoiceDaily;
  final String defaultPaymentMethod;
  final String defaultOrderType;
  final bool manualDiscountEnabled;
  final bool customerRequired;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const CashierSetting({
    required this.id,
    required this.invoicePrefix,
    required this.resetInvoiceDaily,
    required this.defaultPaymentMethod,
    required this.defaultOrderType,
    required this.manualDiscountEnabled,
    required this.customerRequired,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['invoice_prefix'] = Variable<String>(invoicePrefix);
    map['reset_invoice_daily'] = Variable<bool>(resetInvoiceDaily);
    map['default_payment_method'] = Variable<String>(defaultPaymentMethod);
    map['default_order_type'] = Variable<String>(defaultOrderType);
    map['manual_discount_enabled'] = Variable<bool>(manualDiscountEnabled);
    map['customer_required'] = Variable<bool>(customerRequired);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  CashierSettingsCompanion toCompanion(bool nullToAbsent) {
    return CashierSettingsCompanion(
      id: Value(id),
      invoicePrefix: Value(invoicePrefix),
      resetInvoiceDaily: Value(resetInvoiceDaily),
      defaultPaymentMethod: Value(defaultPaymentMethod),
      defaultOrderType: Value(defaultOrderType),
      manualDiscountEnabled: Value(manualDiscountEnabled),
      customerRequired: Value(customerRequired),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory CashierSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashierSetting(
      id: serializer.fromJson<String>(json['id']),
      invoicePrefix: serializer.fromJson<String>(json['invoicePrefix']),
      resetInvoiceDaily: serializer.fromJson<bool>(json['resetInvoiceDaily']),
      defaultPaymentMethod: serializer.fromJson<String>(
        json['defaultPaymentMethod'],
      ),
      defaultOrderType: serializer.fromJson<String>(json['defaultOrderType']),
      manualDiscountEnabled: serializer.fromJson<bool>(
        json['manualDiscountEnabled'],
      ),
      customerRequired: serializer.fromJson<bool>(json['customerRequired']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'invoicePrefix': serializer.toJson<String>(invoicePrefix),
      'resetInvoiceDaily': serializer.toJson<bool>(resetInvoiceDaily),
      'defaultPaymentMethod': serializer.toJson<String>(defaultPaymentMethod),
      'defaultOrderType': serializer.toJson<String>(defaultOrderType),
      'manualDiscountEnabled': serializer.toJson<bool>(manualDiscountEnabled),
      'customerRequired': serializer.toJson<bool>(customerRequired),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  CashierSetting copyWith({
    String? id,
    String? invoicePrefix,
    bool? resetInvoiceDaily,
    String? defaultPaymentMethod,
    String? defaultOrderType,
    bool? manualDiscountEnabled,
    bool? customerRequired,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => CashierSetting(
    id: id ?? this.id,
    invoicePrefix: invoicePrefix ?? this.invoicePrefix,
    resetInvoiceDaily: resetInvoiceDaily ?? this.resetInvoiceDaily,
    defaultPaymentMethod: defaultPaymentMethod ?? this.defaultPaymentMethod,
    defaultOrderType: defaultOrderType ?? this.defaultOrderType,
    manualDiscountEnabled: manualDiscountEnabled ?? this.manualDiscountEnabled,
    customerRequired: customerRequired ?? this.customerRequired,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  CashierSetting copyWithCompanion(CashierSettingsCompanion data) {
    return CashierSetting(
      id: data.id.present ? data.id.value : this.id,
      invoicePrefix: data.invoicePrefix.present
          ? data.invoicePrefix.value
          : this.invoicePrefix,
      resetInvoiceDaily: data.resetInvoiceDaily.present
          ? data.resetInvoiceDaily.value
          : this.resetInvoiceDaily,
      defaultPaymentMethod: data.defaultPaymentMethod.present
          ? data.defaultPaymentMethod.value
          : this.defaultPaymentMethod,
      defaultOrderType: data.defaultOrderType.present
          ? data.defaultOrderType.value
          : this.defaultOrderType,
      manualDiscountEnabled: data.manualDiscountEnabled.present
          ? data.manualDiscountEnabled.value
          : this.manualDiscountEnabled,
      customerRequired: data.customerRequired.present
          ? data.customerRequired.value
          : this.customerRequired,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashierSetting(')
          ..write('id: $id, ')
          ..write('invoicePrefix: $invoicePrefix, ')
          ..write('resetInvoiceDaily: $resetInvoiceDaily, ')
          ..write('defaultPaymentMethod: $defaultPaymentMethod, ')
          ..write('defaultOrderType: $defaultOrderType, ')
          ..write('manualDiscountEnabled: $manualDiscountEnabled, ')
          ..write('customerRequired: $customerRequired, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoicePrefix,
    resetInvoiceDaily,
    defaultPaymentMethod,
    defaultOrderType,
    manualDiscountEnabled,
    customerRequired,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashierSetting &&
          other.id == this.id &&
          other.invoicePrefix == this.invoicePrefix &&
          other.resetInvoiceDaily == this.resetInvoiceDaily &&
          other.defaultPaymentMethod == this.defaultPaymentMethod &&
          other.defaultOrderType == this.defaultOrderType &&
          other.manualDiscountEnabled == this.manualDiscountEnabled &&
          other.customerRequired == this.customerRequired &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CashierSettingsCompanion extends UpdateCompanion<CashierSetting> {
  final Value<String> id;
  final Value<String> invoicePrefix;
  final Value<bool> resetInvoiceDaily;
  final Value<String> defaultPaymentMethod;
  final Value<String> defaultOrderType;
  final Value<bool> manualDiscountEnabled;
  final Value<bool> customerRequired;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const CashierSettingsCompanion({
    this.id = const Value.absent(),
    this.invoicePrefix = const Value.absent(),
    this.resetInvoiceDaily = const Value.absent(),
    this.defaultPaymentMethod = const Value.absent(),
    this.defaultOrderType = const Value.absent(),
    this.manualDiscountEnabled = const Value.absent(),
    this.customerRequired = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CashierSettingsCompanion.insert({
    required String id,
    this.invoicePrefix = const Value.absent(),
    this.resetInvoiceDaily = const Value.absent(),
    this.defaultPaymentMethod = const Value.absent(),
    this.defaultOrderType = const Value.absent(),
    this.manualDiscountEnabled = const Value.absent(),
    this.customerRequired = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<CashierSetting> custom({
    Expression<String>? id,
    Expression<String>? invoicePrefix,
    Expression<bool>? resetInvoiceDaily,
    Expression<String>? defaultPaymentMethod,
    Expression<String>? defaultOrderType,
    Expression<bool>? manualDiscountEnabled,
    Expression<bool>? customerRequired,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoicePrefix != null) 'invoice_prefix': invoicePrefix,
      if (resetInvoiceDaily != null) 'reset_invoice_daily': resetInvoiceDaily,
      if (defaultPaymentMethod != null)
        'default_payment_method': defaultPaymentMethod,
      if (defaultOrderType != null) 'default_order_type': defaultOrderType,
      if (manualDiscountEnabled != null)
        'manual_discount_enabled': manualDiscountEnabled,
      if (customerRequired != null) 'customer_required': customerRequired,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CashierSettingsCompanion copyWith({
    Value<String>? id,
    Value<String>? invoicePrefix,
    Value<bool>? resetInvoiceDaily,
    Value<String>? defaultPaymentMethod,
    Value<String>? defaultOrderType,
    Value<bool>? manualDiscountEnabled,
    Value<bool>? customerRequired,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return CashierSettingsCompanion(
      id: id ?? this.id,
      invoicePrefix: invoicePrefix ?? this.invoicePrefix,
      resetInvoiceDaily: resetInvoiceDaily ?? this.resetInvoiceDaily,
      defaultPaymentMethod: defaultPaymentMethod ?? this.defaultPaymentMethod,
      defaultOrderType: defaultOrderType ?? this.defaultOrderType,
      manualDiscountEnabled:
          manualDiscountEnabled ?? this.manualDiscountEnabled,
      customerRequired: customerRequired ?? this.customerRequired,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (invoicePrefix.present) {
      map['invoice_prefix'] = Variable<String>(invoicePrefix.value);
    }
    if (resetInvoiceDaily.present) {
      map['reset_invoice_daily'] = Variable<bool>(resetInvoiceDaily.value);
    }
    if (defaultPaymentMethod.present) {
      map['default_payment_method'] = Variable<String>(
        defaultPaymentMethod.value,
      );
    }
    if (defaultOrderType.present) {
      map['default_order_type'] = Variable<String>(defaultOrderType.value);
    }
    if (manualDiscountEnabled.present) {
      map['manual_discount_enabled'] = Variable<bool>(
        manualDiscountEnabled.value,
      );
    }
    if (customerRequired.present) {
      map['customer_required'] = Variable<bool>(customerRequired.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CashierSettingsCompanion(')
          ..write('id: $id, ')
          ..write('invoicePrefix: $invoicePrefix, ')
          ..write('resetInvoiceDaily: $resetInvoiceDaily, ')
          ..write('defaultPaymentMethod: $defaultPaymentMethod, ')
          ..write('defaultOrderType: $defaultOrderType, ')
          ..write('manualDiscountEnabled: $manualDiscountEnabled, ')
          ..write('customerRequired: $customerRequired, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentSettingsTable extends PaymentSettings
    with TableInfo<$PaymentSettingsTable, PaymentSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qrisEnabledMeta = const VerificationMeta(
    'qrisEnabled',
  );
  @override
  late final GeneratedColumn<bool> qrisEnabled = GeneratedColumn<bool>(
    'qris_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("qris_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _qrisProviderMeta = const VerificationMeta(
    'qrisProvider',
  );
  @override
  late final GeneratedColumn<String> qrisProvider = GeneratedColumn<String>(
    'qris_provider',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _qrisMerchantIdMeta = const VerificationMeta(
    'qrisMerchantId',
  );
  @override
  late final GeneratedColumn<String> qrisMerchantId = GeneratedColumn<String>(
    'qris_merchant_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _qrisImagePathMeta = const VerificationMeta(
    'qrisImagePath',
  );
  @override
  late final GeneratedColumn<String> qrisImagePath = GeneratedColumn<String>(
    'qris_image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _qrisInstructionMeta = const VerificationMeta(
    'qrisInstruction',
  );
  @override
  late final GeneratedColumn<String> qrisInstruction = GeneratedColumn<String>(
    'qris_instruction',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _debitEnabledMeta = const VerificationMeta(
    'debitEnabled',
  );
  @override
  late final GeneratedColumn<bool> debitEnabled = GeneratedColumn<bool>(
    'debit_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("debit_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _debitProviderMeta = const VerificationMeta(
    'debitProvider',
  );
  @override
  late final GeneratedColumn<String> debitProvider = GeneratedColumn<String>(
    'debit_provider',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _debitMerchantIdMeta = const VerificationMeta(
    'debitMerchantId',
  );
  @override
  late final GeneratedColumn<String> debitMerchantId = GeneratedColumn<String>(
    'debit_merchant_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _debitInstructionMeta = const VerificationMeta(
    'debitInstruction',
  );
  @override
  late final GeneratedColumn<String> debitInstruction = GeneratedColumn<String>(
    'debit_instruction',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transferEnabledMeta = const VerificationMeta(
    'transferEnabled',
  );
  @override
  late final GeneratedColumn<bool> transferEnabled = GeneratedColumn<bool>(
    'transfer_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("transfer_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _transferBankNameMeta = const VerificationMeta(
    'transferBankName',
  );
  @override
  late final GeneratedColumn<String> transferBankName = GeneratedColumn<String>(
    'transfer_bank_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transferAccountNumberMeta =
      const VerificationMeta('transferAccountNumber');
  @override
  late final GeneratedColumn<String> transferAccountNumber =
      GeneratedColumn<String>(
        'transfer_account_number',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _transferAccountNameMeta =
      const VerificationMeta('transferAccountName');
  @override
  late final GeneratedColumn<String> transferAccountName =
      GeneratedColumn<String>(
        'transfer_account_name',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _transferInstructionMeta =
      const VerificationMeta('transferInstruction');
  @override
  late final GeneratedColumn<String> transferInstruction =
      GeneratedColumn<String>(
        'transfer_instruction',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    qrisEnabled,
    qrisProvider,
    qrisMerchantId,
    qrisImagePath,
    qrisInstruction,
    debitEnabled,
    debitProvider,
    debitMerchantId,
    debitInstruction,
    transferEnabled,
    transferBankName,
    transferAccountNumber,
    transferAccountName,
    transferInstruction,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('qris_enabled')) {
      context.handle(
        _qrisEnabledMeta,
        qrisEnabled.isAcceptableOrUnknown(
          data['qris_enabled']!,
          _qrisEnabledMeta,
        ),
      );
    }
    if (data.containsKey('qris_provider')) {
      context.handle(
        _qrisProviderMeta,
        qrisProvider.isAcceptableOrUnknown(
          data['qris_provider']!,
          _qrisProviderMeta,
        ),
      );
    }
    if (data.containsKey('qris_merchant_id')) {
      context.handle(
        _qrisMerchantIdMeta,
        qrisMerchantId.isAcceptableOrUnknown(
          data['qris_merchant_id']!,
          _qrisMerchantIdMeta,
        ),
      );
    }
    if (data.containsKey('qris_image_path')) {
      context.handle(
        _qrisImagePathMeta,
        qrisImagePath.isAcceptableOrUnknown(
          data['qris_image_path']!,
          _qrisImagePathMeta,
        ),
      );
    }
    if (data.containsKey('qris_instruction')) {
      context.handle(
        _qrisInstructionMeta,
        qrisInstruction.isAcceptableOrUnknown(
          data['qris_instruction']!,
          _qrisInstructionMeta,
        ),
      );
    }
    if (data.containsKey('debit_enabled')) {
      context.handle(
        _debitEnabledMeta,
        debitEnabled.isAcceptableOrUnknown(
          data['debit_enabled']!,
          _debitEnabledMeta,
        ),
      );
    }
    if (data.containsKey('debit_provider')) {
      context.handle(
        _debitProviderMeta,
        debitProvider.isAcceptableOrUnknown(
          data['debit_provider']!,
          _debitProviderMeta,
        ),
      );
    }
    if (data.containsKey('debit_merchant_id')) {
      context.handle(
        _debitMerchantIdMeta,
        debitMerchantId.isAcceptableOrUnknown(
          data['debit_merchant_id']!,
          _debitMerchantIdMeta,
        ),
      );
    }
    if (data.containsKey('debit_instruction')) {
      context.handle(
        _debitInstructionMeta,
        debitInstruction.isAcceptableOrUnknown(
          data['debit_instruction']!,
          _debitInstructionMeta,
        ),
      );
    }
    if (data.containsKey('transfer_enabled')) {
      context.handle(
        _transferEnabledMeta,
        transferEnabled.isAcceptableOrUnknown(
          data['transfer_enabled']!,
          _transferEnabledMeta,
        ),
      );
    }
    if (data.containsKey('transfer_bank_name')) {
      context.handle(
        _transferBankNameMeta,
        transferBankName.isAcceptableOrUnknown(
          data['transfer_bank_name']!,
          _transferBankNameMeta,
        ),
      );
    }
    if (data.containsKey('transfer_account_number')) {
      context.handle(
        _transferAccountNumberMeta,
        transferAccountNumber.isAcceptableOrUnknown(
          data['transfer_account_number']!,
          _transferAccountNumberMeta,
        ),
      );
    }
    if (data.containsKey('transfer_account_name')) {
      context.handle(
        _transferAccountNameMeta,
        transferAccountName.isAcceptableOrUnknown(
          data['transfer_account_name']!,
          _transferAccountNameMeta,
        ),
      );
    }
    if (data.containsKey('transfer_instruction')) {
      context.handle(
        _transferInstructionMeta,
        transferInstruction.isAcceptableOrUnknown(
          data['transfer_instruction']!,
          _transferInstructionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      qrisEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}qris_enabled'],
      )!,
      qrisProvider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qris_provider'],
      ),
      qrisMerchantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qris_merchant_id'],
      ),
      qrisImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qris_image_path'],
      ),
      qrisInstruction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qris_instruction'],
      ),
      debitEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}debit_enabled'],
      )!,
      debitProvider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}debit_provider'],
      ),
      debitMerchantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}debit_merchant_id'],
      ),
      debitInstruction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}debit_instruction'],
      ),
      transferEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}transfer_enabled'],
      )!,
      transferBankName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transfer_bank_name'],
      ),
      transferAccountNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transfer_account_number'],
      ),
      transferAccountName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transfer_account_name'],
      ),
      transferInstruction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transfer_instruction'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $PaymentSettingsTable createAlias(String alias) {
    return $PaymentSettingsTable(attachedDatabase, alias);
  }
}

class PaymentSetting extends DataClass implements Insertable<PaymentSetting> {
  final String id;
  final bool qrisEnabled;
  final String? qrisProvider;
  final String? qrisMerchantId;
  final String? qrisImagePath;
  final String? qrisInstruction;
  final bool debitEnabled;
  final String? debitProvider;
  final String? debitMerchantId;
  final String? debitInstruction;
  final bool transferEnabled;
  final String? transferBankName;
  final String? transferAccountNumber;
  final String? transferAccountName;
  final String? transferInstruction;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const PaymentSetting({
    required this.id,
    required this.qrisEnabled,
    this.qrisProvider,
    this.qrisMerchantId,
    this.qrisImagePath,
    this.qrisInstruction,
    required this.debitEnabled,
    this.debitProvider,
    this.debitMerchantId,
    this.debitInstruction,
    required this.transferEnabled,
    this.transferBankName,
    this.transferAccountNumber,
    this.transferAccountName,
    this.transferInstruction,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['qris_enabled'] = Variable<bool>(qrisEnabled);
    if (!nullToAbsent || qrisProvider != null) {
      map['qris_provider'] = Variable<String>(qrisProvider);
    }
    if (!nullToAbsent || qrisMerchantId != null) {
      map['qris_merchant_id'] = Variable<String>(qrisMerchantId);
    }
    if (!nullToAbsent || qrisImagePath != null) {
      map['qris_image_path'] = Variable<String>(qrisImagePath);
    }
    if (!nullToAbsent || qrisInstruction != null) {
      map['qris_instruction'] = Variable<String>(qrisInstruction);
    }
    map['debit_enabled'] = Variable<bool>(debitEnabled);
    if (!nullToAbsent || debitProvider != null) {
      map['debit_provider'] = Variable<String>(debitProvider);
    }
    if (!nullToAbsent || debitMerchantId != null) {
      map['debit_merchant_id'] = Variable<String>(debitMerchantId);
    }
    if (!nullToAbsent || debitInstruction != null) {
      map['debit_instruction'] = Variable<String>(debitInstruction);
    }
    map['transfer_enabled'] = Variable<bool>(transferEnabled);
    if (!nullToAbsent || transferBankName != null) {
      map['transfer_bank_name'] = Variable<String>(transferBankName);
    }
    if (!nullToAbsent || transferAccountNumber != null) {
      map['transfer_account_number'] = Variable<String>(transferAccountNumber);
    }
    if (!nullToAbsent || transferAccountName != null) {
      map['transfer_account_name'] = Variable<String>(transferAccountName);
    }
    if (!nullToAbsent || transferInstruction != null) {
      map['transfer_instruction'] = Variable<String>(transferInstruction);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  PaymentSettingsCompanion toCompanion(bool nullToAbsent) {
    return PaymentSettingsCompanion(
      id: Value(id),
      qrisEnabled: Value(qrisEnabled),
      qrisProvider: qrisProvider == null && nullToAbsent
          ? const Value.absent()
          : Value(qrisProvider),
      qrisMerchantId: qrisMerchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(qrisMerchantId),
      qrisImagePath: qrisImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(qrisImagePath),
      qrisInstruction: qrisInstruction == null && nullToAbsent
          ? const Value.absent()
          : Value(qrisInstruction),
      debitEnabled: Value(debitEnabled),
      debitProvider: debitProvider == null && nullToAbsent
          ? const Value.absent()
          : Value(debitProvider),
      debitMerchantId: debitMerchantId == null && nullToAbsent
          ? const Value.absent()
          : Value(debitMerchantId),
      debitInstruction: debitInstruction == null && nullToAbsent
          ? const Value.absent()
          : Value(debitInstruction),
      transferEnabled: Value(transferEnabled),
      transferBankName: transferBankName == null && nullToAbsent
          ? const Value.absent()
          : Value(transferBankName),
      transferAccountNumber: transferAccountNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(transferAccountNumber),
      transferAccountName: transferAccountName == null && nullToAbsent
          ? const Value.absent()
          : Value(transferAccountName),
      transferInstruction: transferInstruction == null && nullToAbsent
          ? const Value.absent()
          : Value(transferInstruction),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory PaymentSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentSetting(
      id: serializer.fromJson<String>(json['id']),
      qrisEnabled: serializer.fromJson<bool>(json['qrisEnabled']),
      qrisProvider: serializer.fromJson<String?>(json['qrisProvider']),
      qrisMerchantId: serializer.fromJson<String?>(json['qrisMerchantId']),
      qrisImagePath: serializer.fromJson<String?>(json['qrisImagePath']),
      qrisInstruction: serializer.fromJson<String?>(json['qrisInstruction']),
      debitEnabled: serializer.fromJson<bool>(json['debitEnabled']),
      debitProvider: serializer.fromJson<String?>(json['debitProvider']),
      debitMerchantId: serializer.fromJson<String?>(json['debitMerchantId']),
      debitInstruction: serializer.fromJson<String?>(json['debitInstruction']),
      transferEnabled: serializer.fromJson<bool>(json['transferEnabled']),
      transferBankName: serializer.fromJson<String?>(json['transferBankName']),
      transferAccountNumber: serializer.fromJson<String?>(
        json['transferAccountNumber'],
      ),
      transferAccountName: serializer.fromJson<String?>(
        json['transferAccountName'],
      ),
      transferInstruction: serializer.fromJson<String?>(
        json['transferInstruction'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'qrisEnabled': serializer.toJson<bool>(qrisEnabled),
      'qrisProvider': serializer.toJson<String?>(qrisProvider),
      'qrisMerchantId': serializer.toJson<String?>(qrisMerchantId),
      'qrisImagePath': serializer.toJson<String?>(qrisImagePath),
      'qrisInstruction': serializer.toJson<String?>(qrisInstruction),
      'debitEnabled': serializer.toJson<bool>(debitEnabled),
      'debitProvider': serializer.toJson<String?>(debitProvider),
      'debitMerchantId': serializer.toJson<String?>(debitMerchantId),
      'debitInstruction': serializer.toJson<String?>(debitInstruction),
      'transferEnabled': serializer.toJson<bool>(transferEnabled),
      'transferBankName': serializer.toJson<String?>(transferBankName),
      'transferAccountNumber': serializer.toJson<String?>(
        transferAccountNumber,
      ),
      'transferAccountName': serializer.toJson<String?>(transferAccountName),
      'transferInstruction': serializer.toJson<String?>(transferInstruction),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  PaymentSetting copyWith({
    String? id,
    bool? qrisEnabled,
    Value<String?> qrisProvider = const Value.absent(),
    Value<String?> qrisMerchantId = const Value.absent(),
    Value<String?> qrisImagePath = const Value.absent(),
    Value<String?> qrisInstruction = const Value.absent(),
    bool? debitEnabled,
    Value<String?> debitProvider = const Value.absent(),
    Value<String?> debitMerchantId = const Value.absent(),
    Value<String?> debitInstruction = const Value.absent(),
    bool? transferEnabled,
    Value<String?> transferBankName = const Value.absent(),
    Value<String?> transferAccountNumber = const Value.absent(),
    Value<String?> transferAccountName = const Value.absent(),
    Value<String?> transferInstruction = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => PaymentSetting(
    id: id ?? this.id,
    qrisEnabled: qrisEnabled ?? this.qrisEnabled,
    qrisProvider: qrisProvider.present ? qrisProvider.value : this.qrisProvider,
    qrisMerchantId: qrisMerchantId.present
        ? qrisMerchantId.value
        : this.qrisMerchantId,
    qrisImagePath: qrisImagePath.present
        ? qrisImagePath.value
        : this.qrisImagePath,
    qrisInstruction: qrisInstruction.present
        ? qrisInstruction.value
        : this.qrisInstruction,
    debitEnabled: debitEnabled ?? this.debitEnabled,
    debitProvider: debitProvider.present
        ? debitProvider.value
        : this.debitProvider,
    debitMerchantId: debitMerchantId.present
        ? debitMerchantId.value
        : this.debitMerchantId,
    debitInstruction: debitInstruction.present
        ? debitInstruction.value
        : this.debitInstruction,
    transferEnabled: transferEnabled ?? this.transferEnabled,
    transferBankName: transferBankName.present
        ? transferBankName.value
        : this.transferBankName,
    transferAccountNumber: transferAccountNumber.present
        ? transferAccountNumber.value
        : this.transferAccountNumber,
    transferAccountName: transferAccountName.present
        ? transferAccountName.value
        : this.transferAccountName,
    transferInstruction: transferInstruction.present
        ? transferInstruction.value
        : this.transferInstruction,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  PaymentSetting copyWithCompanion(PaymentSettingsCompanion data) {
    return PaymentSetting(
      id: data.id.present ? data.id.value : this.id,
      qrisEnabled: data.qrisEnabled.present
          ? data.qrisEnabled.value
          : this.qrisEnabled,
      qrisProvider: data.qrisProvider.present
          ? data.qrisProvider.value
          : this.qrisProvider,
      qrisMerchantId: data.qrisMerchantId.present
          ? data.qrisMerchantId.value
          : this.qrisMerchantId,
      qrisImagePath: data.qrisImagePath.present
          ? data.qrisImagePath.value
          : this.qrisImagePath,
      qrisInstruction: data.qrisInstruction.present
          ? data.qrisInstruction.value
          : this.qrisInstruction,
      debitEnabled: data.debitEnabled.present
          ? data.debitEnabled.value
          : this.debitEnabled,
      debitProvider: data.debitProvider.present
          ? data.debitProvider.value
          : this.debitProvider,
      debitMerchantId: data.debitMerchantId.present
          ? data.debitMerchantId.value
          : this.debitMerchantId,
      debitInstruction: data.debitInstruction.present
          ? data.debitInstruction.value
          : this.debitInstruction,
      transferEnabled: data.transferEnabled.present
          ? data.transferEnabled.value
          : this.transferEnabled,
      transferBankName: data.transferBankName.present
          ? data.transferBankName.value
          : this.transferBankName,
      transferAccountNumber: data.transferAccountNumber.present
          ? data.transferAccountNumber.value
          : this.transferAccountNumber,
      transferAccountName: data.transferAccountName.present
          ? data.transferAccountName.value
          : this.transferAccountName,
      transferInstruction: data.transferInstruction.present
          ? data.transferInstruction.value
          : this.transferInstruction,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentSetting(')
          ..write('id: $id, ')
          ..write('qrisEnabled: $qrisEnabled, ')
          ..write('qrisProvider: $qrisProvider, ')
          ..write('qrisMerchantId: $qrisMerchantId, ')
          ..write('qrisImagePath: $qrisImagePath, ')
          ..write('qrisInstruction: $qrisInstruction, ')
          ..write('debitEnabled: $debitEnabled, ')
          ..write('debitProvider: $debitProvider, ')
          ..write('debitMerchantId: $debitMerchantId, ')
          ..write('debitInstruction: $debitInstruction, ')
          ..write('transferEnabled: $transferEnabled, ')
          ..write('transferBankName: $transferBankName, ')
          ..write('transferAccountNumber: $transferAccountNumber, ')
          ..write('transferAccountName: $transferAccountName, ')
          ..write('transferInstruction: $transferInstruction, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    qrisEnabled,
    qrisProvider,
    qrisMerchantId,
    qrisImagePath,
    qrisInstruction,
    debitEnabled,
    debitProvider,
    debitMerchantId,
    debitInstruction,
    transferEnabled,
    transferBankName,
    transferAccountNumber,
    transferAccountName,
    transferInstruction,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentSetting &&
          other.id == this.id &&
          other.qrisEnabled == this.qrisEnabled &&
          other.qrisProvider == this.qrisProvider &&
          other.qrisMerchantId == this.qrisMerchantId &&
          other.qrisImagePath == this.qrisImagePath &&
          other.qrisInstruction == this.qrisInstruction &&
          other.debitEnabled == this.debitEnabled &&
          other.debitProvider == this.debitProvider &&
          other.debitMerchantId == this.debitMerchantId &&
          other.debitInstruction == this.debitInstruction &&
          other.transferEnabled == this.transferEnabled &&
          other.transferBankName == this.transferBankName &&
          other.transferAccountNumber == this.transferAccountNumber &&
          other.transferAccountName == this.transferAccountName &&
          other.transferInstruction == this.transferInstruction &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PaymentSettingsCompanion extends UpdateCompanion<PaymentSetting> {
  final Value<String> id;
  final Value<bool> qrisEnabled;
  final Value<String?> qrisProvider;
  final Value<String?> qrisMerchantId;
  final Value<String?> qrisImagePath;
  final Value<String?> qrisInstruction;
  final Value<bool> debitEnabled;
  final Value<String?> debitProvider;
  final Value<String?> debitMerchantId;
  final Value<String?> debitInstruction;
  final Value<bool> transferEnabled;
  final Value<String?> transferBankName;
  final Value<String?> transferAccountNumber;
  final Value<String?> transferAccountName;
  final Value<String?> transferInstruction;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const PaymentSettingsCompanion({
    this.id = const Value.absent(),
    this.qrisEnabled = const Value.absent(),
    this.qrisProvider = const Value.absent(),
    this.qrisMerchantId = const Value.absent(),
    this.qrisImagePath = const Value.absent(),
    this.qrisInstruction = const Value.absent(),
    this.debitEnabled = const Value.absent(),
    this.debitProvider = const Value.absent(),
    this.debitMerchantId = const Value.absent(),
    this.debitInstruction = const Value.absent(),
    this.transferEnabled = const Value.absent(),
    this.transferBankName = const Value.absent(),
    this.transferAccountNumber = const Value.absent(),
    this.transferAccountName = const Value.absent(),
    this.transferInstruction = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentSettingsCompanion.insert({
    required String id,
    this.qrisEnabled = const Value.absent(),
    this.qrisProvider = const Value.absent(),
    this.qrisMerchantId = const Value.absent(),
    this.qrisImagePath = const Value.absent(),
    this.qrisInstruction = const Value.absent(),
    this.debitEnabled = const Value.absent(),
    this.debitProvider = const Value.absent(),
    this.debitMerchantId = const Value.absent(),
    this.debitInstruction = const Value.absent(),
    this.transferEnabled = const Value.absent(),
    this.transferBankName = const Value.absent(),
    this.transferAccountNumber = const Value.absent(),
    this.transferAccountName = const Value.absent(),
    this.transferInstruction = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<PaymentSetting> custom({
    Expression<String>? id,
    Expression<bool>? qrisEnabled,
    Expression<String>? qrisProvider,
    Expression<String>? qrisMerchantId,
    Expression<String>? qrisImagePath,
    Expression<String>? qrisInstruction,
    Expression<bool>? debitEnabled,
    Expression<String>? debitProvider,
    Expression<String>? debitMerchantId,
    Expression<String>? debitInstruction,
    Expression<bool>? transferEnabled,
    Expression<String>? transferBankName,
    Expression<String>? transferAccountNumber,
    Expression<String>? transferAccountName,
    Expression<String>? transferInstruction,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (qrisEnabled != null) 'qris_enabled': qrisEnabled,
      if (qrisProvider != null) 'qris_provider': qrisProvider,
      if (qrisMerchantId != null) 'qris_merchant_id': qrisMerchantId,
      if (qrisImagePath != null) 'qris_image_path': qrisImagePath,
      if (qrisInstruction != null) 'qris_instruction': qrisInstruction,
      if (debitEnabled != null) 'debit_enabled': debitEnabled,
      if (debitProvider != null) 'debit_provider': debitProvider,
      if (debitMerchantId != null) 'debit_merchant_id': debitMerchantId,
      if (debitInstruction != null) 'debit_instruction': debitInstruction,
      if (transferEnabled != null) 'transfer_enabled': transferEnabled,
      if (transferBankName != null) 'transfer_bank_name': transferBankName,
      if (transferAccountNumber != null)
        'transfer_account_number': transferAccountNumber,
      if (transferAccountName != null)
        'transfer_account_name': transferAccountName,
      if (transferInstruction != null)
        'transfer_instruction': transferInstruction,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentSettingsCompanion copyWith({
    Value<String>? id,
    Value<bool>? qrisEnabled,
    Value<String?>? qrisProvider,
    Value<String?>? qrisMerchantId,
    Value<String?>? qrisImagePath,
    Value<String?>? qrisInstruction,
    Value<bool>? debitEnabled,
    Value<String?>? debitProvider,
    Value<String?>? debitMerchantId,
    Value<String?>? debitInstruction,
    Value<bool>? transferEnabled,
    Value<String?>? transferBankName,
    Value<String?>? transferAccountNumber,
    Value<String?>? transferAccountName,
    Value<String?>? transferInstruction,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return PaymentSettingsCompanion(
      id: id ?? this.id,
      qrisEnabled: qrisEnabled ?? this.qrisEnabled,
      qrisProvider: qrisProvider ?? this.qrisProvider,
      qrisMerchantId: qrisMerchantId ?? this.qrisMerchantId,
      qrisImagePath: qrisImagePath ?? this.qrisImagePath,
      qrisInstruction: qrisInstruction ?? this.qrisInstruction,
      debitEnabled: debitEnabled ?? this.debitEnabled,
      debitProvider: debitProvider ?? this.debitProvider,
      debitMerchantId: debitMerchantId ?? this.debitMerchantId,
      debitInstruction: debitInstruction ?? this.debitInstruction,
      transferEnabled: transferEnabled ?? this.transferEnabled,
      transferBankName: transferBankName ?? this.transferBankName,
      transferAccountNumber:
          transferAccountNumber ?? this.transferAccountNumber,
      transferAccountName: transferAccountName ?? this.transferAccountName,
      transferInstruction: transferInstruction ?? this.transferInstruction,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (qrisEnabled.present) {
      map['qris_enabled'] = Variable<bool>(qrisEnabled.value);
    }
    if (qrisProvider.present) {
      map['qris_provider'] = Variable<String>(qrisProvider.value);
    }
    if (qrisMerchantId.present) {
      map['qris_merchant_id'] = Variable<String>(qrisMerchantId.value);
    }
    if (qrisImagePath.present) {
      map['qris_image_path'] = Variable<String>(qrisImagePath.value);
    }
    if (qrisInstruction.present) {
      map['qris_instruction'] = Variable<String>(qrisInstruction.value);
    }
    if (debitEnabled.present) {
      map['debit_enabled'] = Variable<bool>(debitEnabled.value);
    }
    if (debitProvider.present) {
      map['debit_provider'] = Variable<String>(debitProvider.value);
    }
    if (debitMerchantId.present) {
      map['debit_merchant_id'] = Variable<String>(debitMerchantId.value);
    }
    if (debitInstruction.present) {
      map['debit_instruction'] = Variable<String>(debitInstruction.value);
    }
    if (transferEnabled.present) {
      map['transfer_enabled'] = Variable<bool>(transferEnabled.value);
    }
    if (transferBankName.present) {
      map['transfer_bank_name'] = Variable<String>(transferBankName.value);
    }
    if (transferAccountNumber.present) {
      map['transfer_account_number'] = Variable<String>(
        transferAccountNumber.value,
      );
    }
    if (transferAccountName.present) {
      map['transfer_account_name'] = Variable<String>(
        transferAccountName.value,
      );
    }
    if (transferInstruction.present) {
      map['transfer_instruction'] = Variable<String>(transferInstruction.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentSettingsCompanion(')
          ..write('id: $id, ')
          ..write('qrisEnabled: $qrisEnabled, ')
          ..write('qrisProvider: $qrisProvider, ')
          ..write('qrisMerchantId: $qrisMerchantId, ')
          ..write('qrisImagePath: $qrisImagePath, ')
          ..write('qrisInstruction: $qrisInstruction, ')
          ..write('debitEnabled: $debitEnabled, ')
          ..write('debitProvider: $debitProvider, ')
          ..write('debitMerchantId: $debitMerchantId, ')
          ..write('debitInstruction: $debitInstruction, ')
          ..write('transferEnabled: $transferEnabled, ')
          ..write('transferBankName: $transferBankName, ')
          ..write('transferAccountNumber: $transferAccountNumber, ')
          ..write('transferAccountName: $transferAccountName, ')
          ..write('transferInstruction: $transferInstruction, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PromosTable extends Promos with TableInfo<$PromosTable, Promo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PromosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<int> value = GeneratedColumn<int>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('transaction'),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    value,
    scope,
    isActive,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'promos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Promo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Promo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Promo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}value'],
      )!,
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $PromosTable createAlias(String alias) {
    return $PromosTable(attachedDatabase, alias);
  }
}

class Promo extends DataClass implements Insertable<Promo> {
  final String id;
  final String name;
  final String type;
  final int value;
  final String scope;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  const Promo({
    required this.id,
    required this.name,
    required this.type,
    required this.value,
    required this.scope,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['value'] = Variable<int>(value);
    map['scope'] = Variable<String>(scope);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  PromosCompanion toCompanion(bool nullToAbsent) {
    return PromosCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      value: Value(value),
      scope: Value(scope),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Promo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Promo(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      value: serializer.fromJson<int>(json['value']),
      scope: serializer.fromJson<String>(json['scope']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'value': serializer.toJson<int>(value),
      'scope': serializer.toJson<String>(scope),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Promo copyWith({
    String? id,
    String? name,
    String? type,
    int? value,
    String? scope,
    bool? isActive,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Promo(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    value: value ?? this.value,
    scope: scope ?? this.scope,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Promo copyWithCompanion(PromosCompanion data) {
    return Promo(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      value: data.value.present ? data.value.value : this.value,
      scope: data.scope.present ? data.scope.value : this.scope,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Promo(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('scope: $scope, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    type,
    value,
    scope,
    isActive,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Promo &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.value == this.value &&
          other.scope == this.scope &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class PromosCompanion extends UpdateCompanion<Promo> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<int> value;
  final Value<String> scope;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const PromosCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.value = const Value.absent(),
    this.scope = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PromosCompanion.insert({
    required String id,
    required String name,
    required String type,
    required int value,
    this.scope = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type),
       value = Value(value);
  static Insertable<Promo> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? value,
    Expression<String>? scope,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (value != null) 'value': value,
      if (scope != null) 'scope': scope,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PromosCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? type,
    Value<int>? value,
    Value<String>? scope,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return PromosCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      value: value ?? this.value,
      scope: scope ?? this.scope,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PromosCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('scope: $scope, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $StockMovementsTable stockMovements = $StockMovementsTable(this);
  late final $RolesTable roles = $RolesTable(this);
  late final $PermissionsTable permissions = $PermissionsTable(this);
  late final $RolePermissionsTable rolePermissions = $RolePermissionsTable(
    this,
  );
  late final $UsersTable users = $UsersTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $CashSessionsTable cashSessions = $CashSessionsTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $OrderItemsTable orderItems = $OrderItemsTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $DeviceSettingsTable deviceSettings = $DeviceSettingsTable(this);
  late final $CashierSettingsTable cashierSettings = $CashierSettingsTable(
    this,
  );
  late final $PaymentSettingsTable paymentSettings = $PaymentSettingsTable(
    this,
  );
  late final $PromosTable promos = $PromosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categories,
    products,
    stockMovements,
    roles,
    permissions,
    rolePermissions,
    users,
    customers,
    cashSessions,
    orders,
    orderItems,
    payments,
    syncQueue,
    appSettings,
    deviceSettings,
    cashierSettings,
    paymentSettings,
    promos,
  ];
}

typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      required String id,
      required String name,
      Value<int> sortOrder,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> sortOrder,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductsTable, List<Product>> _productsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.products,
    aliasName: 'categories__id__products__category_id',
  );

  $$ProductsTableProcessedTableManager get productsRefs {
    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_productsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productsRefs(
    Expression<bool> Function($$ProductsTableFilterComposer f) f,
  ) {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> productsRefs<T extends Object>(
    Expression<T> Function($$ProductsTableAnnotationComposer a) f,
  ) {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({bool productsRefs})
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                sortOrder: sortOrder,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                sortOrder: sortOrder,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (productsRefs) db.products],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productsRefs)
                    await $_getPrefetchedData<
                      Category,
                      $CategoriesTable,
                      Product
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableReferences
                          ._productsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).productsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({bool productsRefs})
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      required String id,
      Value<String?> categoryId,
      Value<String?> sku,
      Value<String?> barcode,
      required String name,
      Value<String?> description,
      Value<String?> imagePath,
      required int price,
      Value<int?> cost,
      Value<bool> trackStock,
      Value<int> stockQty,
      Value<int> minStock,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<String> id,
      Value<String?> categoryId,
      Value<String?> sku,
      Value<String?> barcode,
      Value<String> name,
      Value<String?> description,
      Value<String?> imagePath,
      Value<int> price,
      Value<int?> cost,
      Value<bool> trackStock,
      Value<int> stockQty,
      Value<int> minStock,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('products__category_id__categories__id');

  $$CategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$StockMovementsTable, List<StockMovement>>
  _stockMovementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.stockMovements,
    aliasName: 'products__id__stock_movements__product_id',
  );

  $$StockMovementsTableProcessedTableManager get stockMovementsRefs {
    final manager = $$StockMovementsTableTableManager(
      $_db,
      $_db.stockMovements,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockMovementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$OrderItemsTable, List<OrderItem>>
  _orderItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.orderItems,
    aliasName: 'products__id__order_items__product_id',
  );

  $$OrderItemsTableProcessedTableManager get orderItemsRefs {
    final manager = $$OrderItemsTableTableManager(
      $_db,
      $_db.orderItems,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_orderItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get trackStock => $composableBuilder(
    column: $table.trackStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stockQty => $composableBuilder(
    column: $table.stockQty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minStock => $composableBuilder(
    column: $table.minStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> stockMovementsRefs(
    Expression<bool> Function($$StockMovementsTableFilterComposer f) f,
  ) {
    final $$StockMovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockMovements,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockMovementsTableFilterComposer(
            $db: $db,
            $table: $db.stockMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> orderItemsRefs(
    Expression<bool> Function($$OrderItemsTableFilterComposer f) f,
  ) {
    final $$OrderItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderItemsTableFilterComposer(
            $db: $db,
            $table: $db.orderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get trackStock => $composableBuilder(
    column: $table.trackStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stockQty => $composableBuilder(
    column: $table.stockQty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minStock => $composableBuilder(
    column: $table.minStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<int> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<int> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<bool> get trackStock => $composableBuilder(
    column: $table.trackStock,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stockQty =>
      $composableBuilder(column: $table.stockQty, builder: (column) => column);

  GeneratedColumn<int> get minStock =>
      $composableBuilder(column: $table.minStock, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> stockMovementsRefs<T extends Object>(
    Expression<T> Function($$StockMovementsTableAnnotationComposer a) f,
  ) {
    final $$StockMovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockMovements,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockMovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.stockMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> orderItemsRefs<T extends Object>(
    Expression<T> Function($$OrderItemsTableAnnotationComposer a) f,
  ) {
    final $$OrderItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.orderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, $$ProductsTableReferences),
          Product,
          PrefetchHooks Function({
            bool categoryId,
            bool stockMovementsRefs,
            bool orderItemsRefs,
          })
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> sku = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<int> price = const Value.absent(),
                Value<int?> cost = const Value.absent(),
                Value<bool> trackStock = const Value.absent(),
                Value<int> stockQty = const Value.absent(),
                Value<int> minStock = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                categoryId: categoryId,
                sku: sku,
                barcode: barcode,
                name: name,
                description: description,
                imagePath: imagePath,
                price: price,
                cost: cost,
                trackStock: trackStock,
                stockQty: stockQty,
                minStock: minStock,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> categoryId = const Value.absent(),
                Value<String?> sku = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                required int price,
                Value<int?> cost = const Value.absent(),
                Value<bool> trackStock = const Value.absent(),
                Value<int> stockQty = const Value.absent(),
                Value<int> minStock = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                categoryId: categoryId,
                sku: sku,
                barcode: barcode,
                name: name,
                description: description,
                imagePath: imagePath,
                price: price,
                cost: cost,
                trackStock: trackStock,
                stockQty: stockQty,
                minStock: minStock,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoryId = false,
                stockMovementsRefs = false,
                orderItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (stockMovementsRefs) db.stockMovements,
                    if (orderItemsRefs) db.orderItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable: $$ProductsTableReferences
                                        ._categoryIdTable(db),
                                    referencedColumn: $$ProductsTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (stockMovementsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          StockMovement
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._stockMovementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).stockMovementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (orderItemsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          OrderItem
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._orderItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).orderItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, $$ProductsTableReferences),
      Product,
      PrefetchHooks Function({
        bool categoryId,
        bool stockMovementsRefs,
        bool orderItemsRefs,
      })
    >;
typedef $$StockMovementsTableCreateCompanionBuilder =
    StockMovementsCompanion Function({
      required String id,
      required String productId,
      required String productName,
      required String type,
      required int qtyChange,
      required int stockAfter,
      Value<String?> source,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });
typedef $$StockMovementsTableUpdateCompanionBuilder =
    StockMovementsCompanion Function({
      Value<String> id,
      Value<String> productId,
      Value<String> productName,
      Value<String> type,
      Value<int> qtyChange,
      Value<int> stockAfter,
      Value<String?> source,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });

final class $$StockMovementsTableReferences
    extends BaseReferences<_$AppDatabase, $StockMovementsTable, StockMovement> {
  $$StockMovementsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('stock_movements__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StockMovementsTableFilterComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get qtyChange => $composableBuilder(
    column: $table.qtyChange,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stockAfter => $composableBuilder(
    column: $table.stockAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockMovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get qtyChange => $composableBuilder(
    column: $table.qtyChange,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stockAfter => $composableBuilder(
    column: $table.stockAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockMovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get qtyChange =>
      $composableBuilder(column: $table.qtyChange, builder: (column) => column);

  GeneratedColumn<int> get stockAfter => $composableBuilder(
    column: $table.stockAfter,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockMovementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockMovementsTable,
          StockMovement,
          $$StockMovementsTableFilterComposer,
          $$StockMovementsTableOrderingComposer,
          $$StockMovementsTableAnnotationComposer,
          $$StockMovementsTableCreateCompanionBuilder,
          $$StockMovementsTableUpdateCompanionBuilder,
          (StockMovement, $$StockMovementsTableReferences),
          StockMovement,
          PrefetchHooks Function({bool productId})
        > {
  $$StockMovementsTableTableManager(
    _$AppDatabase db,
    $StockMovementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockMovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockMovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockMovementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> qtyChange = const Value.absent(),
                Value<int> stockAfter = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockMovementsCompanion(
                id: id,
                productId: productId,
                productName: productName,
                type: type,
                qtyChange: qtyChange,
                stockAfter: stockAfter,
                source: source,
                note: note,
                createdAt: createdAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String productId,
                required String productName,
                required String type,
                required int qtyChange,
                required int stockAfter,
                Value<String?> source = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockMovementsCompanion.insert(
                id: id,
                productId: productId,
                productName: productName,
                type: type,
                qtyChange: qtyChange,
                stockAfter: stockAfter,
                source: source,
                note: note,
                createdAt: createdAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StockMovementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$StockMovementsTableReferences
                                    ._productIdTable(db),
                                referencedColumn:
                                    $$StockMovementsTableReferences
                                        ._productIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StockMovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockMovementsTable,
      StockMovement,
      $$StockMovementsTableFilterComposer,
      $$StockMovementsTableOrderingComposer,
      $$StockMovementsTableAnnotationComposer,
      $$StockMovementsTableCreateCompanionBuilder,
      $$StockMovementsTableUpdateCompanionBuilder,
      (StockMovement, $$StockMovementsTableReferences),
      StockMovement,
      PrefetchHooks Function({bool productId})
    >;
typedef $$RolesTableCreateCompanionBuilder =
    RolesCompanion Function({
      required String id,
      required String name,
      required String code,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$RolesTableUpdateCompanionBuilder =
    RolesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> code,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

final class $$RolesTableReferences
    extends BaseReferences<_$AppDatabase, $RolesTable, Role> {
  $$RolesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RolePermissionsTable, List<RolePermission>>
  _rolePermissionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.rolePermissions,
    aliasName: 'roles__id__role_permissions__role_id',
  );

  $$RolePermissionsTableProcessedTableManager get rolePermissionsRefs {
    final manager = $$RolePermissionsTableTableManager(
      $_db,
      $_db.rolePermissions,
    ).filter((f) => f.roleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _rolePermissionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UsersTable, List<User>> _usersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.users,
    aliasName: 'roles__id__users__role_id',
  );

  $$UsersTableProcessedTableManager get usersRefs {
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.roleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_usersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RolesTableFilterComposer extends Composer<_$AppDatabase, $RolesTable> {
  $$RolesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> rolePermissionsRefs(
    Expression<bool> Function($$RolePermissionsTableFilterComposer f) f,
  ) {
    final $$RolePermissionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rolePermissions,
      getReferencedColumn: (t) => t.roleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolePermissionsTableFilterComposer(
            $db: $db,
            $table: $db.rolePermissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> usersRefs(
    Expression<bool> Function($$UsersTableFilterComposer f) f,
  ) {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.roleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RolesTableOrderingComposer
    extends Composer<_$AppDatabase, $RolesTable> {
  $$RolesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RolesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RolesTable> {
  $$RolesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> rolePermissionsRefs<T extends Object>(
    Expression<T> Function($$RolePermissionsTableAnnotationComposer a) f,
  ) {
    final $$RolePermissionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rolePermissions,
      getReferencedColumn: (t) => t.roleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolePermissionsTableAnnotationComposer(
            $db: $db,
            $table: $db.rolePermissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> usersRefs<T extends Object>(
    Expression<T> Function($$UsersTableAnnotationComposer a) f,
  ) {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.roleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RolesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RolesTable,
          Role,
          $$RolesTableFilterComposer,
          $$RolesTableOrderingComposer,
          $$RolesTableAnnotationComposer,
          $$RolesTableCreateCompanionBuilder,
          $$RolesTableUpdateCompanionBuilder,
          (Role, $$RolesTableReferences),
          Role,
          PrefetchHooks Function({bool rolePermissionsRefs, bool usersRefs})
        > {
  $$RolesTableTableManager(_$AppDatabase db, $RolesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RolesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RolesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RolesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RolesCompanion(
                id: id,
                name: name,
                code: code,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String code,
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RolesCompanion.insert(
                id: id,
                name: name,
                code: code,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$RolesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({rolePermissionsRefs = false, usersRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (rolePermissionsRefs) db.rolePermissions,
                    if (usersRefs) db.users,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (rolePermissionsRefs)
                        await $_getPrefetchedData<
                          Role,
                          $RolesTable,
                          RolePermission
                        >(
                          currentTable: table,
                          referencedTable: $$RolesTableReferences
                              ._rolePermissionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RolesTableReferences(
                                db,
                                table,
                                p0,
                              ).rolePermissionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.roleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (usersRefs)
                        await $_getPrefetchedData<Role, $RolesTable, User>(
                          currentTable: table,
                          referencedTable: $$RolesTableReferences
                              ._usersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RolesTableReferences(db, table, p0).usersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.roleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RolesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RolesTable,
      Role,
      $$RolesTableFilterComposer,
      $$RolesTableOrderingComposer,
      $$RolesTableAnnotationComposer,
      $$RolesTableCreateCompanionBuilder,
      $$RolesTableUpdateCompanionBuilder,
      (Role, $$RolesTableReferences),
      Role,
      PrefetchHooks Function({bool rolePermissionsRefs, bool usersRefs})
    >;
typedef $$PermissionsTableCreateCompanionBuilder =
    PermissionsCompanion Function({
      required String id,
      required String name,
      required String code,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$PermissionsTableUpdateCompanionBuilder =
    PermissionsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> code,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

final class $$PermissionsTableReferences
    extends BaseReferences<_$AppDatabase, $PermissionsTable, Permission> {
  $$PermissionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RolePermissionsTable, List<RolePermission>>
  _rolePermissionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.rolePermissions,
    aliasName: 'permissions__id__role_permissions__permission_id',
  );

  $$RolePermissionsTableProcessedTableManager get rolePermissionsRefs {
    final manager = $$RolePermissionsTableTableManager(
      $_db,
      $_db.rolePermissions,
    ).filter((f) => f.permissionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _rolePermissionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PermissionsTableFilterComposer
    extends Composer<_$AppDatabase, $PermissionsTable> {
  $$PermissionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> rolePermissionsRefs(
    Expression<bool> Function($$RolePermissionsTableFilterComposer f) f,
  ) {
    final $$RolePermissionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rolePermissions,
      getReferencedColumn: (t) => t.permissionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolePermissionsTableFilterComposer(
            $db: $db,
            $table: $db.rolePermissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PermissionsTableOrderingComposer
    extends Composer<_$AppDatabase, $PermissionsTable> {
  $$PermissionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PermissionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PermissionsTable> {
  $$PermissionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> rolePermissionsRefs<T extends Object>(
    Expression<T> Function($$RolePermissionsTableAnnotationComposer a) f,
  ) {
    final $$RolePermissionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rolePermissions,
      getReferencedColumn: (t) => t.permissionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolePermissionsTableAnnotationComposer(
            $db: $db,
            $table: $db.rolePermissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PermissionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PermissionsTable,
          Permission,
          $$PermissionsTableFilterComposer,
          $$PermissionsTableOrderingComposer,
          $$PermissionsTableAnnotationComposer,
          $$PermissionsTableCreateCompanionBuilder,
          $$PermissionsTableUpdateCompanionBuilder,
          (Permission, $$PermissionsTableReferences),
          Permission,
          PrefetchHooks Function({bool rolePermissionsRefs})
        > {
  $$PermissionsTableTableManager(_$AppDatabase db, $PermissionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PermissionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PermissionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PermissionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PermissionsCompanion(
                id: id,
                name: name,
                code: code,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String code,
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PermissionsCompanion.insert(
                id: id,
                name: name,
                code: code,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PermissionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({rolePermissionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (rolePermissionsRefs) db.rolePermissions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (rolePermissionsRefs)
                    await $_getPrefetchedData<
                      Permission,
                      $PermissionsTable,
                      RolePermission
                    >(
                      currentTable: table,
                      referencedTable: $$PermissionsTableReferences
                          ._rolePermissionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PermissionsTableReferences(
                            db,
                            table,
                            p0,
                          ).rolePermissionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.permissionId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PermissionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PermissionsTable,
      Permission,
      $$PermissionsTableFilterComposer,
      $$PermissionsTableOrderingComposer,
      $$PermissionsTableAnnotationComposer,
      $$PermissionsTableCreateCompanionBuilder,
      $$PermissionsTableUpdateCompanionBuilder,
      (Permission, $$PermissionsTableReferences),
      Permission,
      PrefetchHooks Function({bool rolePermissionsRefs})
    >;
typedef $$RolePermissionsTableCreateCompanionBuilder =
    RolePermissionsCompanion Function({
      required String roleId,
      required String permissionId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$RolePermissionsTableUpdateCompanionBuilder =
    RolePermissionsCompanion Function({
      Value<String> roleId,
      Value<String> permissionId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$RolePermissionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $RolePermissionsTable, RolePermission> {
  $$RolePermissionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RolesTable _roleIdTable(_$AppDatabase db) =>
      db.roles.createAlias('role_permissions__role_id__roles__id');

  $$RolesTableProcessedTableManager get roleId {
    final $_column = $_itemColumn<String>('role_id')!;

    final manager = $$RolesTableTableManager(
      $_db,
      $_db.roles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PermissionsTable _permissionIdTable(_$AppDatabase db) => db
      .permissions
      .createAlias('role_permissions__permission_id__permissions__id');

  $$PermissionsTableProcessedTableManager get permissionId {
    final $_column = $_itemColumn<String>('permission_id')!;

    final manager = $$PermissionsTableTableManager(
      $_db,
      $_db.permissions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_permissionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RolePermissionsTableFilterComposer
    extends Composer<_$AppDatabase, $RolePermissionsTable> {
  $$RolePermissionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$RolesTableFilterComposer get roleId {
    final $$RolesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roleId,
      referencedTable: $db.roles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolesTableFilterComposer(
            $db: $db,
            $table: $db.roles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PermissionsTableFilterComposer get permissionId {
    final $$PermissionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.permissionId,
      referencedTable: $db.permissions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PermissionsTableFilterComposer(
            $db: $db,
            $table: $db.permissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RolePermissionsTableOrderingComposer
    extends Composer<_$AppDatabase, $RolePermissionsTable> {
  $$RolePermissionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$RolesTableOrderingComposer get roleId {
    final $$RolesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roleId,
      referencedTable: $db.roles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolesTableOrderingComposer(
            $db: $db,
            $table: $db.roles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PermissionsTableOrderingComposer get permissionId {
    final $$PermissionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.permissionId,
      referencedTable: $db.permissions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PermissionsTableOrderingComposer(
            $db: $db,
            $table: $db.permissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RolePermissionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RolePermissionsTable> {
  $$RolePermissionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$RolesTableAnnotationComposer get roleId {
    final $$RolesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roleId,
      referencedTable: $db.roles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolesTableAnnotationComposer(
            $db: $db,
            $table: $db.roles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PermissionsTableAnnotationComposer get permissionId {
    final $$PermissionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.permissionId,
      referencedTable: $db.permissions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PermissionsTableAnnotationComposer(
            $db: $db,
            $table: $db.permissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RolePermissionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RolePermissionsTable,
          RolePermission,
          $$RolePermissionsTableFilterComposer,
          $$RolePermissionsTableOrderingComposer,
          $$RolePermissionsTableAnnotationComposer,
          $$RolePermissionsTableCreateCompanionBuilder,
          $$RolePermissionsTableUpdateCompanionBuilder,
          (RolePermission, $$RolePermissionsTableReferences),
          RolePermission,
          PrefetchHooks Function({bool roleId, bool permissionId})
        > {
  $$RolePermissionsTableTableManager(
    _$AppDatabase db,
    $RolePermissionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RolePermissionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RolePermissionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RolePermissionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> roleId = const Value.absent(),
                Value<String> permissionId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RolePermissionsCompanion(
                roleId: roleId,
                permissionId: permissionId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String roleId,
                required String permissionId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RolePermissionsCompanion.insert(
                roleId: roleId,
                permissionId: permissionId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RolePermissionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({roleId = false, permissionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (roleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.roleId,
                                referencedTable:
                                    $$RolePermissionsTableReferences
                                        ._roleIdTable(db),
                                referencedColumn:
                                    $$RolePermissionsTableReferences
                                        ._roleIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (permissionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.permissionId,
                                referencedTable:
                                    $$RolePermissionsTableReferences
                                        ._permissionIdTable(db),
                                referencedColumn:
                                    $$RolePermissionsTableReferences
                                        ._permissionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RolePermissionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RolePermissionsTable,
      RolePermission,
      $$RolePermissionsTableFilterComposer,
      $$RolePermissionsTableOrderingComposer,
      $$RolePermissionsTableAnnotationComposer,
      $$RolePermissionsTableCreateCompanionBuilder,
      $$RolePermissionsTableUpdateCompanionBuilder,
      (RolePermission, $$RolePermissionsTableReferences),
      RolePermission,
      PrefetchHooks Function({bool roleId, bool permissionId})
    >;
typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      required String id,
      Value<String?> roleId,
      required String name,
      Value<String?> email,
      Value<String?> pinHash,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<String> id,
      Value<String?> roleId,
      Value<String> name,
      Value<String?> email,
      Value<String?> pinHash,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RolesTable _roleIdTable(_$AppDatabase db) =>
      db.roles.createAlias('users__role_id__roles__id');

  $$RolesTableProcessedTableManager? get roleId {
    final $_column = $_itemColumn<String>('role_id');
    if ($_column == null) return null;
    final manager = $$RolesTableTableManager(
      $_db,
      $_db.roles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CashSessionsTable, List<CashSession>>
  _openedCashSessionsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cashSessions,
    aliasName: 'users__id__cash_sessions__opened_by_user_id',
  );

  $$CashSessionsTableProcessedTableManager get openedCashSessions {
    final manager = $$CashSessionsTableTableManager(
      $_db,
      $_db.cashSessions,
    ).filter((f) => f.openedByUserId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_openedCashSessionsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CashSessionsTable, List<CashSession>>
  _closedCashSessionsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cashSessions,
    aliasName: 'users__id__cash_sessions__closed_by_user_id',
  );

  $$CashSessionsTableProcessedTableManager get closedCashSessions {
    final manager = $$CashSessionsTableTableManager(
      $_db,
      $_db.cashSessions,
    ).filter((f) => f.closedByUserId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_closedCashSessionsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$OrdersTable, List<Order>> _ordersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.orders,
    aliasName: 'users__id__orders__cashier_user_id',
  );

  $$OrdersTableProcessedTableManager get ordersRefs {
    final manager = $$OrdersTableTableManager(
      $_db,
      $_db.orders,
    ).filter((f) => f.cashierUserId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$RolesTableFilterComposer get roleId {
    final $$RolesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roleId,
      referencedTable: $db.roles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolesTableFilterComposer(
            $db: $db,
            $table: $db.roles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> openedCashSessions(
    Expression<bool> Function($$CashSessionsTableFilterComposer f) f,
  ) {
    final $$CashSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cashSessions,
      getReferencedColumn: (t) => t.openedByUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashSessionsTableFilterComposer(
            $db: $db,
            $table: $db.cashSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> closedCashSessions(
    Expression<bool> Function($$CashSessionsTableFilterComposer f) f,
  ) {
    final $$CashSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cashSessions,
      getReferencedColumn: (t) => t.closedByUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashSessionsTableFilterComposer(
            $db: $db,
            $table: $db.cashSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ordersRefs(
    Expression<bool> Function($$OrdersTableFilterComposer f) f,
  ) {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.cashierUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableFilterComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$RolesTableOrderingComposer get roleId {
    final $$RolesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roleId,
      referencedTable: $db.roles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolesTableOrderingComposer(
            $db: $db,
            $table: $db.roles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get pinHash =>
      $composableBuilder(column: $table.pinHash, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$RolesTableAnnotationComposer get roleId {
    final $$RolesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roleId,
      referencedTable: $db.roles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolesTableAnnotationComposer(
            $db: $db,
            $table: $db.roles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> openedCashSessions<T extends Object>(
    Expression<T> Function($$CashSessionsTableAnnotationComposer a) f,
  ) {
    final $$CashSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cashSessions,
      getReferencedColumn: (t) => t.openedByUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.cashSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> closedCashSessions<T extends Object>(
    Expression<T> Function($$CashSessionsTableAnnotationComposer a) f,
  ) {
    final $$CashSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cashSessions,
      getReferencedColumn: (t) => t.closedByUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.cashSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> ordersRefs<T extends Object>(
    Expression<T> Function($$OrdersTableAnnotationComposer a) f,
  ) {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.cashierUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({
            bool roleId,
            bool openedCashSessions,
            bool closedCashSessions,
            bool ordersRefs,
          })
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> roleId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> pinHash = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                roleId: roleId,
                name: name,
                email: email,
                pinHash: pinHash,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> roleId = const Value.absent(),
                required String name,
                Value<String?> email = const Value.absent(),
                Value<String?> pinHash = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                roleId: roleId,
                name: name,
                email: email,
                pinHash: pinHash,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                roleId = false,
                openedCashSessions = false,
                closedCashSessions = false,
                ordersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (openedCashSessions) db.cashSessions,
                    if (closedCashSessions) db.cashSessions,
                    if (ordersRefs) db.orders,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (roleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.roleId,
                                    referencedTable: $$UsersTableReferences
                                        ._roleIdTable(db),
                                    referencedColumn: $$UsersTableReferences
                                        ._roleIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (openedCashSessions)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          CashSession
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._openedCashSessionsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).openedCashSessions,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.openedByUserId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (closedCashSessions)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          CashSession
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._closedCashSessionsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).closedCashSessions,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.closedByUserId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (ordersRefs)
                        await $_getPrefetchedData<User, $UsersTable, Order>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._ordersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(db, table, p0).ordersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cashierUserId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({
        bool roleId,
        bool openedCashSessions,
        bool closedCashSessions,
        bool ordersRefs,
      })
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      required String id,
      required String name,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> address,
      Value<String?> note,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> phone,
      Value<String?> email,
      Value<String?> address,
      Value<String?> note,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, Customer> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$OrdersTable, List<Order>> _ordersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.orders,
    aliasName: 'customers__id__orders__customer_id',
  );

  $$OrdersTableProcessedTableManager get ordersRefs {
    final manager = $$OrdersTableTableManager(
      $_db,
      $_db.orders,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ordersRefs(
    Expression<bool> Function($$OrdersTableFilterComposer f) f,
  ) {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableFilterComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> ordersRefs<T extends Object>(
    Expression<T> Function($$OrdersTableAnnotationComposer a) f,
  ) {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, $$CustomersTableReferences),
          Customer,
          PrefetchHooks Function({bool ordersRefs})
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                name: name,
                phone: phone,
                email: email,
                address: address,
                note: note,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                email: email,
                address: address,
                note: note,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CustomersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ordersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ordersRefs) db.orders],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ordersRefs)
                    await $_getPrefetchedData<Customer, $CustomersTable, Order>(
                      currentTable: table,
                      referencedTable: $$CustomersTableReferences
                          ._ordersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CustomersTableReferences(db, table, p0).ordersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.customerId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, $$CustomersTableReferences),
      Customer,
      PrefetchHooks Function({bool ordersRefs})
    >;
typedef $$CashSessionsTableCreateCompanionBuilder =
    CashSessionsCompanion Function({
      required String id,
      required String openedByUserId,
      Value<String?> closedByUserId,
      required DateTime openedAt,
      Value<DateTime?> closedAt,
      Value<int> openingCash,
      Value<int?> closingCash,
      Value<int?> expectedCash,
      Value<String?> note,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$CashSessionsTableUpdateCompanionBuilder =
    CashSessionsCompanion Function({
      Value<String> id,
      Value<String> openedByUserId,
      Value<String?> closedByUserId,
      Value<DateTime> openedAt,
      Value<DateTime?> closedAt,
      Value<int> openingCash,
      Value<int?> closingCash,
      Value<int?> expectedCash,
      Value<String?> note,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

final class $$CashSessionsTableReferences
    extends BaseReferences<_$AppDatabase, $CashSessionsTable, CashSession> {
  $$CashSessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _openedByUserIdTable(_$AppDatabase db) =>
      db.users.createAlias('cash_sessions__opened_by_user_id__users__id');

  $$UsersTableProcessedTableManager get openedByUserId {
    final $_column = $_itemColumn<String>('opened_by_user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_openedByUserIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _closedByUserIdTable(_$AppDatabase db) =>
      db.users.createAlias('cash_sessions__closed_by_user_id__users__id');

  $$UsersTableProcessedTableManager? get closedByUserId {
    final $_column = $_itemColumn<String>('closed_by_user_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_closedByUserIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$OrdersTable, List<Order>> _ordersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.orders,
    aliasName: 'cash_sessions__id__orders__cash_session_id',
  );

  $$OrdersTableProcessedTableManager get ordersRefs {
    final manager = $$OrdersTableTableManager(
      $_db,
      $_db.orders,
    ).filter((f) => f.cashSessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CashSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $CashSessionsTable> {
  $$CashSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get closedAt => $composableBuilder(
    column: $table.closedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get openingCash => $composableBuilder(
    column: $table.openingCash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get closingCash => $composableBuilder(
    column: $table.closingCash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expectedCash => $composableBuilder(
    column: $table.expectedCash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get openedByUserId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.openedByUserId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get closedByUserId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.closedByUserId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> ordersRefs(
    Expression<bool> Function($$OrdersTableFilterComposer f) f,
  ) {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.cashSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableFilterComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CashSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CashSessionsTable> {
  $$CashSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get closedAt => $composableBuilder(
    column: $table.closedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get openingCash => $composableBuilder(
    column: $table.openingCash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get closingCash => $composableBuilder(
    column: $table.closingCash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expectedCash => $composableBuilder(
    column: $table.expectedCash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get openedByUserId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.openedByUserId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get closedByUserId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.closedByUserId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CashSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CashSessionsTable> {
  $$CashSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get openedAt =>
      $composableBuilder(column: $table.openedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => column);

  GeneratedColumn<int> get openingCash => $composableBuilder(
    column: $table.openingCash,
    builder: (column) => column,
  );

  GeneratedColumn<int> get closingCash => $composableBuilder(
    column: $table.closingCash,
    builder: (column) => column,
  );

  GeneratedColumn<int> get expectedCash => $composableBuilder(
    column: $table.expectedCash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get openedByUserId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.openedByUserId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get closedByUserId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.closedByUserId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> ordersRefs<T extends Object>(
    Expression<T> Function($$OrdersTableAnnotationComposer a) f,
  ) {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.cashSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CashSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CashSessionsTable,
          CashSession,
          $$CashSessionsTableFilterComposer,
          $$CashSessionsTableOrderingComposer,
          $$CashSessionsTableAnnotationComposer,
          $$CashSessionsTableCreateCompanionBuilder,
          $$CashSessionsTableUpdateCompanionBuilder,
          (CashSession, $$CashSessionsTableReferences),
          CashSession,
          PrefetchHooks Function({
            bool openedByUserId,
            bool closedByUserId,
            bool ordersRefs,
          })
        > {
  $$CashSessionsTableTableManager(_$AppDatabase db, $CashSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CashSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CashSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CashSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> openedByUserId = const Value.absent(),
                Value<String?> closedByUserId = const Value.absent(),
                Value<DateTime> openedAt = const Value.absent(),
                Value<DateTime?> closedAt = const Value.absent(),
                Value<int> openingCash = const Value.absent(),
                Value<int?> closingCash = const Value.absent(),
                Value<int?> expectedCash = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CashSessionsCompanion(
                id: id,
                openedByUserId: openedByUserId,
                closedByUserId: closedByUserId,
                openedAt: openedAt,
                closedAt: closedAt,
                openingCash: openingCash,
                closingCash: closingCash,
                expectedCash: expectedCash,
                note: note,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String openedByUserId,
                Value<String?> closedByUserId = const Value.absent(),
                required DateTime openedAt,
                Value<DateTime?> closedAt = const Value.absent(),
                Value<int> openingCash = const Value.absent(),
                Value<int?> closingCash = const Value.absent(),
                Value<int?> expectedCash = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CashSessionsCompanion.insert(
                id: id,
                openedByUserId: openedByUserId,
                closedByUserId: closedByUserId,
                openedAt: openedAt,
                closedAt: closedAt,
                openingCash: openingCash,
                closingCash: closingCash,
                expectedCash: expectedCash,
                note: note,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CashSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                openedByUserId = false,
                closedByUserId = false,
                ordersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (ordersRefs) db.orders],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (openedByUserId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.openedByUserId,
                                    referencedTable:
                                        $$CashSessionsTableReferences
                                            ._openedByUserIdTable(db),
                                    referencedColumn:
                                        $$CashSessionsTableReferences
                                            ._openedByUserIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (closedByUserId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.closedByUserId,
                                    referencedTable:
                                        $$CashSessionsTableReferences
                                            ._closedByUserIdTable(db),
                                    referencedColumn:
                                        $$CashSessionsTableReferences
                                            ._closedByUserIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (ordersRefs)
                        await $_getPrefetchedData<
                          CashSession,
                          $CashSessionsTable,
                          Order
                        >(
                          currentTable: table,
                          referencedTable: $$CashSessionsTableReferences
                              ._ordersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CashSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).ordersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cashSessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CashSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CashSessionsTable,
      CashSession,
      $$CashSessionsTableFilterComposer,
      $$CashSessionsTableOrderingComposer,
      $$CashSessionsTableAnnotationComposer,
      $$CashSessionsTableCreateCompanionBuilder,
      $$CashSessionsTableUpdateCompanionBuilder,
      (CashSession, $$CashSessionsTableReferences),
      CashSession,
      PrefetchHooks Function({
        bool openedByUserId,
        bool closedByUserId,
        bool ordersRefs,
      })
    >;
typedef $$OrdersTableCreateCompanionBuilder =
    OrdersCompanion Function({
      required String id,
      Value<String?> cashSessionId,
      Value<String?> cashierUserId,
      Value<String?> customerId,
      required String orderNumber,
      Value<String> status,
      Value<String> orderType,
      Value<int> subtotal,
      Value<int> manualDiscountTotal,
      Value<int> discountTotal,
      Value<String?> promoName,
      Value<int> taxTotal,
      Value<int> grandTotal,
      Value<String?> note,
      required DateTime orderedAt,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });
typedef $$OrdersTableUpdateCompanionBuilder =
    OrdersCompanion Function({
      Value<String> id,
      Value<String?> cashSessionId,
      Value<String?> cashierUserId,
      Value<String?> customerId,
      Value<String> orderNumber,
      Value<String> status,
      Value<String> orderType,
      Value<int> subtotal,
      Value<int> manualDiscountTotal,
      Value<int> discountTotal,
      Value<String?> promoName,
      Value<int> taxTotal,
      Value<int> grandTotal,
      Value<String?> note,
      Value<DateTime> orderedAt,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });

final class $$OrdersTableReferences
    extends BaseReferences<_$AppDatabase, $OrdersTable, Order> {
  $$OrdersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CashSessionsTable _cashSessionIdTable(_$AppDatabase db) =>
      db.cashSessions.createAlias('orders__cash_session_id__cash_sessions__id');

  $$CashSessionsTableProcessedTableManager? get cashSessionId {
    final $_column = $_itemColumn<String>('cash_session_id');
    if ($_column == null) return null;
    final manager = $$CashSessionsTableTableManager(
      $_db,
      $_db.cashSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cashSessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _cashierUserIdTable(_$AppDatabase db) =>
      db.users.createAlias('orders__cashier_user_id__users__id');

  $$UsersTableProcessedTableManager? get cashierUserId {
    final $_column = $_itemColumn<String>('cashier_user_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cashierUserIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias('orders__customer_id__customers__id');

  $$CustomersTableProcessedTableManager? get customerId {
    final $_column = $_itemColumn<String>('customer_id');
    if ($_column == null) return null;
    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$OrderItemsTable, List<OrderItem>>
  _orderItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.orderItems,
    aliasName: 'orders__id__order_items__order_id',
  );

  $$OrderItemsTableProcessedTableManager get orderItemsRefs {
    final manager = $$OrderItemsTableTableManager(
      $_db,
      $_db.orderItems,
    ).filter((f) => f.orderId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_orderItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: 'orders__id__payments__order_id',
  );

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.orderId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$OrdersTableFilterComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderNumber => $composableBuilder(
    column: $table.orderNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderType => $composableBuilder(
    column: $table.orderType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get manualDiscountTotal => $composableBuilder(
    column: $table.manualDiscountTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountTotal => $composableBuilder(
    column: $table.discountTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get promoName => $composableBuilder(
    column: $table.promoName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get taxTotal => $composableBuilder(
    column: $table.taxTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get grandTotal => $composableBuilder(
    column: $table.grandTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get orderedAt => $composableBuilder(
    column: $table.orderedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CashSessionsTableFilterComposer get cashSessionId {
    final $$CashSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cashSessionId,
      referencedTable: $db.cashSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashSessionsTableFilterComposer(
            $db: $db,
            $table: $db.cashSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get cashierUserId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cashierUserId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> orderItemsRefs(
    Expression<bool> Function($$OrderItemsTableFilterComposer f) f,
  ) {
    final $$OrderItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderItems,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderItemsTableFilterComposer(
            $db: $db,
            $table: $db.orderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentsRefs(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderNumber => $composableBuilder(
    column: $table.orderNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderType => $composableBuilder(
    column: $table.orderType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get manualDiscountTotal => $composableBuilder(
    column: $table.manualDiscountTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountTotal => $composableBuilder(
    column: $table.discountTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get promoName => $composableBuilder(
    column: $table.promoName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get taxTotal => $composableBuilder(
    column: $table.taxTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get grandTotal => $composableBuilder(
    column: $table.grandTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get orderedAt => $composableBuilder(
    column: $table.orderedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CashSessionsTableOrderingComposer get cashSessionId {
    final $$CashSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cashSessionId,
      referencedTable: $db.cashSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.cashSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get cashierUserId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cashierUserId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get orderNumber => $composableBuilder(
    column: $table.orderNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get orderType =>
      $composableBuilder(column: $table.orderType, builder: (column) => column);

  GeneratedColumn<int> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<int> get manualDiscountTotal => $composableBuilder(
    column: $table.manualDiscountTotal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get discountTotal => $composableBuilder(
    column: $table.discountTotal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get promoName =>
      $composableBuilder(column: $table.promoName, builder: (column) => column);

  GeneratedColumn<int> get taxTotal =>
      $composableBuilder(column: $table.taxTotal, builder: (column) => column);

  GeneratedColumn<int> get grandTotal => $composableBuilder(
    column: $table.grandTotal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get orderedAt =>
      $composableBuilder(column: $table.orderedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  $$CashSessionsTableAnnotationComposer get cashSessionId {
    final $$CashSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cashSessionId,
      referencedTable: $db.cashSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.cashSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get cashierUserId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cashierUserId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> orderItemsRefs<T extends Object>(
    Expression<T> Function($$OrderItemsTableAnnotationComposer a) f,
  ) {
    final $$OrderItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderItems,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.orderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentsRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrdersTable,
          Order,
          $$OrdersTableFilterComposer,
          $$OrdersTableOrderingComposer,
          $$OrdersTableAnnotationComposer,
          $$OrdersTableCreateCompanionBuilder,
          $$OrdersTableUpdateCompanionBuilder,
          (Order, $$OrdersTableReferences),
          Order,
          PrefetchHooks Function({
            bool cashSessionId,
            bool cashierUserId,
            bool customerId,
            bool orderItemsRefs,
            bool paymentsRefs,
          })
        > {
  $$OrdersTableTableManager(_$AppDatabase db, $OrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> cashSessionId = const Value.absent(),
                Value<String?> cashierUserId = const Value.absent(),
                Value<String?> customerId = const Value.absent(),
                Value<String> orderNumber = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> orderType = const Value.absent(),
                Value<int> subtotal = const Value.absent(),
                Value<int> manualDiscountTotal = const Value.absent(),
                Value<int> discountTotal = const Value.absent(),
                Value<String?> promoName = const Value.absent(),
                Value<int> taxTotal = const Value.absent(),
                Value<int> grandTotal = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> orderedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrdersCompanion(
                id: id,
                cashSessionId: cashSessionId,
                cashierUserId: cashierUserId,
                customerId: customerId,
                orderNumber: orderNumber,
                status: status,
                orderType: orderType,
                subtotal: subtotal,
                manualDiscountTotal: manualDiscountTotal,
                discountTotal: discountTotal,
                promoName: promoName,
                taxTotal: taxTotal,
                grandTotal: grandTotal,
                note: note,
                orderedAt: orderedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> cashSessionId = const Value.absent(),
                Value<String?> cashierUserId = const Value.absent(),
                Value<String?> customerId = const Value.absent(),
                required String orderNumber,
                Value<String> status = const Value.absent(),
                Value<String> orderType = const Value.absent(),
                Value<int> subtotal = const Value.absent(),
                Value<int> manualDiscountTotal = const Value.absent(),
                Value<int> discountTotal = const Value.absent(),
                Value<String?> promoName = const Value.absent(),
                Value<int> taxTotal = const Value.absent(),
                Value<int> grandTotal = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime orderedAt,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrdersCompanion.insert(
                id: id,
                cashSessionId: cashSessionId,
                cashierUserId: cashierUserId,
                customerId: customerId,
                orderNumber: orderNumber,
                status: status,
                orderType: orderType,
                subtotal: subtotal,
                manualDiscountTotal: manualDiscountTotal,
                discountTotal: discountTotal,
                promoName: promoName,
                taxTotal: taxTotal,
                grandTotal: grandTotal,
                note: note,
                orderedAt: orderedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$OrdersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                cashSessionId = false,
                cashierUserId = false,
                customerId = false,
                orderItemsRefs = false,
                paymentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (orderItemsRefs) db.orderItems,
                    if (paymentsRefs) db.payments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (cashSessionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.cashSessionId,
                                    referencedTable: $$OrdersTableReferences
                                        ._cashSessionIdTable(db),
                                    referencedColumn: $$OrdersTableReferences
                                        ._cashSessionIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (cashierUserId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.cashierUserId,
                                    referencedTable: $$OrdersTableReferences
                                        ._cashierUserIdTable(db),
                                    referencedColumn: $$OrdersTableReferences
                                        ._cashierUserIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (customerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.customerId,
                                    referencedTable: $$OrdersTableReferences
                                        ._customerIdTable(db),
                                    referencedColumn: $$OrdersTableReferences
                                        ._customerIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (orderItemsRefs)
                        await $_getPrefetchedData<
                          Order,
                          $OrdersTable,
                          OrderItem
                        >(
                          currentTable: table,
                          referencedTable: $$OrdersTableReferences
                              ._orderItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrdersTableReferences(
                                db,
                                table,
                                p0,
                              ).orderItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.orderId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentsRefs)
                        await $_getPrefetchedData<Order, $OrdersTable, Payment>(
                          currentTable: table,
                          referencedTable: $$OrdersTableReferences
                              ._paymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrdersTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.orderId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$OrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrdersTable,
      Order,
      $$OrdersTableFilterComposer,
      $$OrdersTableOrderingComposer,
      $$OrdersTableAnnotationComposer,
      $$OrdersTableCreateCompanionBuilder,
      $$OrdersTableUpdateCompanionBuilder,
      (Order, $$OrdersTableReferences),
      Order,
      PrefetchHooks Function({
        bool cashSessionId,
        bool cashierUserId,
        bool customerId,
        bool orderItemsRefs,
        bool paymentsRefs,
      })
    >;
typedef $$OrderItemsTableCreateCompanionBuilder =
    OrderItemsCompanion Function({
      required String id,
      required String orderId,
      Value<String?> productId,
      required String productName,
      required int qty,
      required int unitPrice,
      Value<int> discountTotal,
      required int lineTotal,
      Value<String> kitchenStatus,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$OrderItemsTableUpdateCompanionBuilder =
    OrderItemsCompanion Function({
      Value<String> id,
      Value<String> orderId,
      Value<String?> productId,
      Value<String> productName,
      Value<int> qty,
      Value<int> unitPrice,
      Value<int> discountTotal,
      Value<int> lineTotal,
      Value<String> kitchenStatus,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

final class $$OrderItemsTableReferences
    extends BaseReferences<_$AppDatabase, $OrderItemsTable, OrderItem> {
  $$OrderItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrdersTable _orderIdTable(_$AppDatabase db) =>
      db.orders.createAlias('order_items__order_id__orders__id');

  $$OrdersTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<String>('order_id')!;

    final manager = $$OrdersTableTableManager(
      $_db,
      $_db.orders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('order_items__product_id__products__id');

  $$ProductsTableProcessedTableManager? get productId {
    final $_column = $_itemColumn<String>('product_id');
    if ($_column == null) return null;
    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$OrderItemsTableFilterComposer
    extends Composer<_$AppDatabase, $OrderItemsTable> {
  $$OrderItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountTotal => $composableBuilder(
    column: $table.discountTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineTotal => $composableBuilder(
    column: $table.lineTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kitchenStatus => $composableBuilder(
    column: $table.kitchenStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$OrdersTableFilterComposer get orderId {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableFilterComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $OrderItemsTable> {
  $$OrderItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountTotal => $composableBuilder(
    column: $table.discountTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineTotal => $composableBuilder(
    column: $table.lineTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kitchenStatus => $composableBuilder(
    column: $table.kitchenStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrdersTableOrderingComposer get orderId {
    final $$OrdersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableOrderingComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrderItemsTable> {
  $$OrderItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);

  GeneratedColumn<int> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<int> get discountTotal => $composableBuilder(
    column: $table.discountTotal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lineTotal =>
      $composableBuilder(column: $table.lineTotal, builder: (column) => column);

  GeneratedColumn<String> get kitchenStatus => $composableBuilder(
    column: $table.kitchenStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$OrdersTableAnnotationComposer get orderId {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrderItemsTable,
          OrderItem,
          $$OrderItemsTableFilterComposer,
          $$OrderItemsTableOrderingComposer,
          $$OrderItemsTableAnnotationComposer,
          $$OrderItemsTableCreateCompanionBuilder,
          $$OrderItemsTableUpdateCompanionBuilder,
          (OrderItem, $$OrderItemsTableReferences),
          OrderItem,
          PrefetchHooks Function({bool orderId, bool productId})
        > {
  $$OrderItemsTableTableManager(_$AppDatabase db, $OrderItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrderItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrderItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrderItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> orderId = const Value.absent(),
                Value<String?> productId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<int> qty = const Value.absent(),
                Value<int> unitPrice = const Value.absent(),
                Value<int> discountTotal = const Value.absent(),
                Value<int> lineTotal = const Value.absent(),
                Value<String> kitchenStatus = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrderItemsCompanion(
                id: id,
                orderId: orderId,
                productId: productId,
                productName: productName,
                qty: qty,
                unitPrice: unitPrice,
                discountTotal: discountTotal,
                lineTotal: lineTotal,
                kitchenStatus: kitchenStatus,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String orderId,
                Value<String?> productId = const Value.absent(),
                required String productName,
                required int qty,
                required int unitPrice,
                Value<int> discountTotal = const Value.absent(),
                required int lineTotal,
                Value<String> kitchenStatus = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrderItemsCompanion.insert(
                id: id,
                orderId: orderId,
                productId: productId,
                productName: productName,
                qty: qty,
                unitPrice: unitPrice,
                discountTotal: discountTotal,
                lineTotal: lineTotal,
                kitchenStatus: kitchenStatus,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$OrderItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({orderId = false, productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (orderId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.orderId,
                                referencedTable: $$OrderItemsTableReferences
                                    ._orderIdTable(db),
                                referencedColumn: $$OrderItemsTableReferences
                                    ._orderIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$OrderItemsTableReferences
                                    ._productIdTable(db),
                                referencedColumn: $$OrderItemsTableReferences
                                    ._productIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$OrderItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrderItemsTable,
      OrderItem,
      $$OrderItemsTableFilterComposer,
      $$OrderItemsTableOrderingComposer,
      $$OrderItemsTableAnnotationComposer,
      $$OrderItemsTableCreateCompanionBuilder,
      $$OrderItemsTableUpdateCompanionBuilder,
      (OrderItem, $$OrderItemsTableReferences),
      OrderItem,
      PrefetchHooks Function({bool orderId, bool productId})
    >;
typedef $$PaymentsTableCreateCompanionBuilder =
    PaymentsCompanion Function({
      required String id,
      required String orderId,
      required String method,
      required int amount,
      Value<String?> referenceNumber,
      Value<String> status,
      required DateTime paidAt,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$PaymentsTableUpdateCompanionBuilder =
    PaymentsCompanion Function({
      Value<String> id,
      Value<String> orderId,
      Value<String> method,
      Value<int> amount,
      Value<String?> referenceNumber,
      Value<String> status,
      Value<DateTime> paidAt,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

final class $$PaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTable, Payment> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrdersTable _orderIdTable(_$AppDatabase db) =>
      db.orders.createAlias('payments__order_id__orders__id');

  $$OrdersTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<String>('order_id')!;

    final manager = $$OrdersTableTableManager(
      $_db,
      $_db.orders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$OrdersTableFilterComposer get orderId {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableFilterComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrdersTableOrderingComposer get orderId {
    final $$OrdersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableOrderingComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get referenceNumber => $composableBuilder(
    column: $table.referenceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$OrdersTableAnnotationComposer get orderId {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTable,
          Payment,
          $$PaymentsTableFilterComposer,
          $$PaymentsTableOrderingComposer,
          $$PaymentsTableAnnotationComposer,
          $$PaymentsTableCreateCompanionBuilder,
          $$PaymentsTableUpdateCompanionBuilder,
          (Payment, $$PaymentsTableReferences),
          Payment,
          PrefetchHooks Function({bool orderId})
        > {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> orderId = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String?> referenceNumber = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> paidAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsCompanion(
                id: id,
                orderId: orderId,
                method: method,
                amount: amount,
                referenceNumber: referenceNumber,
                status: status,
                paidAt: paidAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String orderId,
                required String method,
                required int amount,
                Value<String?> referenceNumber = const Value.absent(),
                Value<String> status = const Value.absent(),
                required DateTime paidAt,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsCompanion.insert(
                id: id,
                orderId: orderId,
                method: method,
                amount: amount,
                referenceNumber: referenceNumber,
                status: status,
                paidAt: paidAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({orderId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (orderId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.orderId,
                                referencedTable: $$PaymentsTableReferences
                                    ._orderIdTable(db),
                                referencedColumn: $$PaymentsTableReferences
                                    ._orderIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTable,
      Payment,
      $$PaymentsTableFilterComposer,
      $$PaymentsTableOrderingComposer,
      $$PaymentsTableAnnotationComposer,
      $$PaymentsTableCreateCompanionBuilder,
      $$PaymentsTableUpdateCompanionBuilder,
      (Payment, $$PaymentsTableReferences),
      Payment,
      PrefetchHooks Function({bool orderId})
    >;
typedef $$SyncQueueTableCreateCompanionBuilder =
    SyncQueueCompanion Function({
      required String id,
      required String entityType,
      required String entityId,
      required String action,
      required String payloadJson,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });
typedef $$SyncQueueTableUpdateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<String> id,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> action,
      Value<String> payloadJson,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTable,
          SyncQueueData,
          $$SyncQueueTableFilterComposer,
          $$SyncQueueTableOrderingComposer,
          $$SyncQueueTableAnnotationComposer,
          $$SyncQueueTableCreateCompanionBuilder,
          $$SyncQueueTableUpdateCompanionBuilder,
          (
            SyncQueueData,
            BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
          ),
          SyncQueueData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                action: action,
                payloadJson: payloadJson,
                retryCount: retryCount,
                lastError: lastError,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String entityType,
                required String entityId,
                required String action,
                required String payloadJson,
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                action: action,
                payloadJson: payloadJson,
                retryCount: retryCount,
                lastError: lastError,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTable,
      SyncQueueData,
      $$SyncQueueTableFilterComposer,
      $$SyncQueueTableOrderingComposer,
      $$SyncQueueTableAnnotationComposer,
      $$SyncQueueTableCreateCompanionBuilder,
      $$SyncQueueTableUpdateCompanionBuilder,
      (
        SyncQueueData,
        BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
      ),
      SyncQueueData,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String id,
      Value<String> outletName,
      Value<String?> outletAddress,
      Value<String?> outletPhone,
      Value<String?> receiptHeader,
      Value<String> receiptFooter,
      Value<bool> taxEnabled,
      Value<int> taxRate,
      Value<bool> serviceEnabled,
      Value<int> serviceRate,
      Value<bool> showOutletAddress,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> id,
      Value<String> outletName,
      Value<String?> outletAddress,
      Value<String?> outletPhone,
      Value<String?> receiptHeader,
      Value<String> receiptFooter,
      Value<bool> taxEnabled,
      Value<int> taxRate,
      Value<bool> serviceEnabled,
      Value<int> serviceRate,
      Value<bool> showOutletAddress,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outletName => $composableBuilder(
    column: $table.outletName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outletAddress => $composableBuilder(
    column: $table.outletAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outletPhone => $composableBuilder(
    column: $table.outletPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptHeader => $composableBuilder(
    column: $table.receiptHeader,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptFooter => $composableBuilder(
    column: $table.receiptFooter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get taxEnabled => $composableBuilder(
    column: $table.taxEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get taxRate => $composableBuilder(
    column: $table.taxRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get serviceEnabled => $composableBuilder(
    column: $table.serviceEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serviceRate => $composableBuilder(
    column: $table.serviceRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showOutletAddress => $composableBuilder(
    column: $table.showOutletAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outletName => $composableBuilder(
    column: $table.outletName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outletAddress => $composableBuilder(
    column: $table.outletAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outletPhone => $composableBuilder(
    column: $table.outletPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptHeader => $composableBuilder(
    column: $table.receiptHeader,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptFooter => $composableBuilder(
    column: $table.receiptFooter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get taxEnabled => $composableBuilder(
    column: $table.taxEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get taxRate => $composableBuilder(
    column: $table.taxRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get serviceEnabled => $composableBuilder(
    column: $table.serviceEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serviceRate => $composableBuilder(
    column: $table.serviceRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showOutletAddress => $composableBuilder(
    column: $table.showOutletAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get outletName => $composableBuilder(
    column: $table.outletName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get outletAddress => $composableBuilder(
    column: $table.outletAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get outletPhone => $composableBuilder(
    column: $table.outletPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiptHeader => $composableBuilder(
    column: $table.receiptHeader,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiptFooter => $composableBuilder(
    column: $table.receiptFooter,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get taxEnabled => $composableBuilder(
    column: $table.taxEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get taxRate =>
      $composableBuilder(column: $table.taxRate, builder: (column) => column);

  GeneratedColumn<bool> get serviceEnabled => $composableBuilder(
    column: $table.serviceEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get serviceRate => $composableBuilder(
    column: $table.serviceRate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get showOutletAddress => $composableBuilder(
    column: $table.showOutletAddress,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> outletName = const Value.absent(),
                Value<String?> outletAddress = const Value.absent(),
                Value<String?> outletPhone = const Value.absent(),
                Value<String?> receiptHeader = const Value.absent(),
                Value<String> receiptFooter = const Value.absent(),
                Value<bool> taxEnabled = const Value.absent(),
                Value<int> taxRate = const Value.absent(),
                Value<bool> serviceEnabled = const Value.absent(),
                Value<int> serviceRate = const Value.absent(),
                Value<bool> showOutletAddress = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                outletName: outletName,
                outletAddress: outletAddress,
                outletPhone: outletPhone,
                receiptHeader: receiptHeader,
                receiptFooter: receiptFooter,
                taxEnabled: taxEnabled,
                taxRate: taxRate,
                serviceEnabled: serviceEnabled,
                serviceRate: serviceRate,
                showOutletAddress: showOutletAddress,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> outletName = const Value.absent(),
                Value<String?> outletAddress = const Value.absent(),
                Value<String?> outletPhone = const Value.absent(),
                Value<String?> receiptHeader = const Value.absent(),
                Value<String> receiptFooter = const Value.absent(),
                Value<bool> taxEnabled = const Value.absent(),
                Value<int> taxRate = const Value.absent(),
                Value<bool> serviceEnabled = const Value.absent(),
                Value<int> serviceRate = const Value.absent(),
                Value<bool> showOutletAddress = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                outletName: outletName,
                outletAddress: outletAddress,
                outletPhone: outletPhone,
                receiptHeader: receiptHeader,
                receiptFooter: receiptFooter,
                taxEnabled: taxEnabled,
                taxRate: taxRate,
                serviceEnabled: serviceEnabled,
                serviceRate: serviceRate,
                showOutletAddress: showOutletAddress,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;
typedef $$DeviceSettingsTableCreateCompanionBuilder =
    DeviceSettingsCompanion Function({
      required String id,
      Value<String> printerType,
      Value<String?> printerName,
      Value<String?> printerAddress,
      Value<String?> printerIp,
      Value<int> printerPort,
      Value<int> paperWidth,
      Value<bool> cashDrawerEnabled,
      Value<bool> barcodeScannerEnabled,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$DeviceSettingsTableUpdateCompanionBuilder =
    DeviceSettingsCompanion Function({
      Value<String> id,
      Value<String> printerType,
      Value<String?> printerName,
      Value<String?> printerAddress,
      Value<String?> printerIp,
      Value<int> printerPort,
      Value<int> paperWidth,
      Value<bool> cashDrawerEnabled,
      Value<bool> barcodeScannerEnabled,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$DeviceSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $DeviceSettingsTable> {
  $$DeviceSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get printerType => $composableBuilder(
    column: $table.printerType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get printerName => $composableBuilder(
    column: $table.printerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get printerAddress => $composableBuilder(
    column: $table.printerAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get printerIp => $composableBuilder(
    column: $table.printerIp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get printerPort => $composableBuilder(
    column: $table.printerPort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paperWidth => $composableBuilder(
    column: $table.paperWidth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get cashDrawerEnabled => $composableBuilder(
    column: $table.cashDrawerEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get barcodeScannerEnabled => $composableBuilder(
    column: $table.barcodeScannerEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DeviceSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $DeviceSettingsTable> {
  $$DeviceSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get printerType => $composableBuilder(
    column: $table.printerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get printerName => $composableBuilder(
    column: $table.printerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get printerAddress => $composableBuilder(
    column: $table.printerAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get printerIp => $composableBuilder(
    column: $table.printerIp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get printerPort => $composableBuilder(
    column: $table.printerPort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paperWidth => $composableBuilder(
    column: $table.paperWidth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get cashDrawerEnabled => $composableBuilder(
    column: $table.cashDrawerEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get barcodeScannerEnabled => $composableBuilder(
    column: $table.barcodeScannerEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DeviceSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeviceSettingsTable> {
  $$DeviceSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get printerType => $composableBuilder(
    column: $table.printerType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get printerName => $composableBuilder(
    column: $table.printerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get printerAddress => $composableBuilder(
    column: $table.printerAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get printerIp =>
      $composableBuilder(column: $table.printerIp, builder: (column) => column);

  GeneratedColumn<int> get printerPort => $composableBuilder(
    column: $table.printerPort,
    builder: (column) => column,
  );

  GeneratedColumn<int> get paperWidth => $composableBuilder(
    column: $table.paperWidth,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get cashDrawerEnabled => $composableBuilder(
    column: $table.cashDrawerEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get barcodeScannerEnabled => $composableBuilder(
    column: $table.barcodeScannerEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DeviceSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeviceSettingsTable,
          DeviceSetting,
          $$DeviceSettingsTableFilterComposer,
          $$DeviceSettingsTableOrderingComposer,
          $$DeviceSettingsTableAnnotationComposer,
          $$DeviceSettingsTableCreateCompanionBuilder,
          $$DeviceSettingsTableUpdateCompanionBuilder,
          (
            DeviceSetting,
            BaseReferences<_$AppDatabase, $DeviceSettingsTable, DeviceSetting>,
          ),
          DeviceSetting,
          PrefetchHooks Function()
        > {
  $$DeviceSettingsTableTableManager(
    _$AppDatabase db,
    $DeviceSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeviceSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeviceSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeviceSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> printerType = const Value.absent(),
                Value<String?> printerName = const Value.absent(),
                Value<String?> printerAddress = const Value.absent(),
                Value<String?> printerIp = const Value.absent(),
                Value<int> printerPort = const Value.absent(),
                Value<int> paperWidth = const Value.absent(),
                Value<bool> cashDrawerEnabled = const Value.absent(),
                Value<bool> barcodeScannerEnabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeviceSettingsCompanion(
                id: id,
                printerType: printerType,
                printerName: printerName,
                printerAddress: printerAddress,
                printerIp: printerIp,
                printerPort: printerPort,
                paperWidth: paperWidth,
                cashDrawerEnabled: cashDrawerEnabled,
                barcodeScannerEnabled: barcodeScannerEnabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> printerType = const Value.absent(),
                Value<String?> printerName = const Value.absent(),
                Value<String?> printerAddress = const Value.absent(),
                Value<String?> printerIp = const Value.absent(),
                Value<int> printerPort = const Value.absent(),
                Value<int> paperWidth = const Value.absent(),
                Value<bool> cashDrawerEnabled = const Value.absent(),
                Value<bool> barcodeScannerEnabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeviceSettingsCompanion.insert(
                id: id,
                printerType: printerType,
                printerName: printerName,
                printerAddress: printerAddress,
                printerIp: printerIp,
                printerPort: printerPort,
                paperWidth: paperWidth,
                cashDrawerEnabled: cashDrawerEnabled,
                barcodeScannerEnabled: barcodeScannerEnabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DeviceSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeviceSettingsTable,
      DeviceSetting,
      $$DeviceSettingsTableFilterComposer,
      $$DeviceSettingsTableOrderingComposer,
      $$DeviceSettingsTableAnnotationComposer,
      $$DeviceSettingsTableCreateCompanionBuilder,
      $$DeviceSettingsTableUpdateCompanionBuilder,
      (
        DeviceSetting,
        BaseReferences<_$AppDatabase, $DeviceSettingsTable, DeviceSetting>,
      ),
      DeviceSetting,
      PrefetchHooks Function()
    >;
typedef $$CashierSettingsTableCreateCompanionBuilder =
    CashierSettingsCompanion Function({
      required String id,
      Value<String> invoicePrefix,
      Value<bool> resetInvoiceDaily,
      Value<String> defaultPaymentMethod,
      Value<String> defaultOrderType,
      Value<bool> manualDiscountEnabled,
      Value<bool> customerRequired,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$CashierSettingsTableUpdateCompanionBuilder =
    CashierSettingsCompanion Function({
      Value<String> id,
      Value<String> invoicePrefix,
      Value<bool> resetInvoiceDaily,
      Value<String> defaultPaymentMethod,
      Value<String> defaultOrderType,
      Value<bool> manualDiscountEnabled,
      Value<bool> customerRequired,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$CashierSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $CashierSettingsTable> {
  $$CashierSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoicePrefix => $composableBuilder(
    column: $table.invoicePrefix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get resetInvoiceDaily => $composableBuilder(
    column: $table.resetInvoiceDaily,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultPaymentMethod => $composableBuilder(
    column: $table.defaultPaymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultOrderType => $composableBuilder(
    column: $table.defaultOrderType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get manualDiscountEnabled => $composableBuilder(
    column: $table.manualDiscountEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get customerRequired => $composableBuilder(
    column: $table.customerRequired,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CashierSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $CashierSettingsTable> {
  $$CashierSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoicePrefix => $composableBuilder(
    column: $table.invoicePrefix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get resetInvoiceDaily => $composableBuilder(
    column: $table.resetInvoiceDaily,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultPaymentMethod => $composableBuilder(
    column: $table.defaultPaymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultOrderType => $composableBuilder(
    column: $table.defaultOrderType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get manualDiscountEnabled => $composableBuilder(
    column: $table.manualDiscountEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get customerRequired => $composableBuilder(
    column: $table.customerRequired,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CashierSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CashierSettingsTable> {
  $$CashierSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoicePrefix => $composableBuilder(
    column: $table.invoicePrefix,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get resetInvoiceDaily => $composableBuilder(
    column: $table.resetInvoiceDaily,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultPaymentMethod => $composableBuilder(
    column: $table.defaultPaymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultOrderType => $composableBuilder(
    column: $table.defaultOrderType,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get manualDiscountEnabled => $composableBuilder(
    column: $table.manualDiscountEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get customerRequired => $composableBuilder(
    column: $table.customerRequired,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CashierSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CashierSettingsTable,
          CashierSetting,
          $$CashierSettingsTableFilterComposer,
          $$CashierSettingsTableOrderingComposer,
          $$CashierSettingsTableAnnotationComposer,
          $$CashierSettingsTableCreateCompanionBuilder,
          $$CashierSettingsTableUpdateCompanionBuilder,
          (
            CashierSetting,
            BaseReferences<
              _$AppDatabase,
              $CashierSettingsTable,
              CashierSetting
            >,
          ),
          CashierSetting,
          PrefetchHooks Function()
        > {
  $$CashierSettingsTableTableManager(
    _$AppDatabase db,
    $CashierSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CashierSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CashierSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CashierSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> invoicePrefix = const Value.absent(),
                Value<bool> resetInvoiceDaily = const Value.absent(),
                Value<String> defaultPaymentMethod = const Value.absent(),
                Value<String> defaultOrderType = const Value.absent(),
                Value<bool> manualDiscountEnabled = const Value.absent(),
                Value<bool> customerRequired = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CashierSettingsCompanion(
                id: id,
                invoicePrefix: invoicePrefix,
                resetInvoiceDaily: resetInvoiceDaily,
                defaultPaymentMethod: defaultPaymentMethod,
                defaultOrderType: defaultOrderType,
                manualDiscountEnabled: manualDiscountEnabled,
                customerRequired: customerRequired,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> invoicePrefix = const Value.absent(),
                Value<bool> resetInvoiceDaily = const Value.absent(),
                Value<String> defaultPaymentMethod = const Value.absent(),
                Value<String> defaultOrderType = const Value.absent(),
                Value<bool> manualDiscountEnabled = const Value.absent(),
                Value<bool> customerRequired = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CashierSettingsCompanion.insert(
                id: id,
                invoicePrefix: invoicePrefix,
                resetInvoiceDaily: resetInvoiceDaily,
                defaultPaymentMethod: defaultPaymentMethod,
                defaultOrderType: defaultOrderType,
                manualDiscountEnabled: manualDiscountEnabled,
                customerRequired: customerRequired,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CashierSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CashierSettingsTable,
      CashierSetting,
      $$CashierSettingsTableFilterComposer,
      $$CashierSettingsTableOrderingComposer,
      $$CashierSettingsTableAnnotationComposer,
      $$CashierSettingsTableCreateCompanionBuilder,
      $$CashierSettingsTableUpdateCompanionBuilder,
      (
        CashierSetting,
        BaseReferences<_$AppDatabase, $CashierSettingsTable, CashierSetting>,
      ),
      CashierSetting,
      PrefetchHooks Function()
    >;
typedef $$PaymentSettingsTableCreateCompanionBuilder =
    PaymentSettingsCompanion Function({
      required String id,
      Value<bool> qrisEnabled,
      Value<String?> qrisProvider,
      Value<String?> qrisMerchantId,
      Value<String?> qrisImagePath,
      Value<String?> qrisInstruction,
      Value<bool> debitEnabled,
      Value<String?> debitProvider,
      Value<String?> debitMerchantId,
      Value<String?> debitInstruction,
      Value<bool> transferEnabled,
      Value<String?> transferBankName,
      Value<String?> transferAccountNumber,
      Value<String?> transferAccountName,
      Value<String?> transferInstruction,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$PaymentSettingsTableUpdateCompanionBuilder =
    PaymentSettingsCompanion Function({
      Value<String> id,
      Value<bool> qrisEnabled,
      Value<String?> qrisProvider,
      Value<String?> qrisMerchantId,
      Value<String?> qrisImagePath,
      Value<String?> qrisInstruction,
      Value<bool> debitEnabled,
      Value<String?> debitProvider,
      Value<String?> debitMerchantId,
      Value<String?> debitInstruction,
      Value<bool> transferEnabled,
      Value<String?> transferBankName,
      Value<String?> transferAccountNumber,
      Value<String?> transferAccountName,
      Value<String?> transferInstruction,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$PaymentSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentSettingsTable> {
  $$PaymentSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get qrisEnabled => $composableBuilder(
    column: $table.qrisEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qrisProvider => $composableBuilder(
    column: $table.qrisProvider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qrisMerchantId => $composableBuilder(
    column: $table.qrisMerchantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qrisImagePath => $composableBuilder(
    column: $table.qrisImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qrisInstruction => $composableBuilder(
    column: $table.qrisInstruction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get debitEnabled => $composableBuilder(
    column: $table.debitEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get debitProvider => $composableBuilder(
    column: $table.debitProvider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get debitMerchantId => $composableBuilder(
    column: $table.debitMerchantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get debitInstruction => $composableBuilder(
    column: $table.debitInstruction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get transferEnabled => $composableBuilder(
    column: $table.transferEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transferBankName => $composableBuilder(
    column: $table.transferBankName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transferAccountNumber => $composableBuilder(
    column: $table.transferAccountNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transferAccountName => $composableBuilder(
    column: $table.transferAccountName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transferInstruction => $composableBuilder(
    column: $table.transferInstruction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PaymentSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentSettingsTable> {
  $$PaymentSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get qrisEnabled => $composableBuilder(
    column: $table.qrisEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qrisProvider => $composableBuilder(
    column: $table.qrisProvider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qrisMerchantId => $composableBuilder(
    column: $table.qrisMerchantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qrisImagePath => $composableBuilder(
    column: $table.qrisImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qrisInstruction => $composableBuilder(
    column: $table.qrisInstruction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get debitEnabled => $composableBuilder(
    column: $table.debitEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get debitProvider => $composableBuilder(
    column: $table.debitProvider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get debitMerchantId => $composableBuilder(
    column: $table.debitMerchantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get debitInstruction => $composableBuilder(
    column: $table.debitInstruction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get transferEnabled => $composableBuilder(
    column: $table.transferEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transferBankName => $composableBuilder(
    column: $table.transferBankName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transferAccountNumber => $composableBuilder(
    column: $table.transferAccountNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transferAccountName => $composableBuilder(
    column: $table.transferAccountName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transferInstruction => $composableBuilder(
    column: $table.transferInstruction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PaymentSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentSettingsTable> {
  $$PaymentSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get qrisEnabled => $composableBuilder(
    column: $table.qrisEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get qrisProvider => $composableBuilder(
    column: $table.qrisProvider,
    builder: (column) => column,
  );

  GeneratedColumn<String> get qrisMerchantId => $composableBuilder(
    column: $table.qrisMerchantId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get qrisImagePath => $composableBuilder(
    column: $table.qrisImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get qrisInstruction => $composableBuilder(
    column: $table.qrisInstruction,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get debitEnabled => $composableBuilder(
    column: $table.debitEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get debitProvider => $composableBuilder(
    column: $table.debitProvider,
    builder: (column) => column,
  );

  GeneratedColumn<String> get debitMerchantId => $composableBuilder(
    column: $table.debitMerchantId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get debitInstruction => $composableBuilder(
    column: $table.debitInstruction,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get transferEnabled => $composableBuilder(
    column: $table.transferEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transferBankName => $composableBuilder(
    column: $table.transferBankName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transferAccountNumber => $composableBuilder(
    column: $table.transferAccountNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transferAccountName => $composableBuilder(
    column: $table.transferAccountName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transferInstruction => $composableBuilder(
    column: $table.transferInstruction,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PaymentSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentSettingsTable,
          PaymentSetting,
          $$PaymentSettingsTableFilterComposer,
          $$PaymentSettingsTableOrderingComposer,
          $$PaymentSettingsTableAnnotationComposer,
          $$PaymentSettingsTableCreateCompanionBuilder,
          $$PaymentSettingsTableUpdateCompanionBuilder,
          (
            PaymentSetting,
            BaseReferences<
              _$AppDatabase,
              $PaymentSettingsTable,
              PaymentSetting
            >,
          ),
          PaymentSetting,
          PrefetchHooks Function()
        > {
  $$PaymentSettingsTableTableManager(
    _$AppDatabase db,
    $PaymentSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<bool> qrisEnabled = const Value.absent(),
                Value<String?> qrisProvider = const Value.absent(),
                Value<String?> qrisMerchantId = const Value.absent(),
                Value<String?> qrisImagePath = const Value.absent(),
                Value<String?> qrisInstruction = const Value.absent(),
                Value<bool> debitEnabled = const Value.absent(),
                Value<String?> debitProvider = const Value.absent(),
                Value<String?> debitMerchantId = const Value.absent(),
                Value<String?> debitInstruction = const Value.absent(),
                Value<bool> transferEnabled = const Value.absent(),
                Value<String?> transferBankName = const Value.absent(),
                Value<String?> transferAccountNumber = const Value.absent(),
                Value<String?> transferAccountName = const Value.absent(),
                Value<String?> transferInstruction = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentSettingsCompanion(
                id: id,
                qrisEnabled: qrisEnabled,
                qrisProvider: qrisProvider,
                qrisMerchantId: qrisMerchantId,
                qrisImagePath: qrisImagePath,
                qrisInstruction: qrisInstruction,
                debitEnabled: debitEnabled,
                debitProvider: debitProvider,
                debitMerchantId: debitMerchantId,
                debitInstruction: debitInstruction,
                transferEnabled: transferEnabled,
                transferBankName: transferBankName,
                transferAccountNumber: transferAccountNumber,
                transferAccountName: transferAccountName,
                transferInstruction: transferInstruction,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<bool> qrisEnabled = const Value.absent(),
                Value<String?> qrisProvider = const Value.absent(),
                Value<String?> qrisMerchantId = const Value.absent(),
                Value<String?> qrisImagePath = const Value.absent(),
                Value<String?> qrisInstruction = const Value.absent(),
                Value<bool> debitEnabled = const Value.absent(),
                Value<String?> debitProvider = const Value.absent(),
                Value<String?> debitMerchantId = const Value.absent(),
                Value<String?> debitInstruction = const Value.absent(),
                Value<bool> transferEnabled = const Value.absent(),
                Value<String?> transferBankName = const Value.absent(),
                Value<String?> transferAccountNumber = const Value.absent(),
                Value<String?> transferAccountName = const Value.absent(),
                Value<String?> transferInstruction = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentSettingsCompanion.insert(
                id: id,
                qrisEnabled: qrisEnabled,
                qrisProvider: qrisProvider,
                qrisMerchantId: qrisMerchantId,
                qrisImagePath: qrisImagePath,
                qrisInstruction: qrisInstruction,
                debitEnabled: debitEnabled,
                debitProvider: debitProvider,
                debitMerchantId: debitMerchantId,
                debitInstruction: debitInstruction,
                transferEnabled: transferEnabled,
                transferBankName: transferBankName,
                transferAccountNumber: transferAccountNumber,
                transferAccountName: transferAccountName,
                transferInstruction: transferInstruction,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PaymentSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentSettingsTable,
      PaymentSetting,
      $$PaymentSettingsTableFilterComposer,
      $$PaymentSettingsTableOrderingComposer,
      $$PaymentSettingsTableAnnotationComposer,
      $$PaymentSettingsTableCreateCompanionBuilder,
      $$PaymentSettingsTableUpdateCompanionBuilder,
      (
        PaymentSetting,
        BaseReferences<_$AppDatabase, $PaymentSettingsTable, PaymentSetting>,
      ),
      PaymentSetting,
      PrefetchHooks Function()
    >;
typedef $$PromosTableCreateCompanionBuilder =
    PromosCompanion Function({
      required String id,
      required String name,
      required String type,
      required int value,
      Value<String> scope,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$PromosTableUpdateCompanionBuilder =
    PromosCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> type,
      Value<int> value,
      Value<String> scope,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

class $$PromosTableFilterComposer
    extends Composer<_$AppDatabase, $PromosTable> {
  $$PromosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PromosTableOrderingComposer
    extends Composer<_$AppDatabase, $PromosTable> {
  $$PromosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PromosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PromosTable> {
  $$PromosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$PromosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PromosTable,
          Promo,
          $$PromosTableFilterComposer,
          $$PromosTableOrderingComposer,
          $$PromosTableAnnotationComposer,
          $$PromosTableCreateCompanionBuilder,
          $$PromosTableUpdateCompanionBuilder,
          (Promo, BaseReferences<_$AppDatabase, $PromosTable, Promo>),
          Promo,
          PrefetchHooks Function()
        > {
  $$PromosTableTableManager(_$AppDatabase db, $PromosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PromosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PromosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PromosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> value = const Value.absent(),
                Value<String> scope = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PromosCompanion(
                id: id,
                name: name,
                type: type,
                value: value,
                scope: scope,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String type,
                required int value,
                Value<String> scope = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PromosCompanion.insert(
                id: id,
                name: name,
                type: type,
                value: value,
                scope: scope,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PromosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PromosTable,
      Promo,
      $$PromosTableFilterComposer,
      $$PromosTableOrderingComposer,
      $$PromosTableAnnotationComposer,
      $$PromosTableCreateCompanionBuilder,
      $$PromosTableUpdateCompanionBuilder,
      (Promo, BaseReferences<_$AppDatabase, $PromosTable, Promo>),
      Promo,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$StockMovementsTableTableManager get stockMovements =>
      $$StockMovementsTableTableManager(_db, _db.stockMovements);
  $$RolesTableTableManager get roles =>
      $$RolesTableTableManager(_db, _db.roles);
  $$PermissionsTableTableManager get permissions =>
      $$PermissionsTableTableManager(_db, _db.permissions);
  $$RolePermissionsTableTableManager get rolePermissions =>
      $$RolePermissionsTableTableManager(_db, _db.rolePermissions);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$CashSessionsTableTableManager get cashSessions =>
      $$CashSessionsTableTableManager(_db, _db.cashSessions);
  $$OrdersTableTableManager get orders =>
      $$OrdersTableTableManager(_db, _db.orders);
  $$OrderItemsTableTableManager get orderItems =>
      $$OrderItemsTableTableManager(_db, _db.orderItems);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$DeviceSettingsTableTableManager get deviceSettings =>
      $$DeviceSettingsTableTableManager(_db, _db.deviceSettings);
  $$CashierSettingsTableTableManager get cashierSettings =>
      $$CashierSettingsTableTableManager(_db, _db.cashierSettings);
  $$PaymentSettingsTableTableManager get paymentSettings =>
      $$PaymentSettingsTableTableManager(_db, _db.paymentSettings);
  $$PromosTableTableManager get promos =>
      $$PromosTableTableManager(_db, _db.promos);
}
