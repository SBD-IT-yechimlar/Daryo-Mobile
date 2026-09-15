import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/account/social_post_widget.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../widgets/button/custom_elevated_button.dart';
import '../../../../../widgets/account/comment_input_widget.dart';
import '../../../../../widgets/account/payment_widget.dart';
import 'comment_cubit.dart';

@RoutePage()
class CommentPage extends BasePage<CommentCubit, CommentState, CommentEvent> {
  const CommentPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, CommentState state) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        title: "Izohlar".s(16).w(700).c(context.textPrimary),
        centerTitle: true,
        iconTheme: IconThemeData(color: context.textPrimary),
      ),
      body: Column(
        children: const [
          SocialPostWidget(),
          CommentInputWidget(),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget _emptyView(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.imagesDaryo.icByArticlesNoteRemove.svg(height: 80, width: 80),
          SizedBox(height: 24),
          "Sizda obunalar mavjud emas!".s(14).w(600),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: "Premium maqolalar o’qish uchun o’zingizga ma’qul bo’lgan tarif rejasini tanlang va obuna bo’ling."
                .s(12)
                .w(500)
                .c(Color(0xFF6C7278))
                .a(TextAlign.center)
                .copyWith(overflow: TextOverflow.clip, softWrap: true),
          ),
          SizedBox(height: 24),
          CustomElevatedButton(
            onPressed: () {},
            text: "Tariflar",
            textSize: 14,
          )
        ],
      ),
    );
  }
}
