import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/models_daryo/daryo_fm/darto_fm_item.dart';
import '../../support/colors/static_colors.dart';

class RecommendationShimmerWidget extends StatelessWidget {
  const RecommendationShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Container(
          height: 64.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: context.isDarkMode? Color(0xFF1F2937): Color(0xFFEDF1F3),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: context.isDarkMode?  StaticColors.darkBackground:context.shimmerBaseColor,
                        highlightColor: context.isDarkMode?  StaticColors.darkBackground:context.shimmerHighLightColor,
                        child: Container(
                          width: 200.w,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Shimmer.fromColors(
                        baseColor: context.isDarkMode?  StaticColors.darkBackground:context.shimmerBaseColor,
                        highlightColor: context.isDarkMode?  StaticColors.darkBackground:context.shimmerHighLightColor,
                        child: Container(
                          width: 80.w,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  )),
                  SizedBox(width: 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
