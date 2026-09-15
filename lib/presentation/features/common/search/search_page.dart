import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/features/common/search/search_cubit.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/search/search_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/gen/assets/assets.gen.dart';
import '../../../../core/gen/localization/strings.dart';
import '../../../../domain/models_daryo/recommendation/recommendation.dart';
import '../../../router/app_router.dart';
import '../../../support/colors/static_colors.dart';
import '../../../support/cubit/base_page.dart';
import '../../../widgets/account/custom_elevated_button.dart';
import '../../../widgets/dashboard/recommendation/rec_item.dart';
import '../../../widgets/dashboard/recommendation/rec_item_shimmer.dart';
import '../../../widgets/errors/full_screen_error.dart';

@RoutePage()
class SearchPage extends BasePage<SearchCubit, SearchState, SearchEvent> {
  const SearchPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, SearchState state) {
    return Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: AppBar(
          backgroundColor: context.backgroundColor,
          leading: IconButton(
            onPressed: () {
              context.router.pop();
            },
            icon: Assets.imagesDaryo.back.svg(colorFilter: ColorFilter.mode(context.iconPrimary, BlendMode.srcIn)),
          ),
          title: SearchInputField(
              hintText: Strings.search,
              onQueryChanged: (value) {
                cubit(context).changeQuery(value ?? "");
              }),
        ),
        body: RefreshIndicator(
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  height: 300,
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
                          Strings.loadError
                              .s(14)
                              .w(500)
                              .c(Colors.red)
                              .copyWith(textAlign: TextAlign.center),
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: CommonItem(
                    recommendation: item,
                    queryMask: state.searchQuery,
                    onItemClicked: (Common item) {
                      context.router.push(ContentDetailRoute(slug: item.slug));
                    },
                  ),
                );
              },
            ),
          ),
        ));
  }
}
