import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/domain/models_daryo/recommendation/recommendation.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/dashboard/recommendation_item.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/dashboard/recommendation/rec_item.dart';

class AdviceItem extends StatelessWidget {
  const AdviceItem({super.key, required this.recommendation, this.showDate = false});

  final Common recommendation;
  final bool showDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEDF1F3),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        spacing: 8,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(recommendation.category)
                      .s(12)
                      .c(context.colors.primary),
                ),
                const SizedBox(height: 6),
                Text(
                  recommendation.title,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ).s(12).w(500),
                if (showDate) ...[
                  const SizedBox(height: 6),
                  Row(
                    spacing: 6,
                    children: [
                      Assets.imagesDaryo.calendar.svg(
                          height: 12,
                          colorFilter: ColorFilter.mode(
                              Color(0xFF6C7278), BlendMode.srcIn)),
                      Text(formatDate(recommendation.date))
                          .s(12)
                          .c(context.textSecondary)
                    ],
                  )
                ],
              ],
            ),
          ),
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              color: context.colors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chevron_right,
              color: Colors.white,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}

