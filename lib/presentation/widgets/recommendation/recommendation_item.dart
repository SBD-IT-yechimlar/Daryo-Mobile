import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart' as html_parser;

import '../../../domain/models_daryo/recommendation/reccommendation.dart';

class RecommendationWidget extends StatelessWidget {
  final Function(RecommendationModel item) onItemClicked;
  final RecommendationModel item;

  const RecommendationWidget({
    required this.onItemClicked,
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        color: context.containerBackground,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            HapticFeedback.lightImpact();
            onItemClicked(item);
          },
          child: Container(
            height: 64.h,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
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

                       // item.title.s(14).w(500).copyWith(maxLines: 3, overflow: TextOverflow.ellipsis).c(context.textPrimary),
                        Text(
                          stripHtml(item.title),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ).s(14).w(500).c(context.textPrimary).copyWith(maxLines: 3, overflow: TextOverflow.ellipsis),
                        SizedBox(height: 5),
                      ],
                    )),
                    SizedBox(width: 5),
                    Material(
                      shape: const CircleBorder(),
                      // borderRadius:BorderRadius.circular(6),
                      color: Color(0xFF0089DA),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.h),
                        onTap: () {
                          HapticFeedback.lightImpact();

                          HapticFeedback.mediumImpact();
                        },
                        child: Container(
                          width: 25.h,
                          height: 25.h,
                          decoration: BoxDecoration(
                              //   borderRadius:BorderRadius.circular(6),
                              ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Assets.imagesv2.icRecArrowRight.svg(),
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
      ),
    );
  }
  String stripHtml(String htmlText) {
    final document = html_parser.parse(htmlText);
    return document.body?.text ?? '';
  }

}
