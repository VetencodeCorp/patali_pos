import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/cash_session_repository.dart';

final cashSessionControllerProvider =
    AsyncNotifierProvider<CashSessionController, void>(
      CashSessionController.new,
    );

class CashSessionController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> openSession({required int openingCash}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(cashSessionRepositoryProvider)
          .openSession(openingCash: openingCash);
    });
  }

  Future<void> closeSession({
    required String sessionId,
    required int closingCash,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref
          .read(cashSessionRepositoryProvider)
          .closeSession(sessionId: sessionId, closingCash: closingCash);
    });
  }
}
