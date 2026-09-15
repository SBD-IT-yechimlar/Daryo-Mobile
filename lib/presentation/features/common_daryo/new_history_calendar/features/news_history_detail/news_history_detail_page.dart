import'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../../../core/gen/localization/strings.dart';
import '../../../../../../data/datasource/network/dto/news_history/news_history_response.dart';
import '../../../../../widgets/account/custom_elevated_button.dart';
import '../../../../../widgets/image/rounded_cached_network_image_widget.dart';
import '../../../../../widgets/loading/loader_state_widget.dart';
import 'news_history_detail_cubit.dart';

@RoutePage()
class NewsHistoryDetailPage extends BasePage<NewsHistoryDetailCubit, NewsHistoryDetailState, NewsHistoryDetailEvent> {
  final String data;

  const NewsHistoryDetailPage({super.key, required this.data});

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setSelectDate(data);
    cubit(context).getNewsHistory(page: 1);
    super.onWidgetCreated(context);
  }

  @override
  Widget onWidgetBuild(BuildContext context, NewsHistoryDetailState state) {
    String formatToReadableDate(String dateString) {
      try {
        // 1️⃣ Stringni DateTime turiga o‘tkazamiz
        DateTime parsedDate = DateTime.parse(dateString);

        // 2️⃣ Oy nomlarini o‘zbek tilida ro‘yxatga olamiz
        const List<String> monthNames = [
          "yanvar",
          "fevral",
          "mart",
          "aprel",
          "may",
          "iyun",
          "iyul",
          "avgust",
          "sentyabr",
          "oktyabr",
          "noyabr",
          "dekabr"
        ];

        // 3️⃣ Oy nomini olish
        String monthName = monthNames[parsedDate.month - 1];

        // 4️⃣ Natijani formatlab qaytaramiz
        return "${parsedDate.day}-$monthName, ${parsedDate.year}";
      } catch (e) {
        // Agar noto‘g‘ri sana kelsa, xatolikni ushlab qaytaramiz
        return "Noto‘g‘ri sana";
      }
    }

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: DefaultAppBar(
          titleText: formatToReadableDate(data),
          titleTextColor: context.textPrimary,
          backgroundColor: context.backgroundColor,
          onBackPressed: () {},
          context: context),
      body: LoaderStateWidget(
        emptyBody: _emptyView(context),
        successBody: _successWidget(state, context),
        errorBody: _errorView(context),
        loadingBody: _loadingView(context),
        loadingState: state.loadingState,
      ),
    );
  }

  /*Widget successWidget(NewsHistoryDetailState state, BuildContext context) {
    String formatDateTime(String dateTimeStr) {
      final months = ['Yan', 'Fev', 'Mar', 'Apr', 'May', 'Iyun', 'Iyul', 'Avg', 'Sen', 'Okt', 'Noy', 'Dek'];

      try {
        final dateTime = DateTime.parse(dateTimeStr);

        final hour = dateTime.hour.toString().padLeft(2, '0');
        final minute = dateTime.minute.toString().padLeft(2, '0');
        final monthName = months[dateTime.month - 1];
        final day = dateTime.day;
        final year = dateTime.year;

        return '$hour:$minute / $monthName $day, $year';
      } catch (e) {
        return dateTimeStr; // agar xato bo‘lsa asl stringni qaytaradi
      }
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemCount: state.newsHistoryList?.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border:
                      !(state.newsHistoryList?[index].status?.contains("publish") ?? false) ? Border.all(color: Color(0xFFFFD260), width: 2) : null,
                ),
                child: Stack(
                  children: [
                    RoundedCachedNetworkImage(imageId: state.newsHistoryList?[index].img ?? "", borderRadius: 16, height: 200),
                    if (!(state.newsHistoryList?[index].status?.contains("publish") ?? false))
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          height: 30,
                          width: 30,
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(color: StaticColors.grayClickColor, borderRadius: BorderRadius.circular(15)),
                          child: Assets.imagesDaryo.icNewsPremiumCrown.svg(),
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(height: 16),
              Flexible(
                child: HtmlUnescape()
                    .convert(state.newsHistoryList?[index].title ?? "")
                    .s(14)
                    .w(500)
                    .c(context.textPrimary)
                    .copyWith(overflow: TextOverflow.clip, softWrap: true),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "${state.newsHistoryList?[index].category}".s(12).w(500).c(context.primary),
                  Row(
                    children: [
                      Assets.imagesDaryo.clock.svg(),
                      SizedBox(width: 4),
                      formatDateTime(state.newsHistoryList?[index].date ?? "").s(12).w(500).c(context.textSecondary),
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }*/

  Widget _successWidget(NewsHistoryDetailState state, BuildContext context) {
    final cubitInstance = cubit(context);

    String formatDateTime(String dateTimeStr) {
      final months = ['Yan', 'Fev', 'Mar', 'Apr', 'May', 'Iyun', 'Iyul', 'Avg', 'Sen', 'Okt', 'Noy', 'Dek'];
      try {
        final dateTime = DateTime.parse(dateTimeStr);
        final hour = dateTime.hour.toString().padLeft(2, '0');
        final minute = dateTime.minute.toString().padLeft(2, '0');
        final monthName = months[dateTime.month - 1];
        return '$hour:$minute / $monthName ${dateTime.day}, ${dateTime.year}';
      } catch (e) {
        return dateTimeStr;
      }
    }

    return PagedListView<int, NewsHistoryList>(
      pagingController: cubitInstance.pagingController,
      padding: const EdgeInsets.all(16),
      builderDelegate: PagedChildBuilderDelegate<NewsHistoryList>(
        itemBuilder: (context, item, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: !(item.status?.contains("publish") ?? false) ? Border.all(color: const Color(0xFFFFD260), width: 2) : null,
                  ),
                  child: Stack(
                    children: [
                      RoundedCachedNetworkImage(
                        imageId: item.img ?? "",
                        borderRadius: 16,
                        height: 200,
                      ),
                      if (!(item.status?.contains("publish") ?? false))
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            height: 30,
                            width: 30,
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: StaticColors.grayClickColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Assets.imagesDaryo.icNewsPremiumCrown.svg(),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                HtmlUnescape().convert(item.title ?? "").s(14).w(500).c(context.textPrimary).copyWith(overflow: TextOverflow.clip, softWrap: true),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (item.category ?? "").s(12).w(500).c(context.primary),
                    Row(
                      children: [
                        Assets.imagesDaryo.clock.svg(),
                        const SizedBox(width: 4),
                        formatDateTime(item.date ?? "").s(12).w(500).c(context.textSecondary),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        firstPageProgressIndicatorBuilder: (_) => const Center(child: CircularProgressIndicator()),
        newPageProgressIndicatorBuilder: (_) => const Center(child: CircularProgressIndicator()),
        noItemsFoundIndicatorBuilder: (_) => const Center(child: Text("Yangiliklar topilmadi")),
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
          Strings.noSubscriptions.s(14).w(600).c(context.textPrimary),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Strings.subscribePremiumText
                .s(12)
                .w(500)
                .c(context.textSecondary)
                .a(TextAlign.center)
                .copyWith(overflow: TextOverflow.clip, softWrap: true),
          ),
          SizedBox(height: 24),
          CustomElevatedButton(
            onPressed: () {},
            text: Strings.tariffs,
            textColor: context.textPrimary,
            textSize: 14,
          )
        ],
      ),
    );
  }

  Widget _errorView(BuildContext context) {
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
          Strings.errorOccurredTryAgain.s(14).w(600).a(TextAlign.center).c(context.textPrimary),
          SizedBox(height: 24),
          CustomElevatedButton(
            onPressed: () {
              // cubit(context).getSubscriptions();
            },
            text: Strings.seeMore,
            textColor: context.textPrimary,
            textSize: 14,
          )
        ],
      ),
    );
  }

  Widget _loadingView(BuildContext context) {
    return Container(
      color: context.containerBackground,
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFDFF1FF).withOpacity(0.6),
            ),
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation(Color(0xFF0089DA)),
            ),
          ),
          SizedBox(height: 24),
          Strings.dataLoading.s(14).w(500).c(context.textSecondary).a(TextAlign.center),
        ],
      ),
    );
  }
}
