import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/domain/models_daryo/recommendation/recommendation.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../router/app_router.dart';
import '../../image/rounded_cached_network_image_widget.dart';
import '../recommendation/rec_item.dart';

//
// class HotNewsGrid extends StatelessWidget {
//   const HotNewsGrid({
//     super.key,
//     required this.crossAxisCount,
//     required this.data,
//   });
//
//   final int crossAxisCount;
//   final List<Recommendation> data;
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: crossAxisCount,
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 16,
//         mainAxisExtent: crossAxisCount == 1 ? 80 : 190,
//         // childAspectRatio: crossAxisCount == 1 ? 3.5 : 0.75,
//       ),
//       itemCount: data.length,
//       itemBuilder: (context, index) {
//         return HotNewsItem(
//           recommendation: data[index],
//           isGrid: crossAxisCount == 2,
//         );
//       },
//     );
//   }
// }
//
// class HotNewsItem extends StatelessWidget {
//   const HotNewsItem({
//     super.key,
//     required this.recommendation,
//     required this.isGrid,
//   });
//
//   final Recommendation recommendation;
//   final bool isGrid;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         HapticFeedback.lightImpact();
//       },
//       child: isGrid
//           ? _buildVerticalLayout(context)
//           : _buildHorizontalLayout(context),
//     );
//   }
//
//   Widget _buildHorizontalLayout(BuildContext context) {
//     return Row(
//       children: [
//         RoundedCachedNetworkImage(
//           imageId: recommendation.img,
//           width: 120,
//           height: 90,
//           borderRadius: 16,
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   recommendation.title,
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                 ).s(14).w(500),
//                 const Spacer(),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(recommendation.category)
//                           .s(12)
//                           .w(500)
//                           .c(context.colors.primary),
//                     ),
//                     Text(formatDate(recommendation.date))
//                         .s(12)
//                         .w(400)
//                         .c(const Color(0xFF6C7278)),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildVerticalLayout(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RoundedCachedNetworkImage(
//           imageId: recommendation.img,
//           height: 96,
//           width: double.infinity,
//           borderRadius: 16,
//         ),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   recommendation.title,
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                 ).s(14).w(500),
//                 const Spacer(),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(recommendation.category)
//                           .s(12)
//                           .w(500)
//                           .c(context.colors.primary),
//                     ),
//                     Text(formatDate(recommendation.date))
//                         .s(12)
//                         .w(400)
//                         .c(const Color(0xFF6C7278)),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/domain/models_daryo/recommendation/recommendation.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../image/rounded_cached_network_image_widget.dart';
import '../recommendation/rec_item.dart';

class HotNewsGrid extends StatelessWidget {
  const HotNewsGrid({
    super.key,
    required this.crossAxisCount,
    required this.data,
  });

  final int crossAxisCount;
  final List<Common> data;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: animation, child: child),
      ),
      child: crossAxisCount == 1
          ? _buildList()
          : _buildGrid(),
    );
  }

  Widget _buildList() {
    return Column(
      key: const ValueKey(1),
      children: [
        for (int i = 0; i < data.length; i++) ...[
          if (i > 0) const SizedBox(height: 16),
          HotNewsItem(
            recommendation: data[i],
            isGrid: false,
          ),
        ],
      ],
    );
  }

  Widget _buildGrid() {
    return Column(
      key: const ValueKey(2),
      children: [
        for (int i = 0; i < data.length; i += 2) ...[
          if (i > 0) const SizedBox(height: 16),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: HotNewsItem(
                    recommendation: data[i],
                    isGrid: true,
                  ),
                ),
                const SizedBox(width: 16),
                if (i + 1 < data.length)
                  Expanded(
                    child: HotNewsItem(
                      recommendation: data[i + 1],
                      isGrid: true,
                    ),
                  )
                else
                  const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class HotNewsItem extends StatelessWidget {
  const HotNewsItem({
    super.key,
    required this.recommendation,
    required this.isGrid,
  });

  final Common recommendation;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(ContentDetailRoute(slug: recommendation.slug));
        HapticFeedback.lightImpact();
      },
      child: isGrid
          ? _buildVerticalLayout(context)
          : _buildHorizontalLayout(context),
    );
  }

  Widget _buildHorizontalLayout(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 80),
      child: IntrinsicHeight(
        child: Row(
          children: [
            RoundedCachedNetworkImage(
              imageId: recommendation.img,
              width: 120,
              borderRadius: 16,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recommendation.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ).s(14).w(500),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(recommendation.category)
                              .s(12)
                              .w(500)
                              .c(context.colors.primary),
                        ),
                        Text(formatDate(recommendation.date))
                            .s(12)
                            .w(400)
                            .c(context.textSecondary)

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RoundedCachedNetworkImage(
          imageId: recommendation.img,
          height: 96,
          width: double.infinity,
          borderRadius: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recommendation.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ).s(14).w(500),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(recommendation.category)
                        .s(12)
                        .w(500)
                        .c(context.colors.primary).copyWith(maxLines: 1,overflow: TextOverflow.ellipsis),
                  ),
                  Text(formatDate(recommendation.date))
                      .s(12)
                      .w(400)
                      .c(context.textSecondary),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
