import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  List<Widget> children;
  bool crossAxisAlignmentCenter;
  Color? backgroundColor;
  CustomContainer({super.key, required this.children, required this.crossAxisAlignmentCenter, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.symmetric(vertical: 12),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: context.inputStrokeInactiveColor, width: 1), color: backgroundColor),
      child: Column(
        crossAxisAlignment: crossAxisAlignmentCenter?CrossAxisAlignment.center:CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
