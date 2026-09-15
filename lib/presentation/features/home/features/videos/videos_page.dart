import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../core/gen/localization/strings.dart';
import '../../../../router/app_router.dart';
import '../../../../support/colors/static_colors.dart';
import '../../../../widgets/appbar/image_app_bar.dart';
import '../../../../widgets/common/more_load_button.dart';
import '../../../../widgets/common/sending_toast.dart';
import '../../../../widgets/dashboard/carousel/slider_item_shimmer.dart';
import '../../../../widgets/dashboard/recommendation/rec_item.dart';
import '../../../../widgets/dashboard/recommendation/recommendation_shimmer_list.dart';
import '../../../../widgets/errors/full_screen_error.dart';
import '../../../../widgets/image/rounded_cached_network_image_widget.dart';
import '../../../../widgets/loading/loader_state_widget.dart';
import '../../../../widgets/videos/video_viewer_dialog.dart';
import '../../../../widgets/videos_nav_bar/nav_bar_video_item.dart';
import 'videos_cubit.dart';

@RoutePage()
class VideosPage extends BasePage<VideosCubit, VideosState, VideosEvent> {
  const VideosPage({super.key});

  @override
  void onEventEmitted(BuildContext context, VideosEvent event) async {
    switch (event.type) {
      case VideosEventType.handleError:
        showAppToast(
          context,
          event.text ?? Strings.dataLoadError,
        );
        break;
      case VideosEventType.lostConnection:
        final result = await context.router.push(LostConnectionRoute());
        if (result == true) {
          cubit(context).getInitialData();
        }
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, VideosState state) {
    return Scaffold(
      appBar: ImageAppBar(
        context: context,
        titleText: "",
        titleTextColor: Colors.black,
        backgroundColor: context.backgroundColor,
        onBackPressed: () {},
      ),
      backgroundColor: context.backgroundColor,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RefreshIndicator(
            displacement: 80,
            strokeWidth: 3,
            color: StaticColors.colorPrimary,
            onRefresh: () async {
              cubit(context).reload();
              cubit(context).getInitialData();
            },
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _buildVideos(context, state),
                    ],
                  ),
                ),
                SliverPadding(padding: EdgeInsets.symmetric(horizontal: 16)),
              ],
            ),
          )),
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

  Widget _buildVideos(BuildContext context, VideosState state) {
    return Column(
      children: [
        _buildLabel(
          context,
          textColor: context.textPrimary,
          label: Strings.videos,
        ),
        SizedBox(height: 16),
        LoaderStateWidget(
            onRetryClicked: () {
              cubit(context).getVideos();
            },
            emptyBody: SizedBox(
                height: MediaQuery.of(context).size.height*0.8,
                child: Center(child: Strings.emptyData.s(12).w(500).c(context.textPrimary))),
            errorBody: FullScreenErrorWidget(onItemClicked: () {
              cubit(context).getVideos();
            }),
            loadingState: state.videosState,
            loadingBody: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [SliderItemShimmer(), SizedBox(height: 12.h),
                DashboardCommonListShimmer()],
            ),
            successBody: Column(
              children: [
                firstVideo(context, state),
                SizedBox(height: 12),
                videoList(context, state),
                SizedBox(height: 10),
                if (state.haveMore)
                  LoadMoreButton(
                    onLoadMore: () {
                      cubit(context).getMoreLoad();
                    },
                  ),
                SizedBox(height: 20),
              ],
            )),
      ],
    );
  }

  Widget firstVideo(BuildContext context, VideosState state) {
    final firstVideo = state.videos.firstOrNull;
    return Column(
      children: [
        if (firstVideo != null)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  opaque: false, // background opacity ishlashi uchun
                  pageBuilder: (_, __, ___) => Stack(
                    children: [
                      Container(color: Colors.black38), // opacity fon
                      Center(
                        child: VideoViewerDialog(video: firstVideo, parentContext: context),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  aspectRatio: 327 / 200,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: RoundedCachedNetworkImage(
                          imageId: firstVideo.image,
                          width: 110,
                          borderRadius: 16,
                          height: 80,
                        ),
                      ),
                      Center(child: Assets.imagesDaryo.button.svg(height: 80)),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  firstVideo.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ).s(14).w(500).c(context.textPrimary),
                SizedBox(height: 12),
                Row(
                  children: [
                    "".s(12).w(500).c(context.colors.primary),
                    Spacer(),
                    Assets.imagesDaryo.clock.svg(),
                    SizedBox(width: 4),
                    Text(formatDate(firstVideo.date)).s(12).w(400).c(context.textSecondary),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget videoList(BuildContext context, VideosState state) {
    final firstVideo = state.videos.firstOrNull;
    return Column(
      children: [
        if (firstVideo != null)
          ...List.generate(state.videos.length, (index) {
            final video = state.videos[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: VideoNabBarItem(video: video),
            );
          })
      ],
    );
  }
}
