import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.actions,
  });

  final Widget icon;
  final String title;
  final String? subtitle;
  final Widget actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.containerBackground,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          SizedBox(height: 24),
          Text(
            title,
            textAlign: TextAlign.center,
          ).s(14).w(600).c(context.textPrimary),
          if (subtitle != null) ...[
            SizedBox(height: 8),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
            ).s(12).w(500).c(context.textSecondary),
          ],
          SizedBox(height: 24),
          actions
        ],
      ),
    );
  }
}
