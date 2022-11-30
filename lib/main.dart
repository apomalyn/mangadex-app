import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mangadex/locator.dart';
import 'package:mangadex/router.dart';
import 'package:mangadex/shared/constant/app_theme.dart';

void main() {
  registerLocator();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MangaDexApp());
}

class MangaDexApp extends StatelessWidget {
  const MangaDexApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.app_name,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
