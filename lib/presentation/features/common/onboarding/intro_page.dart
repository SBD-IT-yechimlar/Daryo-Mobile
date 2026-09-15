import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/core/gen/localization/strings.dart';
import 'package:daryo/presentation/features/auth/start/auth_launch_type.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/image/intro_cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import '../../../../data/datasource/network/dto_daryo/banners/banners_response.dart';
import '../../../support/colors/static_colors.dart';
import '../../../widgets/loading/loader_state_widget.dart';
import 'intro_cubit.dart';

@RoutePage()
class IntroPage extends BasePage<IntroCubit, IntroState, IntroEvent> {
  final String? phone;
  final AuthLaunchType authLaunchType;

  IntroPage({super.key, this.phone, this.authLaunchType = AuthLaunchType.launchByDefault});


  final PageController _controller = PageController();
  bool isLastPage = false;
  double progress = 0;

  @override
  void onWidgetCreated(BuildContext context) {
    bool isDarkMode = context.isDarkMode;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDarkMode ? StaticColors.darkBackground : Colors.transparent,
      systemNavigationBarColor: isDarkMode ? Color(0xFF1F2937): context.appBarColor,
      statusBarIconBrightness: isDarkMode ? Brightness.dark : Brightness.light,
    ));
  }


  @override
  Widget onWidgetBuild(BuildContext context, IntroState state) {
    bool isDarkMode = context.isDarkMode;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDarkMode ? StaticColors.darkBackground : Colors.transparent,
      systemNavigationBarColor: isDarkMode ? Color(0xFF1F2937): context.appBarColor,
      statusBarIconBrightness: isDarkMode ? Brightness.dark : Brightness.light,
    ));
    return Scaffold(
      backgroundColor: context.backgroundWhiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: context.backgroundWhiteColor,
        elevation: 0,
        centerTitle: false,
        title: Assets.imagesv2.appabarLogo.svg(width: 94, height: 24),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: TextButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  context.router.pushAndPopUntil(
                    DashboardRoute(),
                    predicate: (route) => route is DashboardRoute,
                  );
                },
                child: Text(Strings.commonSkip)
                    .c(context.textPrimary)
                    .w(500),
              ),
            ),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            Padding(
              padding:  EdgeInsets.only( bottom: Platform.isAndroid? 10:30),
              child: LoaderStateWidget(
                  onRetryClicked: () {},
                  emptyBody: SizedBox(),
                  errorBody: Stack(
                    children: [
                      Assets.images.pngImages.welcoemSplash.image(
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Assets.images.iconD.svg(),
                            SizedBox(height: 15),
                            Assets.images.pngImages.daryo.image(height: 24.h),
                            SizedBox(height: 150.h)
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 0,
                        left: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: context.isDarkMode?Color(0xFF1F2937):Colors.white,
                                    foregroundColor: context.isDarkMode? Colors.white:Color(0xFF0089DA),
                                    minimumSize:  Size(double.infinity, 38.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                      context.router.pushAndPopUntil(
                                        DashboardRoute(),
                                        predicate: (route) => route is DashboardRoute,
                                      );
                                  },
                                  child: (state.index==state.length-1)?Strings.commonStart.s(14).w(500):Strings.commonContinue.s(14).w(500)
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  loadingState:state.introState,
                  loadingBody: Center(child: CircularProgressIndicator()),
                  successBody:  Stack(
                    children: [
                      PageView.builder(
                        controller: _controller,
                        itemCount: state.introData.length,
                        onPageChanged: (index) {
                          cubit(context).setIndex(index);
                          // setState(() => isLastPage = index == pages.length - 1);
                        },
                        itemBuilder: (context, index) {
                          Logger().w("index $index");
                          final page = state.introData["${index+1}"];
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 600),
                            switchInCurve: Curves.easeIn,
                            switchOutCurve: Curves.easeOut,
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: ScaleTransition(scale: animation, child: child),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: ClipRRect(
                                key: ValueKey(page?.image??""), // har bir rasm uchun noyob key
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  children: [
                                    IntroCachedNetworkImage(
                                      errorIcon: Stack(
                                        children: [
                                          Assets.images.pngImages.welcoemSplash.image(
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Assets.images.iconD.svg(),
                                                SizedBox(height: 15),
                                                Assets.images.pngImages.daryo.image(height: 24.h),
                                                SizedBox(height: 150.h)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      imageId: page?.image??"",
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                    Positioned(
                                        bottom: 150,
                                        right: 20,
                                        left: 20,
                                        child:  Html(
                                          data: title(page), // yoki Html bilan ishlash uchun HTML string
                                          style: {
                                            "body": Style(
                                              fontSize: FontSize(32.0),         // s(32)
                                              fontWeight: FontWeight.w700,     // w(700)
                                              color: Colors.white,             // c(Colors.white)
                                            ),
                                          },
                                        ),),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 20,
                        right: 0,
                        left: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 50),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    value: state.index/(state.length-1),
                                    backgroundColor: Colors.grey.shade300,
                                    color: Colors.blue,
                                    minHeight: 6,
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: context.isDarkMode?Color(0xFF1F2937):Colors.white,
                                    foregroundColor: context.isDarkMode? Colors.white:Color(0xFF0089DA),
                                    minimumSize:  Size(double.infinity, 38.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (state.index==state.length-1) {
                                      context.router.pushAndPopUntil(
                                        DashboardRoute(),
                                        predicate: (route) => route is DashboardRoute,
                                      );
                                    } else {
                                      _controller.nextPage(
                                        duration: const Duration(milliseconds: 400),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                  child: (state.index==state.length-1)?Strings.commonStart.s(14).w(500):Strings.commonContinue.s(14).w(500)
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),),
            ),
          ],
        ),
      ),
    );
  }

  String title(DaryoIntroItemResponse? item){
    if(Strings.daryoUz=="uz"){
      return  item?.titleOz??"";
    }
    if(Strings.daryoUz=="ru"){
      return  item?.titleRu??"";
    }
    if(Strings.daryoUz=="en"){
      return  item?.titleEn??"";
    }
    return item?.titleOz??"";
  }

}


