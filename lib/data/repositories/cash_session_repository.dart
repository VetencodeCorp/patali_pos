import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';

const devOwnerRoleId = 'role-owner';
const devOwnerUserId = 'user-owner';

final cashSessionRepositoryProvider = Provider<CashSessionRepository>((ref) {
  return CashSessionRepository(ref.watch(appDatabaseProvider));
});

final activeCashSessionProvider = StreamProvider<CashSession?>((ref) {
  return ref.watch(cashSessionRepositoryProvider).watchActiveSession();
});

class CashSessionRepository {
  CashSessionRepository(this._database);

  final AppDatabase _database;
  final Uuid _uuid = const Uuid();

  Stream<CashSession?> watchActiveSession() {
    final query = _database.select(_database.cashSessions)
      ..where((session) => session.status.equals('open'))
      ..orderBy([(session) => OrderingTerm.desc(session.openedAt)])
      ..limit(1);

    return query.watchSingleOrNull();
  }

  Future<CashSession> openSession({required int openingCash}) async {
    final activeSession =
        await (_database.select(_database.cashSessions)
              ..where((session) => session.status.equals('open'))
              ..limit(1))
            .getSingleOrNull();
    if (activeSession != null) return activeSession;

    await _ensureDevOwner();

    final sessionId = _uuid.v4();
    await _database
        .into(_database.cashSessions)
        .insert(
          CashSessionsCompanion.insert(
            id: sessionId,
            openedByUserId: devOwnerUserId,
            openedAt: DateTime.now(),
            openingCash: Value(openingCash),
          ),
        );

    return (_database.select(
      _database.cashSessions,
    )..where((session) => session.id.equals(sessionId))).getSingle();
  }

  Future<void> closeSession({
    required String sessionId,
    required int closingCash,
  }) async {
    await _ensureDevOwner();
    final session = await (_database.select(
      _database.cashSessions,
    )..where((cashSession) => cashSession.id.equals(sessionId))).getSingle();
    final orders = await (_database.select(
      _database.orders,
    )..where((order) => order.cashSessionId.equals(sessionId))).get();
    final orderIds = orders.map((order) => order.id).toList();
    final cashPayments = orderIds.isEmpty
        ? <Payment>[]
        : await (_database.select(_database.payments)..where((payment) {
                return payment.method.equals('cash') &
                    payment.orderId.isIn(orderIds);
              }))
              .get();
    final cashSales = cashPayments.fold<int>(
      0,
      (total, payment) => total + payment.amount,
    );
    final expectedCash = session.openingCash + cashSales;

    await (_database.update(
      _database.cashSessions,
    )..where((session) => session.id.equals(sessionId))).write(
      CashSessionsCompanion(
        closedByUserId: const Value(devOwnerUserId),
        closedAt: Value(DateTime.now()),
        closingCash: Value(closingCash),
        expectedCash: Value(expectedCash),
        status: const Value('closed'),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> _ensureDevOwner() async {
    await _database
        .into(_database.roles)
        .insert(
          RolesCompanion.insert(
            id: devOwnerRoleId,
            name: 'Owner',
            code: 'owner',
            description: const Value('Development owner role'),
          ),
          mode: InsertMode.insertOrIgnore,
        );

    await _database
        .into(_database.users)
        .insert(
          UsersCompanion.insert(
            id: devOwnerUserId,
            roleId: const Value(devOwnerRoleId),
            name: 'Owner Demo',
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }
}
