import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../feature/home/screen/home_screen.dart';
import '../../feature/chat/screen/chat_screen.dart';
import '../../feature/travel_plan/screen/create_plan_screen.dart';

import '../../feature/travel_plan/screen/plan_detail_screen.dart';
import '../../feature/route/screen/route_screen.dart';
import '../../feature/setting/screen/setting_screen.dart';
import '../../feature/onboarding/screen/onboarding_screen.dart';
import '../../feature/travel_plan/screen/travel_plan_screen.dart';
import '../widget/bottom_navigation_shell.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),

        ShellRoute(
          builder: (context, state, child) {
            return BottomNavigationShell(child: child);
          },
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeScreen(),
            ),

            GoRoute(
              path: '/chat',
              builder: (context, state) => const ChatScreen(),
            ),

            GoRoute(
              path: '/plans',
              builder: (context, state) => const TravelPlanScreen(),
            ),

            GoRoute(
              path: '/route',
              builder: (context, state) {
                final startLocation = state.uri.queryParameters['start'];
                final endLocation = state.uri.queryParameters['end'];
                return RouteScreen(
                  startLocation: startLocation,
                  endLocation: endLocation,
                );
              },
            ),

            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),

        GoRoute(
          path: '/create-plan',
          builder: (context, state) => const CreatePlanScreen(),
        ),

        GoRoute(
          path: '/plan/:planId',
          builder: (context, state) {
            final planId = state.pathParameters['planId']!;
            return PlanDetailScreen(planId: planId);
          },
          routes: [
            GoRoute(
              path: 'edit',
              builder: (context, state) {
                final planId = state.pathParameters['planId']!;
                return CreatePlanScreen(planId: planId);
              },
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text('Page not found: ${state.uri.path}'),
        ),
      ),
    );
  }
}