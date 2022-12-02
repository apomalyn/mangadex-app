import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const String _fontFamily = 'Spartan';

  static const Color orange = Color(0xffe6613e);
  static const Color darkGrey = Color(0xff191a1c);
  static const Color slate = Color(0xff121318);

  static ThemeData lightTheme() {
    final ThemeData theme = ThemeData.light();

    return theme.copyWith(
        backgroundColor: Colors.white,
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
        progressIndicatorTheme:
            theme.progressIndicatorTheme.copyWith(color: Colors.black87));
  }

  static ThemeData darkTheme() {
    final ThemeData theme = ThemeData.dark();

    return theme.copyWith(
        backgroundColor: darkGrey,
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
        progressIndicatorTheme:
            theme.progressIndicatorTheme.copyWith(color: Colors.white));
  }

  static ThemeData slateTheme() {
    final ThemeData theme = ThemeData.dark();

    return theme.copyWith(
        backgroundColor: slate,
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
        progressIndicatorTheme:
            theme.progressIndicatorTheme.copyWith(color: Colors.white));
  }
}
