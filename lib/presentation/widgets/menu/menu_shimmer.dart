import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../support/colors/static_colors.dart';
import '../divider/custom_divider.dart';

class MenuShimmer extends StatelessWidget {
  const MenuShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 8,
      separatorBuilder: (_, __) => Container(
        height: 1,
        width: double.infinity,
        color: context.isDarkMode? Color(0xFF374151):Color(0xFFEFF0F6),
      ),
      itemBuilder: (context, index) {
        return SizedBox(
          height: 30.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Shimmer.fromColors(
                    baseColor: context.shimmerBaseColor,
                    highlightColor: context.shimmerHighLightColor,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      width: 150.w,
                    ),
                  ),
                ),
              ),
            //  CustomDivider(color: context.isDarkMode? Color(0xFF374151): Colors.white,thickness: 1,),
            ],
          ),
        );
      },
    );
  }
}
