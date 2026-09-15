import 'package:another_flushbar/flushbar.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void showAppToast(BuildContext context, String message,
    {Color backgroundColor = Colors.red}) {
  Flushbar(
    margin: const EdgeInsets.all(12),
    borderRadius: BorderRadius.circular(12),
    backgroundColor: backgroundColor,
    duration: const Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
    icon: const Icon(Icons.info_outline, color: Colors.white, size: 24),
   messageText: message.s(14).w(400).c(Colors.white),
   // messageText: GlobalText(text: message, color: Colors.white, fontSize: 14),
  ).show(context);
}

void showAppErrorToast(BuildContext context, String message, {Color backgroundColor =const Color(0xFFD95445)}) {
  Flushbar(
    margin: const EdgeInsets.all(12),
    borderRadius: BorderRadius.circular(20),
    backgroundColor: backgroundColor,
    duration: const Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
   /* icon: SvgPicture.asset(
      AppIcons.danger,
      height: 24,
      width: 24,
    ),
    messageText: GlobalText(text: message, color: Colors.white, fontSize: 14),*/
  ).show(context);
}

void showAppSuccessToast(BuildContext context, String message, {Color backgroundColor =const Color(0xFF92B135)}) {
  Flushbar(
    margin: const EdgeInsets.all(12),
    borderRadius: BorderRadius.circular(20),
    backgroundColor: backgroundColor,
    duration: const Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
    /*icon: SvgPicture.asset(
      AppIcons.tickCircle,
      height: 24,
      width: 24,
    ),
    messageText: GlobalText(text: message, color: Colors.white, fontSize: 14),*/
  ).show(context);
}

void showAppSuccessToastV2(BuildContext context, String message, {Color backgroundColor =const Color(0xFF92B135)}) {
  Flushbar(
    margin: const EdgeInsets.all(12),
    borderRadius: BorderRadius.circular(12),
    backgroundColor: backgroundColor,
    duration: const Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
   // icon: const Icon(Icons.suc, color: Colors.white, size: 24),
    messageText: message.s(14).w(400).c(Colors.white),
    // messageText: GlobalText(text: message, color: Colors.white, fontSize: 14),
  ).show(context);
}