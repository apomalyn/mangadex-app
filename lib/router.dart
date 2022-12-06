import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mangadex/login/login_view.dart';
import 'package:mangadex/shared/constants/route_paths.dart';
import 'package:mangadex/shared/widgets/bottom_navigation.dart';
import 'package:mangadex/shared/widgets/transitions/fade_transition_page.dart';
import 'package:mangadex/startup/startup_view.dart';

// GoRouter configuration
final router = GoRouter(
  errorBuilder: (context, state) => const Scaffold(
    body: Center(child: Text("Page not found")),
  ),
  initialLocation: RoutePaths.startup,
  routes: [
    GoRoute(path: RoutePaths.startup, builder: (_, __) => const StartupView()),
    GoRoute(
        path: RoutePaths.login,
        pageBuilder: (_, state) =>
            FadeTransitionPage(key: state.pageKey, child: const LoginView()),
        builder: (context, state) => const LoginView()),
    GoRoute(
      path: RoutePaths.home,
      pageBuilder: (_, state) => FadeTransitionPage(
          key: state.pageKey,
          child: const Scaffold(
            body: Center(child: Text("Home")),
            bottomNavigationBar: BottomNavigation(),
          )),
      builder: (context, state) => const Scaffold(
        body: Center(child: Text("Home")),
      ),
    ),
  ],
);
