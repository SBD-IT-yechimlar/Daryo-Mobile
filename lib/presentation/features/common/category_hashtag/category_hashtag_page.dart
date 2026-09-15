import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/app_bar/action_app_bar.dart';
import 'package:daryo/presentation/widgets/button/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:flutter/services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/web.dart';

import '../../../../../../../domain/models_daryo/recommendation/recommendation.dart';

import '../../../router/app_router.dart';
import '../../../support/colors/static_colors.dart';
import '../../../widgets/dashboard/recommendation/rec_item.dart';
import '../../../widgets/dashboard/recommendation/rec_item_shimmer.dart';
import '../../../widgets/errors/full_screen_error.dart';
import '../../../widgets/image/rounded_cached_network_image_widget.dart';
import 'category_hashtag_cubit.dart';

@RoutePage()
class CategoryHashTagPage extends BasePage<CategoryHashTagCubit,
    CategoryHashTagState, CategoryHashTagEvent> {
  const CategoryHashTagPage({super.key, required this.hashTag, required this.title, this.isResult=false});

  final String hashTag;
  final String title;
  final bool isResult;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).getController(hashTag);
  }

  @override
  void onEventEmitted(BuildContext context, CategoryHashTagEvent event) async {
    switch (event.type) {
      case CategoryHashTagEventType.lostConnection:
        final result = await context.router.push(LostConnectionRoute());
        if (result == true) {
          Logger().w("aca");
          cubit(context).refreshController();
        }
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, CategoryHashTagState state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: ActionAppBar(
        iconColor: context.textPrimary,
        titleText: isResult ?"''${hashTag.toUpperCase()}'' ":title.toUpperCase(),
        titleTextColor: context.textPrimary,
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: context.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 6, left: 6),
        child: RefreshIndicator(
          displacement: 80,
          strokeWidth: 3,
          color: StaticColors.colorPrimary,
          onRefresh: () async {
            cubit(context).refresh();
          },
          child: PagedListView<int, Common>(
            shrinkWrap: false,
            addAutomaticKeepAlives: true,
            physics: BouncingScrollPhysics(),
            pagingController: state.controller!,
            builderDelegate: PagedChildBuilderDelegate<Common>(
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
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
                    child: CircularProgressIndicator(
                        color: StaticColors.colorPrimary),
                  ),
                );
              },
              newPageErrorIndicatorBuilder: (_) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFEDF1F3),
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      child: Column(
                        children: [
                          "Yangi sahifani yuklashda xatolik yuz berdi. Iltimos qayta yuklang!"
                              .s(14)
                              .w(500)
                              .c(Colors.red)
                              .copyWith(textAlign: TextAlign.center),
                          SizedBox(height: 15),
                          CustomElevatedButton(
                              text: "Qayta Yuklash",
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
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: _buildItem(
                    context,
                    recommendation: item,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, {required Common recommendation}) {
    return GestureDetector(
      onTap: () {
        context.router.push(ContentDetailRoute(slug: recommendation.slug));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 327 / 200,
            child: RoundedCachedNetworkImage(
              imageId: recommendation.img,
              width: double.infinity,
              borderRadius: 16,
            ),
          ),
          SizedBox(height: 16),
          Text(
            recommendation.title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ).s(14).w(500),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(recommendation.category)
                    .s(12)
                    .w(500)
                    .c(context.colors.primary),
              ),
              Text(formatDate(recommendation.date))
                  .s(12)
                  .w(400)
                  .c(const Color(0xFF6C7278)),
            ],
          ),
        ],
      ),
    );
  }
}
