import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../../core/gen/localization/strings.dart';
import '../../../widgets/account/custom_elevated_button.dart';
import 'quiz_history_cubit.dart';

@RoutePage()
class QuizHistoryPage extends BasePage<QuizHistoryCubit, QuizHistoryState, QuizHistoryEvent> {
  const QuizHistoryPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, QuizHistoryState state) {
    List<Widget> socialMedia = [
      Assets.imagesDaryo.icTelegram.svg(),
      Assets.imagesDaryo.icInstagramm.svg(),
      Assets.imagesDaryo.icXTwitter.svg(),
    ];

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Strings.quizHistory.s(16).w(700).c(context.textPrimary),
        iconTheme:IconThemeData(color: context.textPrimary),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dateSection(context, "Fevral 25, 2025", 2),
                _dateSection(context, "Yanvar 04, 2025", 2),
                _dateSection(context, "Dekabr 27, 2024", 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dateSection(BuildContext context, String date, int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        date.s(16).w(500).c(context.textPrimary),
        const SizedBox(height: 10),
        Column(
          children: List.generate(count, (index) => _containerWidget(context)),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _listWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Fevral 25, 2025".s(16).w(400).c(context.textPrimary),
        SizedBox(height: 10),
        Flexible(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return _containerWidget(context);
              }),
        ),
      ],
    );
  }

  Widget _containerWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: context.containerBackground,
      ),
      child: Row(
        children: [
          SizedBox(
            height: 65,
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Assets.imagesDaryo.pngImages.quizHisotryImg.image(fit: BoxFit.cover, alignment: Alignment.topCenter),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                "Sport bo‘yicha bilimingizni sinab ko‘ring!"
                    .s(16)
                    .w(500)
                    .c(context.textPrimary)
                    .copyWith(overflow: TextOverflow.ellipsis, maxLines: 3, softWrap: true),
                SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "12:34".s(12).w(400).c(context.textSecondary),
                    Row(
                      children: [
                        Assets.imagesDaryo.icQuizHisotryCoin.svg(),
                        " +80 ball".s(13).w(400).c(context.greenColor),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _emptyView(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.imagesDaryo.icByArticlesNoteRemove.svg(height: 80, width: 80),
          SizedBox(height: 24),
          Strings.noPurchasedArticles.s(14).w(600),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Strings.subscribePremiumText
                .s(12)
                .w(500)
                .c(Color(0xFF6C7278))
                .a(TextAlign.center)
                .copyWith(overflow: TextOverflow.clip, softWrap: true),
          ),
          SizedBox(height: 24),
          CustomElevatedButton(
            onPressed: () {},
            text: Strings.tariffs,
            textSize: 14,
          )
        ],
      ),
    );
  }
}
