import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mangadex/locator.dart';
import 'package:mangadex/shared/constants/route_paths.dart';

String getRouterKey(String route) {
  return 'key_$route';
}

extension PumpApp on WidgetTester {
  /// Load an localized application with the router of the application.
  /// Will start the router with [initialRoute] if precised.
  /// Please note that nothing is mocked by using this function.
  Future<void> pumpRouterApp(
    Widget widget, {
    String locale = 'en',
  }) {
    const initialRoute = '/_initial';

    final router = GoRouter(initialLocation: initialRoute, routes: [
      GoRoute(
        path: initialRoute,
        builder: (context, state) => widget,
      ),
      ...RoutePaths.paths
          .map((path) => GoRoute(
              path: path,
              builder: (_, __) => Container(
                    key: Key(getRouterKey(path)),
                  )))
          .toList(growable: false)
    ]);

    return pumpWidget(MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(locale),
    ));
  }

  /// Pump a localized widget without a router
  Future<void> pumpLocalizedWidget(
      {required Widget child,
      bool useScaffold = true,
      String locale = 'en',
      double textScaleFactor = 0.9}) {
    return pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(locale),
      home: useScaffold ? Scaffold(body: child) : child,
    ));
  }
}

/// Unregister the service [T] from GetIt
void unregister<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

void registerLazySingleton<T extends Object>(T service) {
  unregister<T>();

  locator.registerLazySingleton<T>(() => service);
}
