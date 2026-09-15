import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/localization/strings.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/app_bar/action_app_bar.dart';
import 'package:daryo/presentation/widgets/button/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:flutter/services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/web.dart';
import '../../../../domain/models_daryo/recommendation/recommendation.dart';
import '../../../router/app_router.dart';
import '../../../support/colors/static_colors.dart';
import '../../../widgets/dashboard/recommendation/rec_item.dart';
import '../../../widgets/dashboard/recommendation/rec_item_shimmer.dart';
import '../../../widgets/errors/full_screen_error.dart';
import 'search_hashtag_cubit.dart';

@RoutePage()
class SearchHashTagPage extends BasePage<SearchHashTagCubit, SearchHashTagState, SearchHashTagEvent> {
  SearchHashTagPage({super.key,required this.hashTag});
  final String hashTag;


  @override
  void onWidgetCreated(BuildContext context) {
     cubit(context).getController(hashTag);
  }
  @override
  void onEventEmitted(BuildContext context, SearchHashTagEvent event) async{
    switch(event.type){
      case SearchHashTagEventType.lostConnection:
      final result = await context.router.push(LostConnectionRoute());
    if(result==true){
      Logger().w("aca");
      cubit(context).refreshController();
    }
    }
  }


  @override
  Widget onWidgetBuild(BuildContext context, SearchHashTagState state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: ActionAppBar(
        iconColor: context.textPrimary,
        titleText: "#${hashTag.toUpperCase()}",
        titleTextColor:context.textPrimary,
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: context.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 10,right: 6,left: 6),
        child: RefreshIndicator(
          displacement: 80,
          strokeWidth: 3,
          color: StaticColors.colorPrimary,
          onRefresh: () async {
            cubit(context).refresh();
          },
          child: PagedListView<int,Common>(
            shrinkWrap: false,
            addAutomaticKeepAlives: true,
            physics: BouncingScrollPhysics(),
            pagingController: state.controller!,
            builderDelegate: PagedChildBuilderDelegate<Common>(
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  child: CommonItem(recommendation: item,
                    onItemClicked: (Common item) {
                      context.router.push(ContentDetailRoute(slug: item.slug));

                    },),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

}
