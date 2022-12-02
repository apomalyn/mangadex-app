import 'package:get_it/get_it.dart';
import 'package:mangadex/shared/services/mangadex_api.dart';

GetIt locator = GetIt.instance;

void registerLocator() {
  locator.registerLazySingleton(() => MangaDexApi());
}
