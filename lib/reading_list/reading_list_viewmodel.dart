import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

class ReadingListViewModel extends BaseViewModel {
  final AppLocalizations appLocalizations;
  final GoRouter router;

  final Map<String, bool> _lists = {};
  
  List<String> get listTitles => _lists.keys.toList(growable: false);
  List<bool> get activeLists => _lists.values.toList(growable: false);

  ReadingListViewModel({required this.appLocalizations, required this.router}) {
    _lists.addAll({
      appLocalizations.manga_status_reading: true,
      appLocalizations.manga_status_plan_to_read: false,
      appLocalizations.manga_status_completed: false,
      appLocalizations.manga_status_on_hold: false,
      appLocalizations.manga_status_dropped: false,
    });
  }

  void onListTogglePress(int index) {
    String pressedKey = listTitles[index];

    _lists.updateAll((key, value) => pressedKey == key ? !value:false);

    if(!_lists.containsValue(true)) {
      _lists.update(pressedKey, (value) => true);
    }
    notifyListeners();
  }
}
