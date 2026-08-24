import 'package:flutter/material.dart';

import '../router/app_router.dart';
import '../theme/app_theme.dart';

class PataliApp extends StatelessWidget {
  const PataliApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Patali POS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      routerConfig: appRouter,
    );
  }
}
