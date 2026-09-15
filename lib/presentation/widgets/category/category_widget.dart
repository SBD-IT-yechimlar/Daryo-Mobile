import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/domain/models/category/category_list_item.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/image/rounded_cached_network_image_widget.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.onClicked,
    required this.category,
    this.isShowCount = true,
    this.loadingState,
  });

  final Function(CategoryListItem category) onClicked;
  final CategoryListItem category;
  final bool isShowCount;
  final LoadingState? loadingState;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          if (category.isParent) {
            onClicked(category);
          } else {
            onClicked(category);
          }
          HapticFeedback.lightImpact();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 16,
                      top: category.hasIcon ? 16 : 20,
                      right: 16,
                      bottom: category.hasIcon ? 16 : 20,
                    ),
                    child: Row(
                      children: [
                        Visibility(
                          visible: !category.isParent,
                          child: SizedBox(width: 20),
                        ),
                        Visibility(
                          visible: category.hasIcon,
                          child: RoundedCachedNetworkImage(
                            width: 20,
                            height: 20,
                            imageId: category.icon ?? "",
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: (category.hasAdCount
                                  ? "${category.name} (${category.adCount})"
                                  : category.name)
                              .toString()
                              .w(category.isSelected ? 600 : 400)
                              .s(14)
                              .c(context.textPrimary)
                              .copyWith(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                        ),
                        Assets.images.icArrowRight.svg(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
