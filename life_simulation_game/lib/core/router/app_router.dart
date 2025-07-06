import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:life_simulation_game/features/authentication/presentation/pages/login_page.dart';
import 'package:life_simulation_game/features/character/presentation/pages/character_creation_page.dart';
import 'package:life_simulation_game/features/character/presentation/pages/character_details_page.dart';
import 'package:life_simulation_game/features/game_mechanics/presentation/pages/game_dashboard_page.dart';
import 'package:life_simulation_game/features/life_events/presentation/pages/life_events_page.dart';
import 'package:life_simulation_game/features/statistics/presentation/pages/statistics_page.dart';
import 'package:life_simulation_game/features/authentication/presentation/providers/auth_provider.dart';

/// Application routing configuration using GoRouter
class AppRouter {
  static const String login = '/login';
  static const String characterCreation = '/character-creation';
  static const String dashboard = '/dashboard';
  static const String characterDetails = '/character-details';
  static const String lifeEvents = '/life-events';
  static const String statistics = '/statistics';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter createRouter(WidgetRef ref) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: login,
      redirect: (context, state) {
        final authState = ref.read(authStateProvider);
        final isLoggedIn = authState.hasValue && authState.value != null;
        final isLoggingIn = state.subloc == login;

        // If not logged in and not on login page, redirect to login
        if (!isLoggedIn && !isLoggingIn) {
          return login;
        }

        // If logged in and on login page, redirect to dashboard
        if (isLoggedIn && isLoggingIn) {
          return dashboard;
        }

        // No redirect needed
        return null;
      },
      routes: [
        // Authentication routes
        GoRoute(
          path: login,
          builder: (context, state) => const LoginPage(),
        ),
        
        // Character creation route
        GoRoute(
          path: characterCreation,
          builder: (context, state) => const CharacterCreationPage(),
        ),

        // Main app shell with bottom navigation
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return MainShell(child: child);
          },
          routes: [
            // Dashboard
            GoRoute(
              path: dashboard,
              builder: (context, state) => const GameDashboardPage(),
            ),
            
            // Character details
            GoRoute(
              path: characterDetails,
              builder: (context, state) => const CharacterDetailsPage(),
            ),
            
            // Life events
            GoRoute(
              path: lifeEvents,
              builder: (context, state) => const LifeEventsPage(),
            ),
            
            // Statistics
            GoRoute(
              path: statistics,
              builder: (context, state) => const StatisticsPage(),
            ),
          ],
        ),
      ],
    );
  }
}

/// Main shell widget with bottom navigation
class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _getCurrentIndex(context),
        onTap: (index) => _onItemTapped(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Character',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Life Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).location;
    switch (location) {
      case AppRouter.dashboard:
        return 0;
      case AppRouter.characterDetails:
        return 1;
      case AppRouter.lifeEvents:
        return 2;
      case AppRouter.statistics:
        return 3;
      default:
        return 0;
    }
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRouter.dashboard);
        break;
      case 1:
        context.go(AppRouter.characterDetails);
        break;
      case 2:
        context.go(AppRouter.lifeEvents);
        break;
      case 3:
        context.go(AppRouter.statistics);
        break;
    }
  }
}

/// Router provider
final appRouterProvider = Provider<GoRouter>((ref) {
  return AppRouter.createRouter(ref);
});