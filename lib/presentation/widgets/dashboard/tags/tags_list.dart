
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../domain/models_daryo/tags/tag.dart';

class TagsList extends StatelessWidget {
  final List<Tag> tags;
  final Function(Tag item) onItemClicked;


  const TagsList({
    super.key,
    required this.tags,
    required this.onItemClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // gorizontal oraliq
      runSpacing: 8.0, // vertikal oraliq
      children: List.generate(
        tags.length,
            (index) => TagItem(tag: tags[index], onItemClicked:onItemClicked),
      ),
    );
  }
}

class TagItem extends StatelessWidget {
  final Tag tag;
  final Function(Tag item) onItemClicked;


  const TagItem({super.key, required this.tag,required this.onItemClicked});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: StaticColors.lightButtonActiveBackground,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: (){
          onItemClicked(tag);
          HapticFeedback.lightImpact();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              "#${tag.title}",
              style: TextStyle(
                color: context.primary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
