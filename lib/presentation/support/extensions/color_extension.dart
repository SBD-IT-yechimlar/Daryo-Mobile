import 'package:daryo/presentation/support/colors/dark_theme_colors.dart';
import 'package:daryo/presentation/support/colors/light_theme_colors.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/colors/theme_colors.dart';
import 'package:flutter/material.dart';

extension ColorExtension on BuildContext {
  ThemeColors get colors => isDarkMode ? DarkThemeColors() : LightThemeColors();

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Brightness get brightness => Theme.of(this).brightness;

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get backgroundGreyColor => isDarkMode ? Color(0xFF121212) : Color(0xFFF2F4FB);

  Color get backgroundWhiteColor => colors.backgroundColor;

  // Color get bottomSheetColor => Theme.of(this).colorScheme.surface;
  Color get bottomSheetColor => isDarkMode ? Color(0xFF121212) : Color(0xFFF2F4FB);

  Color get bottomNavigationColor => Theme.of(this).colorScheme.background;

  // Color get appBarColor => Theme.of(this).colorScheme.secondary;
  Color get appBarColor => isDarkMode ? Color(0xFF424242) : Color(0xFFFFFFFF);

  Color get elevatedColor => isDarkMode ? Color(0xFF333333) : Color(0xFFFFFFFF);

  Color get bottomBarColor => colors.bottomBarColor;

  Color get cardColor => isDarkMode ? Color(0xFF374151) : Color(0xFFFFFFFF);

  Color get cardStrokeColor => Theme.of(this).cardColor;

  Color get backgroundColor => colors.backgroundColor;

  Color get primary => colors.primary;

  Color get black => colors.black;

  Color get textPrimary => colors.textPrimary;

  Color get textSecondary => colors.textSecondary;

  Color get textTertiary => colors.textTertiary;

  Color get textPrimaryInverse => colors.textPrimaryInverse;

  Color get inputBackgroundColor => isDarkMode ? Color(0x80333131) : Color(0xFFFFFFFF);

  Color get inputStrokeActiveColor => colors.buttonPrimary;

  Color get inputStrokeInactiveColor => colors.borderColor;

  Color get borderColor => colors.borderColor;

  Color get iconPrimary => colors.iconPrimary;

  Color get iconSecondary => colors.iconSecondary;

  Color get brownClickColor => StaticColors.brownClickColor;

  Color get redClickColor => StaticColors.redClickColor;

  Color get greenColor => colors.greenColor;

  Color get buttonGreenColor => StaticColors.buttonGreenColor;

  Color get buttonPrimary => colors.buttonPrimary;

  Color get buttonActiveBackground => colors.buttonActiveBackground;

  Color get buttonActiveBorder => colors.buttonActiveBorder;

  Color get buttonInactiveBackground => colors.buttonInactiveBackground;

  Color get buttonInactiveBorder => colors.buttonInactiveBorder;

  Color get containerBackground => colors.containerBackground;

  Color get iconColor => colors.iconColor;

  Color get shimmerBaseColor => isDarkMode ? Color(0xFF1F2937) : StaticColors.shimmerBaseColor;
  Color get shimmerHighLightColor => isDarkMode ? Color(0xFF1F2937).withOpacity(0.6) : StaticColors.shimmerHighLightColor;

}
