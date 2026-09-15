import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/router/app_router.dart';
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
import '../../../../../widgets/dashboard/recommendation/rec_item_shimmer.dart';
import '../../../../../widgets/errors/full_screen_error.dart';
import '../../../../../widgets/image/rounded_cached_network_image_widget.dart';
import '../../../../../widgets/loading/loader_state_widget.dart';
import 'news_history_cubit.dart';

@RoutePage()
class NewsHistoryPage extends BasePage<NewsHistoryCubit, NewsHistoryState, NewsHistoryEvent> {
  final String data;

  const NewsHistoryPage({super.key, required this.data});

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setSelectDate(data);
    cubit(context).getNewsHistory(page: 1);
    super.onWidgetCreated(context);
  }

  @override
  Widget onWidgetBuild(BuildContext context, NewsHistoryState state) {
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

    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: DefaultAppBar(
          titleText: formatToReadableDate(data),
          titleTextColor: context.textPrimary,
          backgroundColor: context.backgroundColor,
          onBackPressed: () {
            context.router.pop();
          },
          context: context),
      body:Padding(
        padding: const EdgeInsets.only(top: 10,right: 6,left: 6),
        child: RefreshIndicator(
          displacement: 80,
          strokeWidth: 3,
          color: StaticColors.colorPrimary,
          onRefresh: () async {
            cubit(context).refresh();
          },
          child: PagedListView<int,NewsHistoryList>(
            shrinkWrap: false,
            addAutomaticKeepAlives: true,
            physics: BouncingScrollPhysics(),
            pagingController: state.controller!,
            builderDelegate: PagedChildBuilderDelegate<NewsHistoryList>(
              firstPageErrorIndicatorBuilder: (_) {
                return  Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:12),
                    child: FullScreenErrorWidget(onItemClicked: (){
                      state.controller!.refresh();
                    },),
                  ),
                );
              },
              firstPageProgressIndicatorBuilder: (_) {
                return SizedBox(
                  height: height,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                        child: CommonItemShimmer(),
                      );
                    },
                  ),
                );
              },
              noItemsFoundIndicatorBuilder: (_) {
                return Center(child: Strings.emptyData.s(14).w(500).c(context.textSecondary));
              },
              newPageProgressIndicatorBuilder: (_) {
                return SizedBox(
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(color: StaticColors.colorPrimary),
                  ),
                );
              },
              newPageErrorIndicatorBuilder: (_) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFEDF1F3),
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
                      child: Column(children: [
                        Strings.loadError.s(14).w(500).c(Colors.red).copyWith(textAlign: TextAlign.center),
                        SizedBox(height: 15),
                        CustomElevatedButton(text: Strings.reload, onPressed: (){
                          cubit(context).states.controller?.refresh();
                        }),
                      ],),
                    ),
                  ),
                );
              },
              transitionDuration: Duration(milliseconds: 100),
              itemBuilder: (context, item, index) {
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
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20,right: 16,left: 16),
                  child: GestureDetector(
                    onTap: (){
                      context.pushRoute(ContentDetailRoute(slug: state.newsHistoryList?[index].slug??""));
                    },
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
                  ),
                );;
              },
            ),
          ),
        ),
      ),
    );
  }
  
}
