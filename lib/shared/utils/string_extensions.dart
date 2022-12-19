import 'package:flag/flag.dart';

extension StringExtension on String {
  String capitalize() {
    if (length < 2) {
      return toUpperCase();
    }
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  FlagsCode toFlagCode() {
    switch (substring(0, 2).toLowerCase()) {
      case 'ja':
        return FlagsCode.JP;
      case 'zh':
        return FlagsCode.CN;
      default:
        throw TypeError();
    }
  }
}
