import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:flutter/cupertino.dart';

class AccountItemSvgTextSwitch extends StatelessWidget {
  String title;
  Widget icon;
  Widget switchIcon;

  AccountItemSvgTextSwitch(
      {super.key, required this.title, required this.icon, required this.switchIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [icon, SizedBox(width: 12), title.s(14).w(400)],
          ),
          switchIcon
        ],
      ),
    );
  }
}
