import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:mangadex/shared/repositories/manga_repository.dart';
import 'package:mangadex/shared/repositories/reading_list_repository.dart';
import 'package:mangadex/shared/services/mangadex_api.dart';

GetIt locator = GetIt.instance;

void registerLocator() {
  locator.registerLazySingleton(() => Logger());
  locator.registerLazySingleton(() => MangaDexApi());
  locator.registerLazySingleton(() => MangaRepository());
  locator.registerLazySingleton(() => ReadingListRepository());
}
