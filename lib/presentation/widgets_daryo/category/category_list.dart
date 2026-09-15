import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:daryo/domain/models_daryo/category/category.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import '../../widgets/menu/custom_expandale_tile.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  final List<Category> categories;
  final void Function(Category category) onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return Container(
       color: Colors.transparent,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: categories.length,
        separatorBuilder: (_, __) => Container(
          height: 1,
          width: double.infinity,
          color: context.borderColor,
        ),
        itemBuilder: (context, index) {
          final category = categories[index];
          return _CategoryTile(
            category: category,
            onTap: onCategoryTap,
          );
        },
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.category,
    required this.onTap,
  });

  final Category category;
  final void Function(Category category) onTap;

  @override
  Widget build(BuildContext context) {
    final hasChildren = category.children.isNotEmpty;

    return Theme(
      data: Theme.of(context).copyWith(
        visualDensity: VisualDensity.compact,
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: CustomExpandableTile(
        category: category,
        onTap: (category) {
          onTap(category);
        },
      ),
    );
  }
}


///

