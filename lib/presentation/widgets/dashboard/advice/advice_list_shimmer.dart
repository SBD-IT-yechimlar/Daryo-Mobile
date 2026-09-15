import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../support/colors/static_colors.dart';

class AdviceListShimmer extends StatelessWidget {
  const AdviceListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(2, (index) {
        return const Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: AdviceItemShimmer(),
        );
      }),
    );
  }
}

class AdviceItemShimmer extends StatelessWidget {
  const AdviceItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: StaticColors.shimmerBaseColor,
      highlightColor: StaticColors.shimmerHighLightColor,
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
