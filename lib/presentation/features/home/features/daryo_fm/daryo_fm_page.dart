import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import '../../../../../core/gen/localization/strings.dart';
import '../../../../../domain/models_daryo/daryo_fm/darto_fm_item.dart';
import '../../../../support/colors/static_colors.dart';
import '../../../../widgets/button/custom_elevated_button.dart';
import '../../../../widgets/appbar/image_app_bar.dart';
import '../../../../widgets/daryo_fm/daryo_fm_item.dart';
import '../../../../widgets/daryo_fm/daryo_fm_item_shimmer.dart';
import '../../../../widgets/errors/full_screen_error.dart';
import '../../../../widgets/radyo_fm/radyo_fm.dart';
import 'daryo_fm_cubit.dart';

@RoutePage()
class DaryoFmPage extends BasePage<DaryoFmCubit, DaryoFmState, DaryoFmEvent> {
   DaryoFmPage({super.key});

  @override
  void onEventEmitted(BuildContext context, DaryoFmEvent event) async {
    switch (event.type) {
      case DaryoFmEventType.lostConnection:
        final result = await context.router.push(LostConnectionRoute());
        if (result == true) {
          cubit(context).refresh();
        }
    }
  }

   Future<void> Function()? _radioPlayPause;
  @override
  Widget onWidgetBuild(BuildContext context, DaryoFmState state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: ImageAppBar(
        context: context,
        titleText: "",
        titleTextColor: Colors.black,
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      floatingActionButton: state.runningFm!=null? Visibility(
        visible: state.runningFm!=null,
        child: RadioFm(
          item: state.runningFm,
          onNextClicked: () {
            Logger().d("onNextClicked");
            cubit(context).onNextClicked();
          },
          onPreviousClicked: () {
            cubit(context).onPreviousClicked();
          },
          onPlayPauseChanged: (DaryoFm value) {
            Logger().w("${value.id}  ${value.isPlaying}");
          },
          onPlayerReady: (Future<void> Function() playPauseFunction) {
            _radioPlayPause = playPauseFunction;
          },
          setInitialPlay: (DaryoFm? daryoFm) {
             cubit(context).setInitialFm(daryoFm);
          },
          onPause: (DaryoFm? daryoFm) {
           cubit(context).onPause(daryoFm);
          },
          onResume:(DaryoFm? daryoFm) {
            cubit(context).setInitialFm(daryoFm);
          },
        ),
      ):SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding:  EdgeInsets.only(bottom: state.runningFm==null?0:140,top: 10,right: 6,left: 6),
        child: RefreshIndicator(
          displacement: 80,
          strokeWidth: 3,
          color: StaticColors.colorPrimary,
          onRefresh: () async {
            cubit(context).refresh();
          },

          child: PagedListView<int,DaryoFm>(
            shrinkWrap: false,
            addAutomaticKeepAlives: true,
            physics: BouncingScrollPhysics(),
            pagingController: state.controller!,
            builderDelegate: PagedChildBuilderDelegate<DaryoFm>(
              firstPageErrorIndicatorBuilder: (_) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: FullScreenErrorWidget(
                      onItemClicked: () {
                        cubit(context).refresh();
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
                      return DaryoFmShimmerWidget();
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
                  padding: EdgeInsets.only(right: 8.0, left: 8, top: 8, bottom: 50.h),
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xFFEDF1F3), borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                return DaryoFmWidget(onItemClicked: (item){
                //  Logger().w("item ${item.id} isPlaying ${item.isPlaying}");
                  cubit(context).setAudio(item);
                  _radioPlayPause!();
                },
                    item: item);
              },
            ),
          ),
        ),
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
}
