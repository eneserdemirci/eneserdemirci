import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_simulation_game/core/theme/app_theme.dart';
import 'package:life_simulation_game/features/authentication/presentation/providers/auth_provider.dart';
import 'package:life_simulation_game/features/authentication/presentation/widgets/auth_form.dart';

/// Login page for authentication
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // App Logo and Title
              const Icon(
                Icons.emoji_people,
                size: 80,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 16),
              Text(
                'Life Simulation',
                style: context.textTheme.headlineLarge?.copyWith(
                  color: AppTheme.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Live your virtual life',
                style: context.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              
              // Auth Form
              const AuthForm(),
              
              const SizedBox(height: 24),
              
              // Mode Toggle
              Consumer(
                builder: (context, ref, child) {
                  final authState = ref.watch(authControllerProvider);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        authState.isSignUpMode
                            ? 'Already have an account? '
                            : 'Don\'t have an account? ',
                        style: context.textTheme.bodyMedium,
                      ),
                      GestureDetector(
                        onTap: () {
                          ref.read(authControllerProvider.notifier).toggleMode();
                        },
                        child: Text(
                          authState.isSignUpMode ? 'Sign In' : 'Sign Up',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}