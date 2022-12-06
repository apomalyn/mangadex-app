import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mangadex/router.dart';
import 'package:mangadex/shared/constants/app_theme.dart';
import 'package:mangadex/shared/widgets/app_config.dart';

class MangaDexApp extends StatelessWidget {
  const MangaDexApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final titleSuffix = AppConfig.of(context).environment != Environment.prod
        ? AppConfig.of(context).environment.name.toUpperCase()
        : '';
    return MaterialApp.router(
      onGenerateTitle: (context) =>
          '${AppLocalizations.of(context)!.app_name}$titleSuffix',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
