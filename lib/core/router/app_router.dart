import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/dev_login_screen.dart';
import '../../features/orders/presentation/order_history_screen.dart';
import '../../features/orders/presentation/receipt_screen.dart';
import '../../features/pos/presentation/pos_screen.dart';
import '../../features/reports/presentation/reports_screen.dart';
import '../../features/reports/presentation/sales_summary_screen.dart';
import '../../features/settings/presentation/category_management_screen.dart';
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
      path: ReceiptScreen.routePath,
      builder: (context, state) {
        return ReceiptScreen(orderId: state.pathParameters['orderId']!);
      },
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
      path: ReportsScreen.routePath,
      builder: (context, state) => const ReportsScreen(),
    ),
    GoRoute(
      path: SalesSummaryScreen.routePath,
      builder: (context, state) => const SalesSummaryScreen(),
    ),
  ],
);
