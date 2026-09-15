import 'package:daryo/presentation/widgets/dashboard/recommendation/rec_item.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models_daryo/recommendation/recommendation.dart';

class DashboardCommonList extends StatelessWidget {
  final List<dynamic> recommendations;
  final Function(Common item) onItemClicked;

  const DashboardCommonList({
    super.key,
    required this.recommendations,
    required this.onItemClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(recommendations.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: CommonItem(
            recommendation: recommendations[index],
            onItemClicked: onItemClicked,
          ),
        );
      }),
    );
  }
}
