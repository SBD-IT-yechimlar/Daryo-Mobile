import 'package:flutter/material.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double buttonWidth;
  final double buttonHeight;
  final bool isLoading;
  final bool isEnabled;
  final Color textColor;
  final Color? disableTextColor;
  final double textSize;
  final Color? backgroundColor;
  final Widget? leftIcon;
  final Widget? rightIcon;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonWidth = double.infinity,
    this.buttonHeight = 48,
    this.isEnabled = true,
    this.isLoading = false,
    this.textColor = Colors.white,
    this.disableTextColor,
    this.textSize = 14,
    this.backgroundColor,
    this.leftIcon,
    this.rightIcon,
  }) : super(key: key);

  bool isClickedRecently(DateTime? lastClickTime) {
    if (lastClickTime == null) return false;
    var now = DateTime.now();
    return (lastClickTime.difference(now).inMilliseconds) > -1000;
  }

  @override
  Widget build(BuildContext context) {
    DateTime? clickTime;

    final onButtonPressed = isEnabled
        ? () {
            if (isLoading) {
              return;
            } else if (isClickedRecently(clickTime)) {
              return;
            } else {
              clickTime = DateTime.now();
              onPressed?.call();
            }
          }
        : null;

    var actualTextColor = isEnabled ? textColor : disableTextColor??context.textSecondary;
    var backcolor = backgroundColor ?? context.colors.buttonPrimary;
    var actualBackgroundColor = isEnabled ? backcolor : backcolor;
    var actualTextAlign = rightIcon != null ? TextAlign.left : TextAlign.center;

    final hasIcon = leftIcon != null || rightIcon != null;

    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onButtonPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: context.inputStrokeInactiveColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: actualBackgroundColor,
          disabledBackgroundColor: actualBackgroundColor.withOpacity(0.5),
          elevation: 0,
        ),
        child: SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leftIcon != null) ...[
                  SizedBox(width: 4),
                  SizedBox(width: 20, height: 20, child: leftIcon),
                  SizedBox(width: 8),
                ],
                text.w(500).s(textSize).c(actualTextColor).copyWith(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                if (rightIcon != null) ...[
                  SizedBox(width: 8),
                  SizedBox(width: 20, height: 20, child: rightIcon),
                  SizedBox(width: 4),
                ],
                if (isLoading) ...[
                  SizedBox(width: 8),
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
