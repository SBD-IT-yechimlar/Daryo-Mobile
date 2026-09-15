import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/gen/assets/assets.gen.dart';
import '../../../../core/gen/localization/strings.dart';
import '../../../widgets/account/custom_elevated_button.dart';

class FavoritesEmpty extends StatelessWidget {
  const FavoritesEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.imagesDaryo.icFavoritesHeartX.svg(height: 80, width: 80),
          SizedBox(height: 24),
          Strings.noFavoritePosts.s(14).w(600),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Strings.howToAddFavoritePosts
                .s(12)
                .w(500)
                .c(Color(0xFF6C7278))
                .a(TextAlign.center)
                .copyWith(overflow: TextOverflow.clip, softWrap: true),
          ),
          SizedBox(height: 24),
          CustomElevatedButton(
            onPressed: () {},
            text: Strings.goBackToHome,
            textSize: 14,
          )
        ],
      ),
    );
  }
}
