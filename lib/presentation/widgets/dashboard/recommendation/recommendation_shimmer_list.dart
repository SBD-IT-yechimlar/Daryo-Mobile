import 'package:daryo/presentation/widgets/dashboard/recommendation/rec_item_shimmer.dart';
import 'package:flutter/material.dart';

import '../../../widgets/dashboard/recommendation_item.dart';

class DashboardCommonListShimmer extends StatelessWidget {
  final int itemCount;

  const DashboardCommonListShimmer({
    super.key,
    this.itemCount = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(itemCount, (index) {
        return const Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: CommonItemShimmer(),
        );
      }),
    );
  }
}
