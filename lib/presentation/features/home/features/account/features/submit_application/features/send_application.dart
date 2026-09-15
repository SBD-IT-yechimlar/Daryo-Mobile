import 'package:auto_route/annotations.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/localization/strings.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/gen/assets/assets.gen.dart';


class SendApplication extends StatelessWidget {
  const SendApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: context.backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.imagesDaryo.icSendApplicationTickCircle.svg(),
            SizedBox(height: 24),
            Strings.sendAplicatonTitle
                .s(24)
                .w(600)
                .c(context.textPrimary)
                .copyWith(overflow: TextOverflow.clip, textAlign: TextAlign.center, softWrap: true),
            SizedBox(height: 10),
            Strings.sendAplicatonDesc
                .s(14)
                .w(400)
                .c(context.textSecondary)
                .copyWith(overflow: TextOverflow.clip, textAlign: TextAlign.center, softWrap: true),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
        //  Navigator.pop(context);
        },
        child: Container(
          height: 48,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(color: context.greenColor, borderRadius: BorderRadius.circular(10)),
          width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.symmetric(horizontal: 24),
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Center(child:  Strings.mainPage.s(14).w(500).c(StaticColors.white)),
        ),
      ),
    );
  }
}
