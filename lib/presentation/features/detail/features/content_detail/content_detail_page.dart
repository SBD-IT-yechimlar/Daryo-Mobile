import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/domain/models_daryo/tags/tag.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/dashboard/tags/tags_list.dart';
import 'package:daryo/presentation/widgets/errors/full_screen_error.dart';
import 'package:daryo/presentation/widgets/image/rounded_cached_network_image_widget.dart';
import 'package:daryo/presentation/widgets/loading/loader_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../domain/models_daryo/recommendation/recommendation.dart';
import '../../../../widgets/common/more_load_button.dart';
import '../../../../widgets/common/sending_toast.dart';
import '../../../../widgets/dashboard/advice/advice_list.dart';
import '../../../../widgets/dashboard/advice/advice_list_shimmer.dart';
import '../../../../widgets/dashboard/carousel/slider_item_shimmer.dart';
import '../../../../widgets/dashboard/recommendation/rec_item.dart';
import '../../../../widgets/dashboard/recommendation/rec_shimmer_list.dart';
import '../../../../widgets/dashboard/recommendation/recommendation_shimmer_list.dart';
import '../../../../widgets/dashboard/tags/tags_shimmer_list.dart';
import '../../../../widgets/html/custom_html.dart';
import 'content_detail_cubit.dart';

