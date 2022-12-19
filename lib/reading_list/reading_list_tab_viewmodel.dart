import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:mangadex/locator.dart';
import 'package:mangadex/shared/models/enums.dart';
import 'package:mangadex/shared/models/manga.dart';
import 'package:mangadex/shared/models/utils/pair.dart';
import 'package:mangadex/shared/repositories/manga_repository.dart';
import 'package:mangadex/shared/repositories/reading_list_repository.dart';
import 'package:stacked/stacked.dart';

class ReadingListTabViewModel extends FutureViewModel {
  final _repository = locator<ReadingListRepository>();
  final _mangaRepository = locator<MangaRepository>();
  final AppLocalizations appLocalizations;
  final GoRouter router;

  final Map<ReadingListType, Pair<String, bool>> _lists = {};

  List<String> get listTitles =>
      _lists.values.map((e) => e.first).toList(growable: false);

  List<bool> get activeLists =>
      _lists.values.map((e) => e.second).toList(growable: false);

  List<Manga> _mangas = [];

  List<Manga> get mangas => _mangas;

  ReadingListTabViewModel(
      {required this.appLocalizations, required this.router}) {
    _lists.addAll({
      ReadingListType.reading:
          Pair(appLocalizations.manga_status_reading, true),
      ReadingListType.planToRead:
          Pair(appLocalizations.manga_status_plan_to_read, false),
      ReadingListType.completed:
          Pair(appLocalizations.manga_status_completed, false),
      ReadingListType.onHold:
          Pair(appLocalizations.manga_status_on_hold, false),
      ReadingListType.dropped:
          Pair(appLocalizations.manga_status_dropped, false),
    });
  }

  Future<void> onListTogglePress(int index) async {
    final pressedList = _lists.keys.elementAt(index);

    _lists.updateAll((key, value) => pressedList == key
        ? value.copyWith(second: !value.second)
        : value.copyWith(second: false));

    try {
      _lists.values.singleWhere((element) => element.second == true);
    } on Error catch (_) {
      _lists.update(pressedList, (value) => value.copyWith(second: true));
      return;
    }

    setBusy(true);
    final selectedList = _lists.keys.elementAt(activeLists.indexOf(true));

    _mangas = await _repository.getReadingList(selectedList);

    setBusy(false);
  }

  Future<void> refreshList() async {
    setBusy(true);
    final selectedList = _lists.keys.elementAt(activeLists.indexOf(true));

    _mangas = await _repository.getReadingList(selectedList, true);

    setBusy(false);
  }

  @override
  Future<void> futureToRun() {
    final selectedList = _lists.keys.elementAt(activeLists.indexOf(true));

    return _repository.getReadingList(selectedList, true).then((value) {
      _mangas = value;
    });
  }

  String getMangaCoverUrl(int index) =>
      _mangaRepository.getCoverUrl(_mangas[index], CoverSize.small);
}
