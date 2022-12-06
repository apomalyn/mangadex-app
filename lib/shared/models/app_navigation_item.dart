import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_navigation_item.freezed.dart';

@freezed
class AppNavigationItem with _$AppNavigationItem {
  const AppNavigationItem._();

  const factory AppNavigationItem(
      {required Widget icon,
      required String location,
      String? label,
      Widget? activeIcon,
      Color? backgroundColor,
      String? tooltip}) = _AppNavigationItem;

  BottomNavigationBarItem get bottomNavigationBarItem =>
      BottomNavigationBarItem(
          icon: icon,
          activeIcon: activeIcon,
          label: label,
          backgroundColor: backgroundColor,
          tooltip: tooltip);
}
