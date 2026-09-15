import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/widgets/adfox/adfox_banner.dart' show AdfoxBanner, adfoxMobileTop, adfoxMobileContent, adfoxMobileBottom;
import 'package:daryo/presentation/widgets/dashboard/hot_news/hot_news_grid.dart';
import 'package:daryo/presentation/widgets/dashboard/shorts_item.dart';
import 'package:daryo/presentation/widgets/videos/video_item.dart';
import 'package:flutter/material.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../core/gen/localization/strings.dart';
import '../../../../../domain/models_daryo/recommendation/recommendation.dart';
import '../../../../../domain/models_daryo/slider/slider.dart';
import '../../../../../domain/models_daryo/tags/tag.dart';
import '../../../../router/app_router.dart';
import '../../../../widgets/dashboard/recommendation/rec_item.dart';
import '../../../../widgets/dashboard/spaced_row.dart';
import '../../../../widgets/image/rounded_cached_network_image_widget.dart';
import '../../../../widgets/loading/loader_state_widget.dart';
import '../../../../widgets/appbar/image_app_bar.dart';
import '../../../../widgets/dashboard/advice/advice_list.dart';
import '../../../../widgets/dashboard/advice/advice_list_shimmer.dart';
import '../../../../widgets/dashboard/carousel/slider_carousel.dart';
import '../../../../widgets/dashboard/carousel/slider_item_shimmer.dart';
import '../../../../widgets/dashboard/recommendation/rec_shimmer_list.dart';
import '../../../../widgets/dashboard/recommendation/recommendation_shimmer_list.dart';
import '../../../../widgets/dashboard/tags/tags_list.dart';
import '../../../../widgets/dashboard/tags/tags_shimmer_list.dart';
import '../../../../widgets/ticket/ticket_widget.dart';
import 'dashboard_cubit.dart';

@RoutePage()
class DashboardPage extends BasePage<DashboardCubit, DashboardState, DashboardEvent> {
  const DashboardPage({super.key});

  @override
  void onEventEmitted(BuildContext context, DashboardEvent event) async {
    switch (event.type) {
      case DashboardEventType.lostConnection:
        final result = await context.router.push(LostConnectionRoute());
        if (result == true) {
          cubit(context).getInitialData();
        }
    }
  }


