import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Products extends Table {
  TextColumn get id => text()();
  TextColumn get categoryId => text().nullable().references(Categories, #id)();
  TextColumn get sku => text().nullable()();
  TextColumn get barcode => text().nullable()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get imagePath => text().nullable()();
  IntColumn get price => integer()();
  IntColumn get cost => integer().nullable()();
  BoolColumn get trackStock => boolean().withDefault(const Constant(false))();
  IntColumn get stockQty => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Roles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get code => text().unique()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Permissions extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get code => text().unique()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class RolePermissions extends Table {
  TextColumn get roleId => text().references(Roles, #id)();
  TextColumn get permissionId => text().references(Permissions, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {roleId, permissionId};
}

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get roleId => text().nullable().references(Roles, #id)();
  TextColumn get name => text()();
  TextColumn get email => text().nullable()();
  TextColumn get pinHash => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Customers extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get note => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class CashSessions extends Table {
  TextColumn get id => text()();
  @ReferenceName('openedCashSessions')
  TextColumn get openedByUserId => text().references(Users, #id)();
  @ReferenceName('closedCashSessions')
  TextColumn get closedByUserId => text().nullable().references(Users, #id)();
  DateTimeColumn get openedAt => dateTime()();
  DateTimeColumn get closedAt => dateTime().nullable()();
  IntColumn get openingCash => integer().withDefault(const Constant(0))();
  IntColumn get closingCash => integer().nullable()();
  IntColumn get expectedCash => integer().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('open'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Orders extends Table {
  TextColumn get id => text()();
  TextColumn get cashSessionId =>
      text().nullable().references(CashSessions, #id)();
  TextColumn get cashierUserId => text().nullable().references(Users, #id)();
  TextColumn get customerId => text().nullable().references(Customers, #id)();
  TextColumn get orderNumber => text()();
  TextColumn get status => text().withDefault(const Constant('completed'))();
  TextColumn get orderType => text().withDefault(const Constant('takeaway'))();
  IntColumn get subtotal => integer().withDefault(const Constant(0))();
  IntColumn get discountTotal => integer().withDefault(const Constant(0))();
  IntColumn get taxTotal => integer().withDefault(const Constant(0))();
  IntColumn get grandTotal => integer().withDefault(const Constant(0))();
  TextColumn get note => text().nullable()();
  DateTimeColumn get orderedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get syncedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class OrderItems extends Table {
  TextColumn get id => text()();
  TextColumn get orderId => text().references(Orders, #id)();
  TextColumn get productId => text().nullable().references(Products, #id)();
  TextColumn get productName => text()();
  IntColumn get qty => integer()();
  IntColumn get unitPrice => integer()();
  IntColumn get discountTotal => integer().withDefault(const Constant(0))();
  IntColumn get lineTotal => integer()();
  TextColumn get kitchenStatus =>
      text().withDefault(const Constant('pending'))();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Payments extends Table {
  TextColumn get id => text()();
  TextColumn get orderId => text().references(Orders, #id)();
  TextColumn get method => text()();
  IntColumn get amount => integer()();
  TextColumn get referenceNumber => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('paid'))();
  DateTimeColumn get paidAt => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class SyncQueue extends Table {
  TextColumn get id => text()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get action => text()();
  TextColumn get payloadJson => text()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get syncedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class AppSettings extends Table {
  TextColumn get id => text()();
  TextColumn get outletName =>
      text().withDefault(const Constant('Patali Demo Outlet'))();
  TextColumn get outletAddress => text().nullable()();
  TextColumn get outletPhone => text().nullable()();
  TextColumn get receiptHeader => text().nullable()();
  TextColumn get receiptFooter =>
      text().withDefault(const Constant('Terima kasih'))();
  BoolColumn get taxEnabled => boolean().withDefault(const Constant(false))();
  IntColumn get taxRate => integer().withDefault(const Constant(0))();
  BoolColumn get serviceEnabled =>
      boolean().withDefault(const Constant(false))();
  IntColumn get serviceRate => integer().withDefault(const Constant(0))();
  BoolColumn get showOutletAddress =>
      boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DeviceSettings extends Table {
  TextColumn get id => text()();
  TextColumn get printerType =>
      text().withDefault(const Constant('bluetooth'))();
  TextColumn get printerName => text().nullable()();
  TextColumn get printerAddress => text().nullable()();
  TextColumn get printerIp => text().nullable()();
  IntColumn get printerPort => integer().withDefault(const Constant(9100))();
  IntColumn get paperWidth => integer().withDefault(const Constant(58))();
  BoolColumn get cashDrawerEnabled =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get barcodeScannerEnabled =>
      boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class CashierSettings extends Table {
  TextColumn get id => text()();
  TextColumn get invoicePrefix => text().withDefault(const Constant('INV'))();
  BoolColumn get resetInvoiceDaily =>
      boolean().withDefault(const Constant(true))();
  TextColumn get defaultPaymentMethod =>
      text().withDefault(const Constant('cash'))();
  TextColumn get defaultOrderType =>
      text().withDefault(const Constant('Bungkus'))();
  BoolColumn get manualDiscountEnabled =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get customerRequired =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class PaymentSettings extends Table {
  TextColumn get id => text()();
  BoolColumn get qrisEnabled => boolean().withDefault(const Constant(true))();
  TextColumn get qrisProvider => text().nullable()();
  TextColumn get qrisMerchantId => text().nullable()();
  TextColumn get qrisImagePath => text().nullable()();
  TextColumn get qrisInstruction => text().nullable()();
  BoolColumn get debitEnabled => boolean().withDefault(const Constant(true))();
  TextColumn get debitProvider => text().nullable()();
  TextColumn get debitMerchantId => text().nullable()();
  TextColumn get debitInstruction => text().nullable()();
  BoolColumn get transferEnabled =>
      boolean().withDefault(const Constant(true))();
  TextColumn get transferBankName => text().nullable()();
  TextColumn get transferAccountNumber => text().nullable()();
  TextColumn get transferAccountName => text().nullable()();
  TextColumn get transferInstruction => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Categories,
    Products,
    Roles,
    Permissions,
    RolePermissions,
    Users,
    Customers,
    CashSessions,
    Orders,
    OrderItems,
    Payments,
    SyncQueue,
    AppSettings,
    DeviceSettings,
    CashierSettings,
    PaymentSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(products, products.imagePath);
      }
      if (from < 3) {
        await migrator.createTable(appSettings);
      }
      if (from < 4) {
        await migrator.createTable(deviceSettings);
      }
      if (from < 5) {
        await migrator.createTable(cashierSettings);
      }
      if (from < 6) {
        await migrator.createTable(paymentSettings);
      }
      if (from < 7) {
        await migrator.addColumn(
          paymentSettings,
          paymentSettings.qrisImagePath,
        );
      }
      if (from < 8) {
        await migrator.createTable(customers);
        await migrator.addColumn(orders, orders.customerId);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final appDir = await getApplicationDocumentsDirectory();
    final file = File(p.join(appDir.path, 'patali_pos.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