@RoutePage()
class ContentDetailPage extends BasePage<ContentDetailCubit, ContentDetailState,
    ContentDetailEvent> {
  const ContentDetailPage({
    super.key,
    required this.slug,
  });

  @override
  void onEventEmitted(BuildContext context, ContentDetailEvent event) async {
    switch (event.type) {
      case ContentDetailEventType.handleError:
        showAppToast(
          context,
          event.text ?? "Malumotlar yuklashda xatolim yuz berdi",
        );
        break;
      case ContentDetailEventType.lostConnection:
        final result = await context.router.push(LostConnectionRoute());
        if (result == true) {
          cubit(context).reload(slug);
        }
      case ContentDetailEventType.likedSuc:
        throw UnimplementedError();
      case ContentDetailEventType.likedUnSec:
        showAppToast(
          context,
          event.text??"",
        );
    }
  }

  final String slug;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).getInitialData(slug);
    super.onWidgetCreated(context);
  }

  @override
  Widget onWidgetBuild(BuildContext context, state) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        backgroundColor: context.backgroundColor,
        actionsPadding: EdgeInsets.only(right: 12),
        actions: [
        /*  IconButton(
            icon: Assets.imagesDaryo.save.svg(
                colorFilter:
                    ColorFilter.mode(context.iconPrimary, BlendMode.srcIn)),
            onPressed: () {
              HapticFeedback.lightImpact();
            },
          ),*/

          Builder(builder: (context) {
            return IconButton(
              icon: Assets.imagesDaryo.share.svg(
                  colorFilter: ColorFilter.mode(context.iconPrimary, BlendMode.srcIn)),
              onPressed: () {
                Logger().w("${"https://daryo.uz/$slug"}");
                final box = context.findRenderObject() as RenderBox?;
                Share.share("https://daryo.uz/$slug",
                    sharePositionOrigin:
                        box!.localToGlobal(Offset.zero) & box.size);
                HapticFeedback.lightImpact();
              },
            );
          }),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: IconButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              context.router.pop();
            },
            icon: Assets.imagesDaryo.back.svg(
                colorFilter:
                    ColorFilter.mode(context.iconPrimary, BlendMode.srcIn)),
          ),
        ),
      ),
      bottomNavigationBar: _footerWidget(context, state),
      body: SingleChildScrollView(
        child: LoaderStateWidget(
          onRetryClicked: () {
            cubit(context).reload(slug);
          },
          errorBody: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FullScreenErrorWidget(onItemClicked: () {
              cubit(context).reload(slug);
            }),
          ),
          emptyBody: SizedBox(),
          loadingBody: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              CarouselSlider.builder(
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
              SizedBox(height: 12.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: context.shimmerBaseColor,
                      highlightColor: context.shimmerHighLightColor,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        width: 300.w,
                        height: 20,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Shimmer.fromColors(
                      baseColor: context.shimmerBaseColor,
                      highlightColor: context.shimmerHighLightColor,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        width: 200.w,
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.h, right: 20, left: 20),
                child: TagsShimmer(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20),
                child: DashboardCommonListShimmer(),
              )
            ],
          ),
          loadingState: state.contentLoadingState,
          successBody: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 327 / 180,
                  child: RoundedCachedNetworkImage(
                    imageId: state.detail.images.firstOrNull?.path ?? "",
                    borderRadius: 16,
                  ),
                ),
                SizedBox(height: 16),
                Text(state.detail.title).s(20).w(700).c(context.textPrimary),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                        child: Text(state.detail.category)
                            .s(14)
                            .w(500)
                            .c(context.colors.primary)),
                    Row(
                      children: [
                        Assets.images.icCalendar.svg(),
                        SizedBox(width: 5),
                        Text(formatDate(state.detail.date))
                            .s(14)
                            .w(400)
                            .c(context.textSecondary),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                StyledHtmlContent(
                  content: state.detail.content,
                  onTapUrl: (url) async {
                    openUrl(url);
                    return true;
                  },
                ),

                ///hashtags
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: TagsList(
                      tags: state.detail.hashtag
                          .split(", ")
                          .map((e) => Tag(title: e))
                          .toList(),
                      onItemClicked: (Tag item) {
                        context.router
                            .push(SearchHashTagRoute(hashTag: item.title));
                      },
                    ),
                  ),
                ),
                _buildLabel(context, label: "Mavzuga doir yangiliklar"),
                SizedBox(height: 16),
                _relatedNews(context, state),
                _buildLatestNews(context, state),
                _buildAdvices(context, state)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context,
      {required String label, Widget? rightIcon, Color? textColor}) {
    return Row(
      children: [
        SizedBox(
          width: 2,
          height: 26,
          child: ColoredBox(color: context.colors.primary),
        ),
        SizedBox(width: 4),
        Expanded(
            child:
                Text(label).s(16).w(600).c(textColor ?? context.textPrimary)),
        if (rightIcon != null) rightIcon,
      ],
    );
  }

  Widget _buildLatestNews(BuildContext context, ContentDetailState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(
          context,
          label: "So'ngi yangiliklar",
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
          ),
        ),
      ],
    );
  }

  Widget _buildAdvices(BuildContext context, ContentDetailState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildLabel(
          context,
          label: "Tavsiyalar",
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
    );
  }

  Widget _relatedNews(BuildContext context, ContentDetailState state) {
    return LoaderStateWidget(
      onRetryClicked: () {
        cubit(context).getRelatedNews(state.tag);
      },
      emptyBody: SizedBox(),
      loadingState: state.relatedNewsState,
      loadingBody: DashboardCommonListShimmer(),
      successBody: Column(
        children: [
          DashboardCommonList(
            recommendations: state.relatedNewsList,
            onItemClicked: (Common item) {
              context.router.push(ContentDetailRoute(slug: item.slug));
            },
          ),
          if (state.haveMore && state.relatedNewsList.length > 3)
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: LoadMoreButton(
                onLoadMore: () {
                  cubit(context).getMoreLoadRelatedNews();
                },
              ),
            ),
        ],
      ),
    );
  }

  Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);

    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
      debugPrint('❌ URL ochilmadi: $url');
    }
  }

  Widget _footerWidget(BuildContext context, ContentDetailState state) {
    return LoaderStateWidget(
        onRetryClicked: () {},
        emptyBody: SizedBox(),
        errorBody: SizedBox(),
        loadingBody: SizedBox(),
        loadingState: state.contentLoadingState,
        successBody: Container(
          decoration: BoxDecoration(
            color: context.containerBackground,
            boxShadow: const [
              BoxShadow(
                color: Color(0x20111827),
                blurRadius: 4,
                offset: Offset(0, -2),
              )
            ],
          ),
          padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 10,
              bottom: Platform.isIOS ? 25.h : 15.h),
          child: Row(
            children: [
              Container(
                height: 44,
                width: 142,
                decoration: BoxDecoration(
                    color: context.backgroundColor,
                    borderRadius: BorderRadius.circular(100)),
                child: Row(
                  children: [
                    Flexible(
                        child: GestureDetector(
                      onTap: () {
                        cubit(context).likeOrDislike("like");
                        HapticFeedback.mediumImpact();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: context.backgroundColor,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        height: 44,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Assets.imagesv2.icLike.svg(),
                            SizedBox(width: 3),
                            state.like
                                .toString()
                                .s(12)
                                .w(400)
                                .c(context.textSecondary)
                          ],
                        ),
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        width: 1,
                        color: context.iconPrimary,
                      ),
                    ),
                    Flexible(
                        child: GestureDetector(
                      onTap: () {
                        cubit(context).likeOrDislike("dislike");
                        HapticFeedback.mediumImpact();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: context.backgroundColor,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        height: 44,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Assets.imagesv2.icDislike.svg(),
                            SizedBox(width: 3),
                            state.dislike
                                .toString()
                                .s(12)
                                .w(400)
                                .c(context.textSecondary)
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              const Spacer(),
             /* IconButton(
                onPressed: () {
                  context.router.push(CommentRoute());
                },
                icon: Badge(
                  label: Text("1").w(400).c(context.textPrimary),
                  child: Assets.imagesDaryo.messages.svg(),
                ),
              ),*/
            ],
          ),
        ));
  }
}
