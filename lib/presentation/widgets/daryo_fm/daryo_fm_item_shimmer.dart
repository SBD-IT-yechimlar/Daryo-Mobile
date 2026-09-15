import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/models_daryo/daryo_fm/darto_fm_item.dart';
import '../../support/colors/static_colors.dart';

class DaryoFmShimmerWidget extends StatelessWidget {
  const DaryoFmShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Container(
          height: 64.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: context.isDarkMode? Color(0xFF1F2937):Colors.white,
              border: Border.all(color: context.isDarkMode?Color(0xFF374151):Color(0xFFEFF0F6))),
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
                        baseColor:context.isDarkMode? StaticColors.darkBackground.withOpacity(0.7): context.shimmerBaseColor,
                        highlightColor: context.isDarkMode?  StaticColors.darkBackground.withOpacity(0.7):context.shimmerHighLightColor,
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
                        baseColor:context.isDarkMode? StaticColors.darkBackground.withOpacity(0.7): context.shimmerBaseColor,
                        highlightColor: context.isDarkMode?  StaticColors.darkBackground.withOpacity(0.7):context.shimmerHighLightColor,
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
                  Material(
                    borderRadius: BorderRadius.circular(6),
                    color: Color(0xFFDFF1FF),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(6),
                      onTap: () {
                        HapticFeedback.mediumImpact();
                      },
                      child: Container(
                        width: 25.h,
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Assets.imagesv2.icPlay.svg(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String formatDateTime(String dateTimeStr) {
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      final formatted = '${dateTime.year.toString().padLeft(4, '0')}-'
          '${dateTime.month.toString().padLeft(2, '0')}-'
          '${dateTime.day.toString().padLeft(2, '0')} '
          '${dateTime.hour.toString().padLeft(2, '0')}:'
          '${dateTime.minute.toString().padLeft(2, '0')}';
      return formatted;
    } catch (e) {
      return ''; // Agar format noto‘g‘ri bo‘lsa
    }
  }
}
