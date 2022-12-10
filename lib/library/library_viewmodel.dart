import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

class LibraryViewModel extends IndexTrackingViewModel {
  final AppLocalizations appLocalizations;
  final GoRouter router;

  late TabController _tabController;
  TabController? get tabController => _tabController;
  final List<Tab> tabs = [];

  LibraryViewModel({required this.appLocalizations, required this.router}) {
    tabs.addAll([
      Tab(text: appLocalizations.library_reading_list),
      Tab(text: appLocalizations.library_history),
      Tab(text: appLocalizations.library_offline),
    ]);
  }

  void initState(TickerProvider vsync) {
    _tabController = TabController(length: tabs.length, vsync: vsync);
    tabController!.addListener(() {
      print('Current Tab Index: ${tabController!.index}');
    });
  }
}
