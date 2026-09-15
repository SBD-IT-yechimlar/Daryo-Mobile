import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/gen/assets/assets.gen.dart';
import '../../../../domain/models_daryo/recommendation/recommendation.dart';
import '../recommendation/rec_item.dart';

class AdviceList extends StatelessWidget {
  final List<Common> recommendations;
  final Function(Common item) onItemClicked;


  const AdviceList({
    super.key,
    required this.recommendations,
    required this.onItemClicked,
  });

  @override
  Widget build(BuildContext context) {
    int length=(recommendations.length>2)?2:recommendations.length;
    return Column(
      children: List.generate((length), (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: AdviceItem(
            recommendation: recommendations[index],
            onItemClicked: onItemClicked,
          ),
        );
      }),
    );
  }
}


class AdviceItem extends StatelessWidget {
  const AdviceItem({super.key, required this.recommendation,required this.onItemClicked, this.showDate = false});

  final Common recommendation;
  final Function(Common item) onItemClicked;

  final bool showDate;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: context.containerBackground,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: (){
          onItemClicked(recommendation);
          HapticFeedback.lightImpact();
        },
        child: Container(
          decoration: BoxDecoration(
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
                        color: context.backgroundColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                      child: Text(recommendation.category)
                          .s(12)
                          .w(400)
                          .c(context.colors.primary),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      recommendation.title,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ).s(14).w(500),
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
        ),
      ),
    );
  }
}
