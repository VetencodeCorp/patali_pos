import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/dev_login_screen.dart';
import '../../features/orders/presentation/order_history_screen.dart';
import '../../features/pos/presentation/pos_screen.dart';
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
      path: SettingsScreen.routePath,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
