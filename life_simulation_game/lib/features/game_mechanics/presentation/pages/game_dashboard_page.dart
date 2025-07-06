import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:life_simulation_game/core/router/app_router.dart';
import 'package:life_simulation_game/core/theme/app_theme.dart';
import 'package:life_simulation_game/features/authentication/presentation/providers/auth_provider.dart';

/// Game dashboard page - main game interface
class GameDashboardPage extends ConsumerWidget {
  const GameDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Life Simulation'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: AppTheme.onPrimary,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                ref.read(authControllerProvider.notifier).signOut();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: authState.when(
        data: (user) {
          if (user == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go(AppRouter.login);
            });
            return const Center(child: CircularProgressIndicator());
          }
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome header
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back, ${user.displayName ?? user.email}!',
                          style: context.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ready to continue your life simulation?',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Character quick stats
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Character Overview',
                          style: context.textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _StatCard(
                              icon: Icons.favorite,
                              label: 'Health',
                              value: '85',
                              color: Colors.red,
                            ),
                            _StatCard(
                              icon: Icons.mood,
                              label: 'Happiness',
                              value: '72',
                              color: Colors.orange,
                            ),
                            _StatCard(
                              icon: Icons.attach_money,
                              label: 'Money',
                              value: '\$1,250',
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Quick actions
                Text(
                  'Quick Actions',
                  style: context.textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: const [
                    _ActionCard(
                      icon: Icons.work,
                      title: 'Work',
                      description: 'Go to work and earn money',
                      color: Colors.blue,
                    ),
                    _ActionCard(
                      icon: Icons.school,
                      title: 'Study',
                      description: 'Increase your intelligence',
                      color: Colors.purple,
                    ),
                    _ActionCard(
                      icon: Icons.fitness_center,
                      title: 'Exercise',
                      description: 'Improve your fitness',
                      color: Colors.green,
                    ),
                    _ActionCard(
                      icon: Icons.people,
                      title: 'Socialize',
                      description: 'Meet new people',
                      color: Colors.orange,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                
                // Recent events
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent Events',
                          style: context.textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        const _EventTile(
                          icon: Icons.cake,
                          title: 'Birthday Celebration',
                          description: 'You celebrated your birthday!',
                          time: '2 days ago',
                        ),
                        const _EventTile(
                          icon: Icons.school,
                          title: 'Graduated',
                          description: 'You completed your education',
                          time: '1 week ago',
                        ),
                        const _EventTile(
                          icon: Icons.work,
                          title: 'New Job',
                          description: 'Started working as a Software Engineer',
                          time: '2 weeks ago',
                        ),
                      ],
                    ),
                  ),
                ),
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
                'Error loading dashboard',
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
            ],
          ),
        ),
      ),
    );
  }
}

/// Stat card widget
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
          color: color,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: context.textTheme.headlineSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

/// Action card widget
class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          // TODO: Implement action
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title action will be implemented soon!'),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: context.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Event tile widget
class _EventTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String time;

  const _EventTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}