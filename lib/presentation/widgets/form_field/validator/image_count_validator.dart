import 'package:flutter/material.dart';
import 'package:daryo/core/gen/localization/strings.dart';

class ImageCountValidator {
  static String? validate(int? value, int minAmount, GlobalKey globalKey) {
    if (value == null || value <= 0) {
      Scrollable.ensureVisible(
        globalKey.currentContext!,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut,
      );
      return Strings.commonErrorFieldIsRequired;
    } else if (value < minAmount) {
      Scrollable.ensureVisible(
        globalKey.currentContext!,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut,
      );
      return Strings.adCreationImageMinCountError;
    }

    return null;
  }
}
