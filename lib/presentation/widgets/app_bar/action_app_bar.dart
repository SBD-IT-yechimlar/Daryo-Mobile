import 'package:flutter/material.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';

class ActionAppBar extends AppBar implements PreferredSizeWidget {
  final String titleText;
  final VoidCallback onBackPressed;
  @override
  final List<Widget>? actions;
  @override
  final Color backgroundColor;
  final Color titleTextColor;
  final Color iconColor;

  ActionAppBar({
    super.key,
    required this.titleText,
    required this.titleTextColor,
    required this.backgroundColor,
    required this.onBackPressed,
    required this.iconColor,
    this.actions,
  }) : super(
          backgroundColor: backgroundColor,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 64,
          title: titleText.w(700).s(16).c(titleTextColor),
          leading: IconButton(
            onPressed: onBackPressed,
            icon: Assets.imagesv2.icExitArrow.svg(color: iconColor),
          ),
          actions: actions,
        );
}
