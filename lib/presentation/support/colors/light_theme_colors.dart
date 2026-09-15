import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/colors/theme_colors.dart';

@lazySingleton
class LightThemeColors extends ThemeColors {
  @override
  Color get backgroundColor => StaticColors.backgroundColor;

  @override
  Color get primary => StaticColors.colorPrimary;

  @override
  Color get onPrimary => StaticColors.white;

  @override
  Color get textPrimary => StaticColors.lightTextPrimary;

  @override
  Color get textAccent => StaticColors.dodgerBlue;

  @override
  Color get textSecondary => StaticColors.textColorSecondary;

  @override
  Color get textTertiary => StaticColors.lightTextPrimary;

  @override
  Color get textPrimaryInverse => StaticColors.lightTextPrimary;

  @override
  Color get borderColor => StaticColors.lightBorder;

  @override
  Color get buttonPrimary => StaticColors.buttonColor;

  @override
  Color get adStatusBackground => StaticColors.bondiBlue;

  @override
  Color get adPropertyBusinessBackground => StaticColors.business;

  @override
  Color get adPropertyPersonalBackground => StaticColors.manatee;

  @override
  Color get inputBackground => Color(0xFFFBFAFF);

  @override
  Color get iconPrimary => StaticColors.iconPrimaryLight;

  @override
  Color get iconSecondary => StaticColors.iconSecondary;

  @override
  Color get buttonActiveBackground => StaticColors.lightButtonActiveBackground;

  @override
  Color get buttonActiveBorder => StaticColors.lightButtonActiveBorder;

  @override
  Color get buttonInactiveBackground => StaticColors.lightButtonInactiveBackground;

  @override
  Color get buttonInactiveBorder => StaticColors.lightButtonInactiveBorder;

  @override
  Color get containerBackground => StaticColors.lightContainerBackground;

  @override
  Color get greenColor => StaticColors.greenColor;

  @override
  Color get iconColor => StaticColors.lightIconColor;

  @override
  Color get black => StaticColors.black;

  @override
  Color get bottomBarColor => StaticColors.lightBottomBarColor;

}
