import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/gen/assets/assets.gen.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.isSelected,
      required this.icon});

  final String text;
  final Function() onPressed;
  final bool isSelected;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final activeColor =
        isSelected ? context.buttonActiveBorder : context.buttonInactiveBorder;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? context.buttonActiveBackground : context.buttonInactiveBackground,
          border: Border.all(color: activeColor),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: icon,
              ),
            ),
            SizedBox(width: 16),
            text.w(isSelected ? 800 : 400).s(16).c(isSelected?context.textPrimaryInverse:context.textTertiary),
            Spacer(),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: activeColor),
                color: isSelected ? activeColor : Colors.transparent,
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
