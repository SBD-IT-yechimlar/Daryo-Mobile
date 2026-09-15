import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';

class DefaultAppBar extends AppBar implements PreferredSizeWidget {
  final String titleText;
  final Color titleTextColor;
  @override
  final Color backgroundColor;
  final VoidCallback onBackPressed;
  final Widget? titleWidget;
  final BuildContext context;

  DefaultAppBar({
    super.key,
    required this.titleText,
    required this.titleTextColor,
    required this.backgroundColor,
    required this.onBackPressed,
    this.titleWidget,
    required this.context,
  }) : super(
          backgroundColor: backgroundColor,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: titleWidget ?? Text(titleText).w(700).s(16).c(titleTextColor),
          leading: IconButton(
            onPressed: onBackPressed,
            icon: Assets.imagesDaryo.back.svg(colorFilter: ColorFilter.mode(context.iconPrimary, BlendMode.srcIn)),
          ),
        );
}
