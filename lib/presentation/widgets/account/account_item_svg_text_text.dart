import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/gen/assets/assets.gen.dart';

class AccountItemSvgTextText extends StatelessWidget {
  String title;
  Widget icon;
  String text;
  Function()? onTap;
  AccountItemSvgTextText({super.key, required this.title, required this.icon, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [icon, SizedBox(width: 12), title.s(14).w(400)],
          ),
          text.s(14).w(400).c(Color(0xFF6C7278))
        ],
      ),
    );
  }
}
