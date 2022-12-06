import 'package:go_router/go_router.dart';
import 'package:mangadex/locator.dart';
import 'package:mangadex/shared/constants/route_paths.dart';
import 'package:mangadex/shared/services/mangadex_api.dart';
import 'package:mangadex/shared/utils/exceptions/unauthorized_exception.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginViewModel extends BaseViewModel {
  final MangaDexApi _api = locator<MangaDexApi>();

  final AppLocalizations appLocalizations;

  final GoRouter router;

  String _username = "";

  String get username => _username;

  String _password = "";

  String get password => _password;

  bool get canSubmit => _username.isNotEmpty && _password.isNotEmpty;

  LoginViewModel({required this.appLocalizations, required this.router});

  Future<String> authenticate() async {
    // Should not happened
    if (!canSubmit) {
      return '';
    }

    setBusy(true);
    try {
      await _api.login(password: _password, username: _username);
    } on UnauthorizedException {
      setBusy(false);
      return appLocalizations.login_invalid_credentials;
    }

    router.go(RoutePaths.home);
    setBusy(false);
    return '';
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      _username = "";
      return appLocalizations.login_enter_username;
    }
    _username = value;
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      _password = "";
      return appLocalizations.login_enter_password;
    }
    _password = value;
    return null;
  }
}
