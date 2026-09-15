/*
import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/button/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../../core/gen/localization/strings.dart';
import '../../../../../../../domain/models_daryo/recommendation/reccommendation.dart';
import '../../../../../../router/app_router.dart';
import '../../../../../../support/colors/static_colors.dart';
import '../../../../../../widgets/appbar/image_app_bar.dart';
import '../../../../../../widgets/errors/full_screen_error.dart';
import '../../../../../../widgets/recommendation/recommendation_item.dart';
import '../../../../../../widgets/recommendation/recommendation_item_shimmer.dart';
import '../../../../../../widgets/search/search_input_field.dart';
import '../../../../../../widgets/search/search_widget.dart';
import 'search_cubit.dart';

@RoutePage()
class SearchPage extends BasePage<SearchCubit, SearchState, SearchEvent> {
  SearchPage({super.key});

  final searchTextController = TextEditingController();

  @override
  Widget onWidgetBuild(BuildContext context, SearchState state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 64,
      //  leading: Assets.images.icArrowLeft.svg(color: Colors.black),
        actions: [
          IconButton(onPressed: (){
            context.router.pop();
          },
              icon: Assets.imagesv2.icExitArrow.svg()),
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: SearchInputField(
                hintText: "Izlash...",
                onQueryChanged: (query) {
                //  return cubit(context).setSearchQuery(query);
                },
              ),
            ),
          ),
        ],
      ),

      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFfefefe),
      body: Padding(
        padding: const EdgeInsets.only(top: 10,right: 6,left: 6),
        child: RefreshIndicator(
          displacement: 80,
          strokeWidth: 3,
          color: StaticColors.colorPrimary,
          onRefresh: () async {
            state.controller!.refresh();
          },
          child: PagedListView<int,RecommendationModel>(
            shrinkWrap: false,
            addAutomaticKeepAlives: true,
            physics: BouncingScrollPhysics(),
            pagingController: state.controller!,
            builderDelegate: PagedChildBuilderDelegate<RecommendationModel>(
              firstPageErrorIndicatorBuilder: (_) {
                return  Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: FullScreenErrorWidget(onItemClicked: (){
                    state.controller!.refresh();
                  },),
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
                    decoration: BoxDecoration(
                      color: Color(0xFFEDF1F3),
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
                      child: Column(children: [
                        "Yangi sahifani yuklashda xatolik yuz berdi. Iltimos qayta yuklang!".s(14).w(500).c(Colors.red).copyWith(textAlign: TextAlign.center),
                         SizedBox(height: 15),
                         CustomElevatedButton(text: "Qayta Yuklash", onPressed: (){
                           cubit(context).states.controller?.refresh();
                         }),
                      ],),
                    ),
                  ),
                );
              },
              transitionDuration: Duration(milliseconds: 100),
              itemBuilder: (context, item, index) {
                return SearchItemWidget(onItemClicked: (item){}, item: item, recommendation: item);
              },
            ),
          ),
        ),
      ),
    );
  }

}
*/
