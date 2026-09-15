import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:daryo/presentation/widgets/calendar/calendar_custom_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../../core/gen/localization/strings.dart';
import '../../../router/app_router.dart';
import '../../../widgets/account/custom_elevated_button.dart';
import 'news_history_calendar_cubit.dart';

@RoutePage()
class NewsHistoryCalendarPage extends BasePage<NewsHistoryCalendarCubit, NewsHistoryCalendarState, NewsHistoryCalendarEvent> {
  const NewsHistoryCalendarPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, NewsHistoryCalendarState state) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: DefaultAppBar(
          titleText: Strings.newsArchive,
          titleTextColor: context.textPrimary,
          backgroundColor: context.backgroundColor,
          onBackPressed: () {
            context.router.pop();
          },
          context: context),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CalendarCustomWidget(
                  onDateSelected: (date) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                    print("Tanlangan sana: $formattedDate");
                    cubit(context).setSelectDate(formattedDate);
                  },
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    context.pushRoute(NewsHistoryRoute(data: state.selectedDate));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: context.primary,
                    ),
                    child: Center(child: Strings.commonSearch.s(14).w(400).c(StaticColors.white)),
                  ),
                )
              ],
            ),
          ),
        ),
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
