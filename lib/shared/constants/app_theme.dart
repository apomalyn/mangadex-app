import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const String _fontFamily = 'Spartan';

  static const Color orange = Color(0xffe6613e);
  static const Color white = Color(0xfffdfdfd);
  static const Color darkGrey = Color(0xff1a191c);
  static const Color slate = Color(0xff121318);

  static ThemeData lightTheme() {
    final ThemeData theme = ThemeData.light();

    return theme.copyWith(
        backgroundColor: white,
        scaffoldBackgroundColor: white,
        primaryTextTheme: theme.primaryTextTheme.apply(fontFamily: _fontFamily),
        primaryColor: orange,
        inputDecorationTheme: theme.inputDecorationTheme.copyWith(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: orange)),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent, width: 2.0)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent, width: 2.0)),
        ),
        bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
            backgroundColor: white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black),
        progressIndicatorTheme:
            theme.progressIndicatorTheme.copyWith(color: Colors.black87));
  }

  static ThemeData darkTheme() {
    final ThemeData theme = ThemeData.dark();

    return theme.copyWith(
        backgroundColor: darkGrey,
        scaffoldBackgroundColor: darkGrey,
        primaryTextTheme: theme.primaryTextTheme.apply(fontFamily: _fontFamily),
        primaryColor: orange,
        inputDecorationTheme: theme.inputDecorationTheme.copyWith(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: orange)),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent, width: 2.0)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent, width: 2.0)),
        ),
        bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
            backgroundColor: darkGrey,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white),
        progressIndicatorTheme:
            theme.progressIndicatorTheme.copyWith(color: Colors.white));
  }

  static ThemeData slateTheme() {
    final ThemeData theme = ThemeData.dark();

    return theme.copyWith(
        backgroundColor: slate,
        scaffoldBackgroundColor: slate,
        primaryTextTheme: theme.primaryTextTheme.apply(fontFamily: _fontFamily),
        primaryColor: orange,
        inputDecorationTheme: theme.inputDecorationTheme.copyWith(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: orange)),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent, width: 2.0)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent, width: 2.0)),
        ),
        bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
            backgroundColor: slate,
            selectedIconTheme: theme.bottomNavigationBarTheme.selectedIconTheme?.copyWith(color: white),
            unselectedIconTheme: theme.bottomNavigationBarTheme.unselectedIconTheme?.copyWith(color: white),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white),
        progressIndicatorTheme:
            theme.progressIndicatorTheme.copyWith(color: Colors.white));
  }
}
