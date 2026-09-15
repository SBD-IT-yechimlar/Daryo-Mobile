import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:flutter/material.dart';

class AccountItemSvgText extends StatelessWidget {
  String title;
  Widget icon;
  Function()? onTap;
  Color? color;

  AccountItemSvgText({super.key, required this.title, required this.icon, this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [

                  icon,
                  SizedBox(width: 12),
                  Expanded(
                    child: title.s(14).w(400).c(color ?? Color(0xFF1A1C1E)).copyWith(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                    ),
                  )
                ],
              ),
            ),
            SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

