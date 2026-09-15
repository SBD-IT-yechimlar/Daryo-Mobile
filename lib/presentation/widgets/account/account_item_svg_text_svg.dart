import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/gen/assets/assets.gen.dart';

class AccountItemSvgTextSvg extends StatelessWidget {
  String title;
  Widget icon;
  final VoidCallback? onTap;
  AccountItemSvgTextSvg({super.key, required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [icon, SizedBox(width: 12), title.s(14).w(400).c(context.textPrimary)],
            ),
            Assets.images.icAccountArrowRight.svg()
          ],
        ),
      ),
    );
  }
}
