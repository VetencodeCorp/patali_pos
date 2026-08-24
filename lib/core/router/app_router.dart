import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/dev_login_screen.dart';
import '../../features/customers/presentation/customer_form_screen.dart';
import '../../features/customers/presentation/customer_management_screen.dart';
import '../../features/kitchen/presentation/kitchen_display_screen.dart';
import '../../features/orders/presentation/order_history_screen.dart';
import '../../features/orders/presentation/receipt_screen.dart';
import '../../features/pos/presentation/pos_screen.dart';
import '../../features/reports/presentation/product_sales_screen.dart';
import '../../features/reports/presentation/reports_screen.dart';
import '../../features/reports/presentation/sales_summary_screen.dart';
import '../../features/settings/presentation/category_management_screen.dart';
import '../../features/settings/presentation/cashier_settings_screen.dart';
import '../../features/settings/presentation/device_settings_screen.dart';
import '../../features/settings/presentation/payment_settings_screen.dart';
import '../../features/settings/presentation/product_form_screen.dart';
import '../../features/settings/presentation/product_management_screen.dart';
import '../../features/settings/presentation/receipt_tax_settings_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: SplashScreen.routePath,
  routes: [
    GoRoute(
      path: SplashScreen.routePath,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: DevLoginScreen.routePath,
      builder: (context, state) => const DevLoginScreen(),
    ),
    GoRoute(
      path: PosScreen.routePath,
      builder: (context, state) => const PosScreen(),
    ),
    GoRoute(
      path: OrderHistoryScreen.routePath,
      builder: (context, state) => const OrderHistoryScreen(),
    ),
    GoRoute(
      path: CustomerManagementScreen.routePath,
      builder: (context, state) => const CustomerManagementScreen(),
    ),
    GoRoute(
      path: CustomerFormScreen.createRoutePath,
      builder: (context, state) => const CustomerFormScreen(),
    ),
    GoRoute(
      path: CustomerFormScreen.editRoutePath,
      builder: (context, state) {
        return CustomerFormScreen(
          customerId: state.pathParameters['customerId']!,
        );
      },
    ),
    GoRoute(
      path: ReceiptScreen.routePath,
      builder: (context, state) {
        return ReceiptScreen(orderId: state.pathParameters['orderId']!);
      },
    ),
    GoRoute(
      path: KitchenDisplayScreen.routePath,
      builder: (context, state) => const KitchenDisplayScreen(),
    ),
    GoRoute(
      path: SettingsScreen.routePath,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: ProductManagementScreen.routePath,
      builder: (context, state) => const ProductManagementScreen(),
    ),
    GoRoute(
      path: ProductFormScreen.createRoutePath,
      builder: (context, state) => const ProductFormScreen(),
    ),
    GoRoute(
      path: ProductFormScreen.editRoutePath,
      builder: (context, state) {
        return ProductFormScreen(productId: state.pathParameters['productId']!);
      },
    ),
    GoRoute(
      path: CategoryManagementScreen.routePath,
      builder: (context, state) => const CategoryManagementScreen(),
    ),
    GoRoute(
      path: ReceiptTaxSettingsScreen.routePath,
      builder: (context, state) => const ReceiptTaxSettingsScreen(),
    ),
    GoRoute(
      path: DeviceSettingsScreen.routePath,
      builder: (context, state) => const DeviceSettingsScreen(),
    ),
    GoRoute(
      path: CashierSettingsScreen.routePath,
      builder: (context, state) => const CashierSettingsScreen(),
    ),
    GoRoute(
      path: PaymentSettingsScreen.routePath,
      builder: (context, state) => const PaymentSettingsScreen(),
    ),
    GoRoute(
      path: ReportsScreen.routePath,
      builder: (context, state) => const ReportsScreen(),
    ),
    GoRoute(
      path: SalesSummaryScreen.routePath,
      builder: (context, state) => const SalesSummaryScreen(),
    ),
    GoRoute(
      path: ProductSalesScreen.routePath,
      builder: (context, state) => const ProductSalesScreen(),
    ),
  ],
);
