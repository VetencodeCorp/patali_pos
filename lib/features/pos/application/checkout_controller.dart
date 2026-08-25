import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/repositories/app_settings_repository.dart';
import '../../../data/repositories/cash_session_repository.dart';
import '../../../data/repositories/cashier_settings_repository.dart';
import '../../../data/repositories/order_repository.dart';
import '../../../data/repositories/payment_settings_repository.dart';
import '../../../data/repositories/promo_repository.dart';
import 'cart_controller.dart';

final checkoutControllerProvider =
    AsyncNotifierProvider<CheckoutController, void>(CheckoutController.new);

class CheckoutController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<Order> checkout({required String paymentMethod}) async {
    final cartItems = ref.read(cartControllerProvider);
    final subtotal = cartItems.subtotal;
    final manualDiscount = ref.read(cartDiscountProvider).clamp(0, subtotal);
    final promoId = ref.read(selectedPromoIdProvider);
    final promo = promoId == null
        ? null
        : await ref.read(promoRepositoryProvider).getPromoById(promoId);
    final promoDiscount = calculatePromoDiscount(
      promo,
      subtotal - manualDiscount,
    );
    final discountTotal = (manualDiscount + promoDiscount).clamp(0, subtotal);
    final settings = await ref
        .read(appSettingsRepositoryProvider)
        .getSettings();
    final cashierSettings = await ref
        .read(cashierSettingsRepositoryProvider)
        .getSettings();
    final paymentSettings = await ref
        .read(paymentSettingsRepositoryProvider)
        .getSettings();
    final safePaymentMethod =
        activePaymentMethods(paymentSettings).contains(paymentMethod)
        ? paymentMethod
        : 'cash';
    final taxableAmount = subtotal - discountTotal;
    final taxTotal = settings.taxEnabled
        ? (taxableAmount * settings.taxRate / 100).round()
        : 0;
    final serviceTotal = settings.serviceEnabled
        ? (taxableAmount * settings.serviceRate / 100).round()
        : 0;
    final grandTotal = taxableAmount + taxTotal + serviceTotal;
    final orderType = ref.read(selectedOrderTypeProvider);
    final customerId = ref.read(selectedCustomerIdProvider);
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
          customerId: customerId,
          orderType: orderType,
          paymentMethod: safePaymentMethod,
          invoicePrefix: cashierSettings.invoicePrefix,
          resetInvoiceDaily: cashierSettings.resetInvoiceDaily,
          subtotal: subtotal,
          manualDiscountTotal: manualDiscount,
          discountTotal: discountTotal,
          promoName: promoDiscount > 0 ? promo?.name : null,
          taxTotal: taxTotal + serviceTotal,
          grandTotal: grandTotal,
        );

    ref.read(cartControllerProvider.notifier).clear();
    ref.read(cartDiscountProvider.notifier).state = 0;
    ref.read(selectedPromoIdProvider.notifier).state = null;
    ref.read(cashTenderedProvider.notifier).state = null;
    ref.read(selectedPaymentMethodProvider.notifier).state =
        cashierSettings.defaultPaymentMethod;
    ref.read(selectedOrderTypeProvider.notifier).state =
        cashierSettings.defaultOrderType;
    ref.read(selectedCustomerIdProvider.notifier).state = null;
    return order;
  }
}
