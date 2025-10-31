import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_application/app/features/features.dart';
import 'package:flutter_application/di/di.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  observers: [TalkerRouteObserver(talker)],
  debugLogDiagnostics: true,
  initialLocation: '/home',
  navigatorKey: _rootNavigationKey,
  routes: [
    GoRoute(
      path: '/home',
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        child: const HomeScreen(),
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
