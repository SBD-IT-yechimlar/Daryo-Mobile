import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../support/colors/static_colors.dart';

class CommonItemShimmer extends StatelessWidget {
  const CommonItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
       baseColor: context.shimmerBaseColor,
       highlightColor: context.shimmerHighLightColor,
      child: SizedBox(
        height: 80,
        child: Row(
          children: [
            Container(
              width: 110,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(width: 10),
            // 📄 Text placeholders
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title placeholder
                  Container(
                    height: 14,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 8),
                    color: Colors.white,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 14,
                    width:  double.infinity,
                   // MediaQuery.of(context).size.width * 0.6,
                    color: Colors.white,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        height: 12,
                        width: 60,
                        color: Colors.white,
                      ),
                      const Spacer(),
                      Container(
                        height: 12,
                        width: 80,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
