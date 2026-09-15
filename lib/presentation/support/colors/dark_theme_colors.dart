import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/colors/theme_colors.dart';

@lazySingleton
class DarkThemeColors extends ThemeColors {
  @override
  Color get backgroundColor => StaticColors.darkBackground;

  @override
  Color get primary => StaticColors.colorPrimary;

  @override
  Color get onPrimary => StaticColors.white;

  @override
  Color get textPrimary => StaticColors.darkTextPrimary;

  @override
  Color get textAccent => StaticColors.dodgerBlue;

  @override
  Color get textSecondary => StaticColors.darkTextSecondary;

  @override
  Color get textTertiary => StaticColors.darkTextUnSelect;

  @override
  Color get textPrimaryInverse => StaticColors.darkTextSelect;

  @override
  Color get borderColor => StaticColors.darkBorder;

  @override
  Color get buttonPrimary => StaticColors.buttonColor;

  @override
  Color get adStatusBackground => StaticColors.bondiBlue;

  @override
  Color get adPropertyBusinessBackground => StaticColors.business;

  @override
  Color get adPropertyPersonalBackground => StaticColors.manatee;

  @override
  Color get inputBackground => Color(0x80F6F7FC);//Color(0xFF333333);

  @override
  Color get iconPrimary => StaticColors.iconPrimaryDark;

  @override
  Color get iconSecondary => StaticColors.iconSecondary;

  @override
  Color get buttonActiveBackground => StaticColors.darkButtonActiveBackground;

  @override
  Color get buttonActiveBorder => StaticColors.darkButtonActiveBorder;

  @override
  Color get buttonInactiveBackground => StaticColors.darkButtonInactiveBackground;

  @override
  Color get buttonInactiveBorder => StaticColors.darkButtonInactiveBorder;

  @override
  Color get containerBackground => StaticColors.darkContainerBackground;

  @override
  Color get greenColor => StaticColors.greenColor;

  @override
  Color get iconColor => StaticColors.darkIconColor;

  @override
  Color get black => StaticColors.black;

  @override
  Color get bottomBarColor => StaticColors.darkBottomBarColor;

}
