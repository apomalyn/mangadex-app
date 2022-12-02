import 'package:go_router/go_router.dart';
import 'package:mangadex/locator.dart';
import 'package:mangadex/shared/constant/route_paths.dart';
import 'package:mangadex/shared/services/mangadex_api.dart';
import 'package:stacked/stacked.dart';

class StartupViewModel extends BaseViewModel {
  final MangaDexApi _api = locator<MangaDexApi>();

  final GoRouter router;

  StartupViewModel({required this.router});

  Future<void> handleStartup() async {
    final silentLoginSuccess = await _api.silentLogin();

    router.go(silentLoginSuccess ? RoutePaths.home : RoutePaths.login);
  }
}
