import 'package:daryo/core/extensions/text_extensions.dart';

import 'package:daryo/core/gen/localization/strings.dart';

class PhoneNumberValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.commonErrorFieldIsRequired;
    }

    final clearedValue = value.clearPhoneNumber();
    if (clearedValue.length != 13) {
      return Strings.commonErrorPhoneNotValid;
    }

    return null;
  }
}
