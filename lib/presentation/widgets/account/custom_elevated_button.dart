import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double buttonWidth;
  final double buttonHeight;
  final bool isLoading;
  final bool isEnabled;
  final Color textColor;
  final double textSize;
  final int weight;
  final Color? backgroundColor;
  final Widget? leftIcon;
  final Widget? rightIcon;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonWidth = double.infinity,
    this.buttonHeight = 55,
    this.isEnabled = true,
    this.isLoading = false,
    this.textColor = Colors.white,
    this.textSize = 16,
    this.weight = 500,
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

    var actualTextColor = isEnabled ? textColor : textColor.withOpacity(0.75);
    var backcolor = backgroundColor ?? context.colors.buttonPrimary;
    var actualBackgroundColor = isEnabled ? backcolor : backcolor.withOpacity(0.75);
    var actualTextAlign = rightIcon != null ? TextAlign.left : TextAlign.center;

    final hasIcon = leftIcon != null || rightIcon != null;

    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onButtonPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: actualBackgroundColor,
          disabledBackgroundColor: actualBackgroundColor.withAlpha(100),
          elevation: 0,
        ),
        child: SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: Row(
            children: [
              Visibility(
                visible: hasIcon,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: leftIcon,
                ),
              ),
              Visibility(
                visible: hasIcon,
                child: SizedBox(width: 12),
              ),
              Expanded(
                child: text.w(weight).s(textSize).c(actualTextColor).copyWith(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: actualTextAlign,
                    ),
              ),
              Visibility(visible: isLoading, child: SizedBox(width: 12)),
              Visibility(
                visible: isLoading,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1.5,
                    strokeAlign: 0.5,
                  ),
                ),
              ),
              Visibility(
                visible: hasIcon,
                child: SizedBox(width: 12),
              ),
              Visibility(
                visible: hasIcon,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: rightIcon,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
