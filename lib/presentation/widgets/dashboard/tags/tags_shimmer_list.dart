import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../support/colors/static_colors.dart';

class TagsShimmer extends StatelessWidget {
  const TagsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(8, (index) => const TagItemShimmer()),
    );
  }
}

class TagItemShimmer extends StatelessWidget {
  const TagItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.shimmerBaseColor,
      highlightColor: context.shimmerHighLightColor,
      child: Container(
        width: 80.h,
        height: 30.h,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
