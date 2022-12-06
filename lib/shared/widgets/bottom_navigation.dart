import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:mangadex/shared/constants/feather_icons.dart';
import 'package:mangadex/shared/constants/route_paths.dart';
import 'package:mangadex/shared/models/app_navigation_item.dart';
import 'package:mangadex/shared/widgets/bottom_bar.dart';

class BottomNavigation extends StatelessWidget {
  static const int homeView = 0;
  static const int libraryView = 1;

  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = _buildItems(context);

    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white12, width: 1))),
      child: BottomBar(
          items: tabs
              .map((e) => e.bottomNavigationBarItem)
              .toList(growable: false),
          currentIndex: _locationToTabIndex(GoRouter.of(context).location, tabs),
          onTap: (index) => GoRouter.of(context).go(tabs[index].location)),
    );
  }

  List<AppNavigationItem> _buildItems(BuildContext context) {
    return [
      AppNavigationItem(
          icon: const Icon(FeatherIcons.home),
          location: RoutePaths.home,
          activeIcon: const Icon(FeatherIcons.home_filled),
          label: AppLocalizations.of(context)!.home),
      AppNavigationItem(
          icon: const Icon(FeatherIcons.book),
          location: RoutePaths.library,
          activeIcon: const Icon(FeatherIcons.book),
          label: AppLocalizations.of(context)!.library),
    ];
  }

  int _locationToTabIndex(String location, List<AppNavigationItem> tabs) {
    final index =
        tabs.indexWhere((t) => location.startsWith(t.location));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }
}
