
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../../core/gen/localization/strings.dart';
import '../../support/colors/static_colors.dart';
import '../../widgets/button/custom_elevated_button.dart';

class FullScreenErrorWidget extends StatelessWidget {
  const FullScreenErrorWidget({
    super.key,
    required this.onItemClicked,
    this.hasDesc=false,
    this.descMessage="",
  });

  final Function onItemClicked;
  final bool hasDesc;
  final String descMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 40),
        SizedBox(height: 240, child: Assets.imagesv2.problemIcon.svg()),
        SizedBox(height: 20),
        Strings.errorNotIssue.s(24).w(600).c(context.textPrimary).copyWith(textAlign: TextAlign.center),
        SizedBox(height: 30),
        if(hasDesc)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: descMessage.s(14).w(400).c(StaticColors.textColorPrimary).copyWith(textAlign: TextAlign.center),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Strings.somethingWentWrong.s(14).w(400).c(Color(0xFF6C7278)).copyWith(textAlign: TextAlign.center),
          ),
        SizedBox(height: 30),
        Material(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: (){
              onItemClicked();
              HapticFeedback.lightImpact();
            },
            child: Container(
              height: 40.h,
             // width: 175.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.imagesv2.icMore.svg(),
                    SizedBox(width: 10),
                    Strings.commonRefresh.s(14).w(500).c(Color(0xFF0089DA))
                  ],),
              ),
            ),
          ),
        ),

      ],);
  }
}
