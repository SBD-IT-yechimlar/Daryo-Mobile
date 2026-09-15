import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../domain/models_daryo/recommendation/recommendation.dart';
import '../../../widgets/image/rounded_cached_network_image_widget.dart';
import '../../html/custom_html.dart';
import 'package:html/parser.dart' as html_parser;

String formatDate(String dateTimeString) {
  try {
    final dateTime = DateTime.parse(dateTimeString);
    return DateFormat('MMM d, yyyy').format(dateTime);
  } catch (e) {
    return '';
  }
}

class CommonItem extends StatelessWidget {
  const CommonItem({
    super.key,
    required this.recommendation,
    required this.onItemClicked,
    this.queryMask,
  });

  final String? queryMask;
  final Common recommendation;
  final Function(Common item) onItemClicked;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClicked(recommendation);
        HapticFeedback.lightImpact();
      },
      child: Container(
        color: context.backgroundColor,
        constraints: const BoxConstraints(minHeight: 80),
        child: IntrinsicHeight(
          child: Row(
          children: [
            RoundedCachedNetworkImage(
              imageId: recommendation.img,
              width: 110,
              borderRadius: 16,
            ),
            const SizedBox(width: 10),
            Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   /* Text(
                      recommendation.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ).s(14).w(500).c(context.textPrimary),*/
                     Text(
                       stripHtml(recommendation.title),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ).s(14).w(500).c(context.textPrimary),
                  //  Spacer(),

                    Row(
                      children: [
                        Expanded(
                          child: Text(recommendation.category)
                              .s(12)
                              .w(500)
                              .c(context.colors.primary),
                        ),
                        Text(formatDate(recommendation.date))
                            .s(12)
                            .w(400)
                            .c(const Color(0xFF6C7278)),
                      ],
                    ),
                  ],
                ),
              ),),
          ],
        ),
        ),
      ),
    );
  }


  String stripHtml(String htmlText) {
    final document = html_parser.parse(htmlText);
    return document.body?.text ?? '';
  }

  /// Highlights [queryMask] inside [title]
  Widget _buildTitle(BuildContext context, String title) {
    if (queryMask == null || queryMask!.isEmpty) {
      return Text(title, maxLines: 3,overflow: TextOverflow.ellipsis,).s(14).w(500);
    }

    final lowerTitle = title.toLowerCase();
    final lowerQuery = queryMask!.toLowerCase();
    final matchIndex = lowerTitle.indexOf(lowerQuery);

    if (matchIndex == -1) {
      return Text(title, maxLines: 3,overflow: TextOverflow.ellipsis).s(14).w(500);
    }

    final before = title.substring(0, matchIndex);
    final match = title.substring(matchIndex, matchIndex + queryMask!.length);
    final after = title.substring(matchIndex + queryMask!.length);

    return RichText(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: before,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: match,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700, // Bolder
              color: context.colors.primary, // Highlight color
              backgroundColor: context.colors.primary.withOpacity(0.1), // Mask
            ),
          ),
          TextSpan(
            text: after,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
