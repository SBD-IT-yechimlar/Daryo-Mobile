import 'package:flutter/material.dart';

/// A reusable widget that works exactly like Row but automatically
/// adds spacing between its children using SizedBox.
///
/// This widget accepts all the same parameters as Row, plus an additional
/// spacing parameter to control the space between children.
class SpacedRow extends StatelessWidget {
  /// The spacing to add between children
  final double spacing;

  /// How the children should be placed along the main axis.
  ///
  /// For example, [MainAxisAlignment.start], the default, places the children
  /// at the start (i.e., the top) of the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How much space should be occupied in the main axis.
  ///
  /// During a flex layout, available space along the main axis is allocated to
  /// children. After allocating space, there might be some remaining free space.
  /// This value controls whether to maximize or minimize the amount of free
  /// space, subject to the incoming layout constraints.
  final MainAxisSize mainAxisSize;

  /// How the children should be placed along the cross axis.
  ///
  /// For example, [CrossAxisAlignment.center], the default, centers the
  /// children in the cross axis (e.g., horizontally for a [Row]).
  final CrossAxisAlignment crossAxisAlignment;

  /// Determines the order to lay children out horizontally and how to interpret
  /// `start` and `end` in the horizontal direction.
  ///
  /// Defaults to the ambient [Directionality].
  ///
  /// If [textDirection] is [TextDirection.rtl], then the direction in which
  /// text flows starts from right to left. Otherwise, if [textDirection] is
  /// [TextDirection.ltr], then the direction in which text flows starts from
  /// left to right.
  ///
  /// When the [crossAxisAlignment] is either [CrossAxisAlignment.start] or
  /// [CrossAxisAlignment.end], the [textDirection] must not be null.
  final TextDirection? textDirection;

  /// Determines the order to lay children out vertically and how to interpret
  /// `start` and `end` in the vertical direction.
  ///
  /// Defaults to [VerticalDirection.down].
  ///
  /// If the [mainAxisAlignment] is either [MainAxisAlignment.start] or
  /// [MainAxisAlignment.end], the [verticalDirection] must not be null.
  final VerticalDirection verticalDirection;

  /// If aligning items according to their baseline, which baseline to use.
  ///
  /// This must be set if using [CrossAxisAlignment.baseline].
  final TextBaseline? textBaseline;

  /// The widgets below this widget in the tree.
  ///
  /// If this list is going to be mutated, it is usually better to put the
  /// children in a [ListView], in order to avoid the performance problems
  /// inherent in repeatedly modifying the children list.
  final List<Widget> children;

  /// Creates a vertical array of children with automatic spacing.
  ///
  /// The [spacing] argument must not be null and must be non-negative.
  /// The [mainAxisAlignment], [mainAxisSize], [crossAxisAlignment], and
  /// [verticalDirection] arguments must not be null.
  /// If [crossAxisAlignment] is [CrossAxisAlignment.baseline], then
  /// [textBaseline] must not be null.
  ///
  /// The [textDirection] argument defaults to the ambient [Directionality], if
  /// any. If there is no ambient directionality, and a text direction is going
  /// to be necessary to decide which direction to lay the children in or to
  /// disambiguate `start` or `end` values for the main or cross axis
  /// directions, the [textDirection] must not be null.
  const SpacedRow({
    super.key,
    required this.spacing,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.children = const <Widget>[],
  });

  @override
  Widget build(BuildContext context) {
    // If no children, return empty Row
    if (children.isEmpty) {
      return Row(
        key: key,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: children,
      );
    }

    // If only one child, no spacing needed
    if (children.length == 1) {
      return Row(
        key: key,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: children,
      );
    }

    // Create list with spacing between children
    final List<Widget> spacedChildren = [];

    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);

      // Add spacing after each child except the last one
      if (i < children.length - 1) {
        spacedChildren.add(SizedBox(width: spacing));
      }
    }

    return Row(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: spacedChildren,
    );
  }
}
