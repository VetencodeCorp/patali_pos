import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../pos/presentation/pos_screen.dart';

class DevLoginScreen extends StatelessWidget {
  const DevLoginScreen({super.key});

  static const routePath = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(
                Icons.hub,
                size: 56,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Patali POS',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Mode development',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: () => context.go(PosScreen.routePath),
                icon: const Icon(Icons.login),
                label: const Text('Masuk sebagai Owner'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
