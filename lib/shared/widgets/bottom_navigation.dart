import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mangadex/shared/constants/feather_icons.dart';
import 'package:mangadex/shared/widgets/bottom_bar.dart';

class BottomNavigation extends StatelessWidget {
  static const int homeView = 0;
  static const int libraryView = 1;

  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) => Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white12, width: 1))),
      child: BottomBar(items: _buildItems(context), currentIndex: 1));

  List<BottomNavigationBarItem> _buildItems(BuildContext context) {
    return [
      BottomNavigationBarItem(
          icon: const Icon(FeatherIcons.home),
          activeIcon: const Icon(FeatherIcons.home),
          label: AppLocalizations.of(context)!.home),
      BottomNavigationBarItem(
          icon: const Icon(FeatherIcons.book),
          activeIcon: const Icon(FeatherIcons.book),
          label: AppLocalizations.of(context)!.library),
    ];
  }
}
