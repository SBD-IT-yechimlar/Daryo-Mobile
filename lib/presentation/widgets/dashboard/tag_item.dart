import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';

import '../../../domain/models_daryo/tags/tag.dart';

import 'package:shimmer/shimmer.dart';

import '../../support/colors/static_colors.dart';

class TagItem extends StatelessWidget {
  const TagItem({super.key, required this.tag});

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Color(0xFFDFF1FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text("#${tag.title}").s(16).w(500).c(context.colors.primary),
    );
  }
}

class TagItemShimmer extends StatelessWidget {
  const TagItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF1FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Shimmer.fromColors(
        baseColor: context.shimmerBaseColor,
       highlightColor: context.shimmerHighLightColor,
        child: Container(
          height: 18,
          width: 80, // can be adjusted for variety if needed
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
