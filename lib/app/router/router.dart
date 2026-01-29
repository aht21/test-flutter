import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_application/app/features/features.dart';
import 'package:flutter_application/di/di.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final routeObserver = RouteObserver<PageRoute>();

final router = GoRouter(
  observers: [
    TalkerRouteObserver(talker),
    routeObserver,
  ],
  debugLogDiagnostics: true,
  initialLocation: '/login',
  navigatorKey: _rootNavigationKey,
  routes: [
    GoRoute(
      path: '/login',
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: '/registration',
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        child: const SignUpScreen(),
      ),
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: '/favorites',
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        child: const FavoritesScreen(),
      ),
    ),
    GoRoute(
      path: '/content/:id',
      pageBuilder: (_, state) {
        final id = state.pathParameters['id']!;
        return MaterialPage(
          key: state.pageKey,
          child: ContentScreen(id: int.parse(id)),
        );
      },
    ),
  ],
);
