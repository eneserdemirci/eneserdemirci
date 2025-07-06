import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:life_simulation_game/core/router/app_router.dart';
import 'package:life_simulation_game/core/theme/app_theme.dart';
import 'package:life_simulation_game/features/character/domain/entities/character_entity.dart';
import 'package:life_simulation_game/features/character/presentation/widgets/character_creation_form.dart';
import 'package:life_simulation_game/features/authentication/presentation/providers/auth_provider.dart';

/// Character creation page
class CharacterCreationPage extends ConsumerWidget {
  const CharacterCreationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Character'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: AppTheme.onPrimary,
      ),
      body: authState.when(
        data: (user) {
          if (user == null) {
            // User not authenticated, redirect to login
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go(AppRouter.login);
            });
            return const Center(child: CircularProgressIndicator());
          }
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'Create Your Character',
                  style: context.textTheme.headlineLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Design your virtual person and start living your life simulation.',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),
                
                // Character Creation Form
                CharacterCreationForm(userId: user.id),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[400],
              ),
              const SizedBox(height: 16),
              Text(
                'Error loading user data',
                style: context.textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.red[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go(AppRouter.login),
                child: const Text('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}