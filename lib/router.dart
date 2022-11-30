import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mangadex/login/login_view.dart';
import 'package:mangadex/shared/constant/route_paths.dart';

// GoRouter configuration
final router = GoRouter(
  errorBuilder: (context, state) => const Scaffold(
    body: Center(child: Text("Page not found")),
  ),
  initialLocation: RoutePaths.startup,
  routes: [
    GoRoute(
      path: RoutePaths.home,
      builder: (context, state) => const Scaffold(
        body: Center(child: Text("Home")),
      ),
    ),
    GoRoute(
        path: RoutePaths.login, builder: (context, state) => const LoginView()),
    GoRoute(
        path: RoutePaths.startup,
        redirect: (context, state) => RoutePaths.login)
  ],
);
