import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../../domain/models_daryo/category/category.dart';

class CustomExpandableTile extends StatefulWidget {
  final Category category;
  final Function(Category) onTap;

  const CustomExpandableTile({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomExpandableTile> createState() => _CustomExpandableTileState();
}

class _CustomExpandableTileState extends State<CustomExpandableTile> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasChildren = widget.category.children.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            widget.onTap(widget.category);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.category.title,
                    style: TextStyle(fontSize: 14, color: context.textPrimary),
                  ),
                ),

                /// Trailing icon — faqat tugmani bosganda expand
                hasChildren
                    ? IconButton(
                        onPressed: _toggleExpand,
                        icon: _isExpanded
                            ? Assets.images.icArrowDown.svg(height: 12.h, colorFilter: ColorFilter.mode(context.iconPrimary, BlendMode.srcIn))
                            : Assets.images.icArrowRight.svg(height: 12.h, colorFilter: ColorFilter.mode(context.iconPrimary, BlendMode.srcIn)),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        padding: const EdgeInsets.only(right: 2.0),
                      )
                    : IconButton(
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          widget.onTap(widget.category);
                        },
                        icon: Assets.images.icArrowDown.svg(height: 12.h, colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.srcIn)),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        padding: const EdgeInsets.only(right: 2.0),
                      ),
              ],
            ),
          ),
        ),

        /// Children — faqat expanded bo‘lsa ko‘rsatiladi
        if (_isExpanded && hasChildren)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: context.containerBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final child in widget.category.children)
                  InkWell(
                    onTap: () {
                      Logger().w("adcnldc");
                    },
                    child: _CategoryTile(
                      category: child,
                      onTap: widget.onTap,
                    ),
                  ),
              ],
            ),
          ),
      ],
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
