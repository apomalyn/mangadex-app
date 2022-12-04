import 'package:flutter/material.dart';
import 'package:mangadex/locator.dart';
import 'package:mangadex/manga_dex_app.dart';
import 'package:mangadex/shared/widgets/app_config.dart';

void main() {
  registerLocator();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const AppConfig(environment: Environment.beta, child: MangaDexApp()));
}