  @override
  Widget onWidgetBuild(BuildContext context, DashboardState state) {
    return Scaffold(
      appBar: ImageAppBar(
        context: context,
        titleText: "",
        titleTextColor: context.textPrimary,
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      backgroundColor: context.backgroundColor,
      body: RefreshIndicator(
        displacement: 80,
        strokeWidth: 3,
        color: StaticColors.colorPrimary,
        onRefresh: () async {
          cubit(context).reload();
        },
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                      child: AdfoxBanner(config: adfoxMobileTop()),
                    ),
                  ),
                  _buildSliders(context, state),
                  _buildRecommendations(context, state),
                  _buildCategoryNews(context, state),
                  _buildHotNews(context, state),
                //  SizedBox(height: 15.h,),
                  if(state.isRegistered)
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: _buildSubscription(context,state),
                    ),
                  _buildDunyoNews(context, state),
                  _buildAdvices(context, state),
                  _buildShorts(context, state),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                    child: AdfoxBanner(config: adfoxMobileContent()),
                  ),
                  _buildAutoNews(context, state),
                  _buildVideos(context, state),
                  _buildLatestNews(context, state),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                    child: AdfoxBanner(config: adfoxMobileBottom()),
                  ),
                ],
              ),
            ),
            SliverPadding(padding: EdgeInsets.symmetric(horizontal: 16)),
          ],
        ),
      ),
    );
  }



  Widget _buildSliders(BuildContext context, DashboardState state) {
    return LoaderStateWidget(
        onRetryClicked: () {
          cubit(context).getSliders();
        },
        isFullScreen: false,
        emptyBody: SizedBox(),
        loadingState: state.sliderState,
        loadingBody: CarouselSlider.builder(
          itemCount: 3,
          itemBuilder: (context, index, realIdx) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: SliderItemShimmer(),
          ),
          options: CarouselOptions(
            viewportFraction: 1,
            enlargeCenterPage: true,
          ),
        ),
        successBody: SlidersCarousel(
          sliders: state.sliders,
          onItemClicked: (SliderModel item) {
            HapticFeedback.lightImpact();
            context.router.push(ContentDetailRoute(slug: item.slug));
          },
        ));
  }

  Widget _buildRecommendations(BuildContext context, DashboardState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const SizedBox(height: 5),
        /*  _buildLabel(
            context,
            label: Strings.recommendations,
            rightIcon: GestureDetector(
              onTap: () {
                context.router.push(CategoryHashTagRoute(hashTag: "dunyo"));
              },
              child: TextButton(onPressed: (){
                HapticFeedback.lightImpact();
                context.router.push(CategoryHashTagRoute(hashTag: "dunyo"));
              },
                  child: Strings.viewAll.s(12).c(context.colors.primary),)

            ),
          ),
          const SizedBox(height: 16),*/
          LoaderStateWidget(
              onRetryClicked: () {
                cubit(context).getRecommendations();
              },
              emptyBody: SizedBox(),
              loadingState: state.recommendationsState,
              loadingBody: DashboardCommonListShimmer(),
              successBody: DashboardCommonList(
                recommendations: state.recommendations,
                onItemClicked: (Common item) {
                  context.router.push(ContentDetailRoute(slug: item.slug));
                },
              )),
        ],
      ),
    );
  }

  Widget _buildCategoryNews(BuildContext context, DashboardState state) {
    final firstInfo=state.categoryList.firstOrNull;
    final list=List.of(state.categoryList);
    if (state.categoryList.length > 4) {
      list.removeAt(0);
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 10),
          _buildLabel(context,
            label: state.categoryName,
            rightIcon: TextButton(onPressed: () {
              HapticFeedback.lightImpact();
              context.router.push(CategoryHashTagRoute(hashTag: state.categorySlug, title: state.categoryName));
            },
            child: Strings.viewAll.s(12).c(context.colors.primary)),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: context.containerBackground,
            ),
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
            child: SizedBox(
              height: 40.h,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SpacedRow(
                  spacing: 6,
                  children: List.generate(state.category.length, (index) {
                    final item = state.category[index];
                    return MaterialButton(
                      padding: EdgeInsets.symmetric(
                        vertical: 9.h,
                        horizontal: 12.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      color: state.categoryId == item.id
                          ? context.backgroundColor
                          : Colors.transparent,
                      disabledColor: Colors.transparent,
                      elevation: 0,
                      highlightElevation: 0,
                      disabledElevation: 0,
                      focusElevation: 0,
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        cubit(context).selectCategory(item);
                      },
                      child: item.name.s(14).w(500).c(state.categoryId == item.id ? context.textPrimary : context.textSecondary),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          if(firstInfo!=null)
          LoaderStateWidget(
            onRetryClicked: () {},
            emptyBody: SizedBox(),
            errorBody: SizedBox(),
            loadingState: state.categoryListState,
            loadingBody: SizedBox(),
            successBody: GestureDetector(
              onTap: (){
                context.router.push(ContentDetailRoute(slug: firstInfo.slug));
              },
              child: Column(children: [
                SizedBox(height: 12.h),
                RoundedCachedNetworkImage(
                  height: 160.h,
                  imageId: firstInfo.img,
                  width: double.infinity,
                  borderRadius: 16,
                ),
                SizedBox(height: 10.h),
                Text(
                  firstInfo.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ).s(14).w(500),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(firstInfo.category)
                          .s(12)
                          .w(500)
                          .c(context.colors.primary),
                    ),
                    Text(formatDate(firstInfo.date))
                        .s(12)
                        .w(400)
                        .c(const Color(0xFF6C7278)),
                  ],
                ),
                SizedBox(height: 10.h),
              ],),
            )),
              SizedBox(height: 10),
             LoaderStateWidget(
              onRetryClicked: () {
                cubit(context).getCategoriesApi(state.categorySlug, state.byCategoryId);
              },
              emptyBody: SizedBox(),
              loadingState: state.categoryListState,
              loadingBody: DashboardCommonListShimmer(),
              successBody: DashboardCommonList(
                recommendations: list,
                onItemClicked: (Common item) {
                  context.router.push(ContentDetailRoute(slug: item.slug));
                },
              )),
        ],
      ),
    );
  }

  Widget _buildHotNews(BuildContext context, DashboardState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildLabel(
            context,
            label: Strings.hotNews,
            rightIcon: GestureDetector(
              onTap: () {},
              child: Row(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      cubit(context).changeIsGrid(true);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Assets.imagesDaryo.layoutGrid
                          .svg(colorFilter: ColorFilter.mode(state.isGrid ? context.colors.primary : context.iconPrimary, BlendMode.srcIn)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      cubit(context).changeIsGrid(false);
                    },
                    child: Assets.imagesDaryo.layoutList
                        .svg(colorFilter: ColorFilter.mode(!state.isGrid ? context.colors.primary : context.iconPrimary, BlendMode.srcIn)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          LoaderStateWidget(
              onRetryClicked: () {
                cubit(context).getHotNews();
              },
              emptyBody: SizedBox(),
              loadingState: state.hotNewsState,
              loadingBody: DashboardCommonListShimmer(),
              successBody: HotNewsGrid(crossAxisCount: state.isGrid ? 2 : 1, data: state.recommendations)),
        ],
      ),
    );
  }

  Widget _buildDunyoNews(BuildContext context, DashboardState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildLabel(
            context,
            label: Strings.world,
            rightIcon: GestureDetector(
              onTap: () {
                context.router.push(CategoryHashTagRoute(hashTag: Strings.dunyoSlug, title: Strings.world,));
              },
              child: Strings.viewAll.s(12).c(context.colors.primary),
            ),
          ),
          const SizedBox(height: 16),
          LoaderStateWidget(
              onRetryClicked: () {
                cubit(context).getDunyoNews();
              },
              emptyBody: SizedBox(),
              loadingState: state.dunyoNewsState,
              loadingBody: DashboardCommonListShimmer(),
              successBody: DashboardCommonList(
                recommendations: state.dunyoNews,
                onItemClicked: (Common item) {
                  context.router.push(ContentDetailRoute(slug: item.slug));
                },
              )),
        ],
      ),
    );
  }

  Widget _buildTags(BuildContext context, DashboardState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildLabel(
            context,
            label: Strings.popularTags,
          ),
          LoaderStateWidget(
              onRetryClicked: () {
                cubit(context).getTags();
              },
              emptyBody: SizedBox(),
              loadingState: state.tagsState,
              loadingBody: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: TagsShimmer(),
              ),
              successBody: Padding(
                padding: const EdgeInsets.only(top: 14),
                child: TagsList(
                  tags: state.tags,
                  onItemClicked: (Tag item) {
                    context.router
                        .push(SearchHashTagRoute(hashTag: item.title));
                  },
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildAdvices(BuildContext context, DashboardState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildLabel(
            context,
            label: Strings.suggestions,
          ),
          const SizedBox(height: 16),
          LoaderStateWidget(
              onRetryClicked: () {
                cubit(context).getRecommendations();
              },
              emptyBody: SizedBox(),
              loadingState: state.recommendationsState,
              loadingBody: AdviceListShimmer(),
              successBody: AdviceList(
                recommendations: state.recommendations,
                onItemClicked: (Common item) {
                  context.router.push(ContentDetailRoute(slug: item.slug));
                },
              )),
        ],
      ),
    );
  }

  Widget _buildShorts(BuildContext context, DashboardState state) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFF021433)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: _buildLabel(
                context,
                label: Strings.daryoShorts,
                textColor: Colors.white,
               /* rightIcon: GestureDetector(
                  onTap: () {},
                  child: Strings.viewAll.s(12).c(Colors.white),
                ),*/
              ),
            ),
            SizedBox(height: 12),
            LoaderStateWidget(
                onRetryClicked: () {
                  cubit(context).getShorts();
                },
                emptyBody: SizedBox(),
                loadingState: state.shortsState,
                loadingBody: SizedBox(),
                successBody: ShortsCarousel(shortsList: state.shorts)),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildAutoNews(BuildContext context, DashboardState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildLabel(
            context,
            label: Strings.auto,
            rightIcon: GestureDetector(
              onTap: () {
                context.router.push(CategoryHashTagRoute(hashTag: Strings.avtoSlug, title: Strings.auto,));
              },
              child: Strings.viewAll.s(12).c(context.colors.primary),
            ),
          ),
          const SizedBox(height: 16),
          LoaderStateWidget(
              onRetryClicked: () {
                cubit(context).getAutoNews();
              },
              emptyBody: SizedBox(),
              loadingState: state.autoNewsState,
              loadingBody: AdviceListShimmer(),
              successBody: AdviceList(
                recommendations: state.autoNews,
                onItemClicked: (Common item) {
                  context.router.push(ContentDetailRoute(slug: item.slug));
                },
              )),
        ],
      ),
    );
  }

  Widget _buildVideos(BuildContext context, DashboardState state) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFF021433)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: Column(
          children: [
            _buildLabel(
              context,
              label: Strings.videos,
              textColor: Colors.white,
              rightIcon: GestureDetector(
                onTap: () {},
                child: Strings.viewAll.s(12).c(context.textPrimary),
              ),
            ),
            SizedBox(height: 16),
            LoaderStateWidget(
                onRetryClicked: () {
                  cubit(context).getVideos();
                },
                emptyBody: SizedBox(),
                loadingState: state.videosState,
                loadingBody: SizedBox(),
                successBody: VideosList(videos: state.videos)),
          ],
        ),
      ),
    );
  }

  Widget _buildLatestNews(BuildContext context, DashboardState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildLabel(
            context,
            label: Strings.latestNews,
           /* rightIcon: GestureDetector(
              onTap: () {},
              child: Strings.viewAll.s(12).c(context.colors.primary),
            ),*/
          ),
          const SizedBox(height: 16),
          LoaderStateWidget(
              onRetryClicked: () {
                cubit(context).getLatestNews();
              },
              emptyBody: SizedBox(),
              loadingState: state.latestNewsState,
              loadingBody: AdviceListShimmer(),
              successBody: AdviceList(
                recommendations: state.latestNews,
                onItemClicked: (Common item) {
                  context.router.push(ContentDetailRoute(slug: item.slug));
                },
              )),
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context, {required String label, Widget? rightIcon, Color? textColor}) {
    return Row(
      children: [
        SizedBox(
          width: 2,
          height: 26,
          child: ColoredBox(color: context.colors.primary),
        ),
        SizedBox(width: 4),
        Expanded(child: Text(label).s(16).w(600).c(textColor ?? context.textPrimary)),
        if (rightIcon != null) rightIcon,
      ],
    );
  }

  Widget _buildSubscription(BuildContext context, DashboardState state){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: () {},
        child: SubscriptionCard(
          icon: Assets.imagesDaryo.icTicketCrown.svg(),
          title: Strings.individualApproach,
          subtitle: Strings.adFreeReading,
          buttonText: Strings.subscribe,
          buttonColor: context.colors.primary,
          borderColor: context.inputStrokeInactiveColor,
          price: '25 000 ${Strings.currencySom}',
          priceSubtitle: Strings.perMonth,
          onItemClicked: (){
            context.router.push(TariffsRoute());
          },
        ),
      ),
    );
  }
}
