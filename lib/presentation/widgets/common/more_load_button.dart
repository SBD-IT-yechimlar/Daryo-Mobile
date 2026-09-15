import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/gen/assets/assets.gen.dart';

class LoadMoreButton extends StatelessWidget {
  final VoidCallback onLoadMore;

  const LoadMoreButton({
    Key? key,
    required this.onLoadMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Material(
      color: StaticColors.lightButtonActiveBackground,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: (){
          onLoadMore();
          HapticFeedback.lightImpact();
        },
        child: Container(
          height: 40.h,
          width: 175.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.imagesv2.icMore.svg(),
                SizedBox(width: 10),
                "Ko'proq ko'rish".s(14).w(500).c(context.primary)
              ],),
          ),
        ),
      ),
    );
  }
}