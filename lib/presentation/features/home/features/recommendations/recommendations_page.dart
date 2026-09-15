import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/button/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/web.dart';

import '../../../../../core/gen/localization/strings.dart';
import '../../../../../domain/models_daryo/recommendation/caregory.dart';
import '../../../../../domain/models_daryo/recommendation/reccommendation.dart';
import '../../../../../domain/models_daryo/recommendation/recommendation.dart';
import '../../../../router/app_router.dart';
import '../../../../support/colors/static_colors.dart';
import '../../../../widgets/appbar/image_app_bar.dart';
import '../../../../widgets/dashboard/recommendation/rec_item.dart';
import '../../../../widgets/dashboard/recommendation/rec_item_shimmer.dart';
import '../../../../widgets/errors/full_screen_error.dart';
import '../../../../widgets/recommendation/recommendation_item.dart';
import '../../../../widgets/recommendation/recommendation_item_shimmer.dart';
import 'recommendations_cubit.dart';

@RoutePage()
class RecommendationsPage extends BasePage<RecommendationsCubit, RecommendationsState, RecommendationsEvent> {
  RecommendationsPage({super.key});

  @override
  void onEventEmitted(BuildContext context, RecommendationsEvent event) async {
    switch (event.type) {
      case RecommendationsEventType.lostConnection:
        final result = await context.router.push(LostConnectionRoute());
        if (result == true) {
          cubit(context).refreshController();
        }
    }
  }


  @override
  Widget onWidgetBuild(BuildContext context, RecommendationsState state) {

    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: ImageAppBar(
        context: context,
        titleText: "",
        titleTextColor: Colors.black,
        backgroundColor: context.backgroundColor,
        onBackPressed: () {},
        flexibleSpace: Container(
          height: 200,
          color: Colors.black,
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: context.backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: context.isDarkMode? Color(0xFF1F2937):Color(0xFFEDF1F3),
                borderRadius: BorderRadius.circular(14)
              ),
              child: Row(
                 mainAxisSize: MainAxisSize.max,
                children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4,bottom: 4,left: 6),
                    child: Material(
                        color: state.selectedIndex==0?context.backgroundColor:
                        context.isDarkMode? Color(0xFF1F2937): Color(0xFFEDF1F3),
                        borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                        onTap: (){
                            cubit(context).selectedIndex(0);
                          HapticFeedback.lightImpact();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)
                          ),
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(child: Strings.latestNews.s(14).w(500).c(context.textPrimary).copyWith(maxLines: 1)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4,bottom: 4,right: 6),
                    child: Material(
                        color: state.selectedIndex==1?context.backgroundColor:
                         context.isDarkMode? Color(0xFF1F2937): Color(0xFFEDF1F3),
                        borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                        onTap: (){
                          cubit(context).selectedIndex(1);

                          HapticFeedback.lightImpact();
                        },
                        child: Container(

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)
                          ),
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(child: Strings.recommendations.s(14).w(500).c(context.textPrimary).copyWith(maxLines: 1)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 6, left: 6),
              child: RefreshIndicator(
                displacement: 80,
                strokeWidth: 3,
                color: StaticColors.colorPrimary,
                onRefresh: () async {
                  cubit(context).refresh();
                },
                child: state.selectedIndex==0? getLastNews(context,state):getRecommendations(context, state),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getRecommendations(BuildContext context, RecommendationsState state){
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return  PagedListView<int, RecommendationModel>(
      shrinkWrap: false,
      addAutomaticKeepAlives: true,
      physics: BouncingScrollPhysics(),
      pagingController: state.controller!,
      builderDelegate: PagedChildBuilderDelegate<RecommendationModel>(
        firstPageErrorIndicatorBuilder: (_) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: FullScreenErrorWidget(
                onItemClicked: () {
                  state.controller!.refresh();
                },
              ),
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
                return RecommendationShimmerWidget();
              },
            ),
          );
        },
        noItemsFoundIndicatorBuilder: (_) {
          return SizedBox();
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
              decoration: BoxDecoration(color: Color(0xFFEDF1F3), borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    Strings.loadError.s(14).w(500).c(Colors.red).copyWith(textAlign: TextAlign.center),
                    SizedBox(height: 15),
                    CustomElevatedButton(
                        text: Strings.reload,
                        onPressed: () {
                          cubit(context).states.controller?.refresh();
                        }),
                  ],
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 100),
        itemBuilder: (context, item, index) {
          return RecommendationWidget(
              onItemClicked: (item) {
                context.router.push(ContentDetailRoute(slug: item.slug));
              },
              item: item);
        },
      ),
    );
  }

  Widget getLastNews(BuildContext context, RecommendationsState state){
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return PagedListView<int, Common>(
      shrinkWrap: false,
      addAutomaticKeepAlives: true,
      physics: BouncingScrollPhysics(),
      pagingController: state.lastNewsController!,
      builderDelegate: PagedChildBuilderDelegate<Common>(
        firstPageErrorIndicatorBuilder: (_) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: FullScreenErrorWidget(
                onItemClicked: () {
                  state.lastNewsController!.refresh();
                },
              ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                  child: CommonItemShimmer(),
                );
              },
            ),
          );
        },
        noItemsFoundIndicatorBuilder: (_) {
          return SizedBox();
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
              decoration: BoxDecoration(color: Color(0xFFEDF1F3), borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    Strings.loadError.s(14).w(500).c(Colors.red).copyWith(textAlign: TextAlign.center),
                    SizedBox(height: 15),
                    CustomElevatedButton(
                        text: Strings.reload,
                        onPressed: () {
                          cubit(context).states.lastNewsController?.refresh();
                        }),
                  ],
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 100),
        itemBuilder: (context, item, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
            child: CommonItem(
                onItemClicked: (item) {
                  context.router.push(ContentDetailRoute(slug: item.slug));
                },
                recommendation: item),
          );
        },
      ),
    );
  }
}
