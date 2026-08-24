import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/repositories/app_settings_repository.dart';
import '../../../data/repositories/cash_session_repository.dart';
import '../../../data/repositories/order_repository.dart';
import 'cart_controller.dart';

final checkoutControllerProvider =
    AsyncNotifierProvider<CheckoutController, void>(CheckoutController.new);

class CheckoutController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<Order> checkout({required String paymentMethod}) async {
    final cartItems = ref.read(cartControllerProvider);
    final subtotal = cartItems.subtotal;
    final discountTotal = ref.read(cartDiscountProvider).clamp(0, subtotal);
    final settings = await ref
        .read(appSettingsRepositoryProvider)
        .getSettings();
    final taxableAmount = subtotal - discountTotal;
    final taxTotal = settings.taxEnabled
        ? (taxableAmount * settings.taxRate / 100).round()
        : 0;
    final serviceTotal = settings.serviceEnabled
        ? (taxableAmount * settings.serviceRate / 100).round()
        : 0;
    final grandTotal = taxableAmount + taxTotal + serviceTotal;
    final orderType = ref.read(selectedOrderTypeProvider);
    final cashSession = await ref.read(activeCashSessionProvider.future);
    if (cashSession == null) {
      throw StateError('Kasir belum dibuka');
    }

    final order = await ref
        .read(orderRepositoryProvider)
        .createCashOrder(
          items: [
            for (final item in cartItems)
              CreateOrderItem(
                productId: item.product.id,
                productName: item.product.name,
                qty: item.qty,
                unitPrice: item.product.price,
                lineTotal: item.lineTotal,
              ),
          ],
          cashSessionId: cashSession.id,
          orderType: orderType,
          paymentMethod: paymentMethod,
          subtotal: subtotal,
          discountTotal: discountTotal,
          taxTotal: taxTotal + serviceTotal,
          grandTotal: grandTotal,
        );

    ref.read(cartControllerProvider.notifier).clear();
    ref.read(cartDiscountProvider.notifier).state = 0;
    ref.read(selectedPaymentMethodProvider.notifier).state = 'cash';
    ref.read(selectedOrderTypeProvider.notifier).state = 'Bungkus';
    return order;
  }
}
