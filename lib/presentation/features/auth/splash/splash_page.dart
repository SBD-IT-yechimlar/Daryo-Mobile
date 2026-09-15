import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'splash_cubit.dart';

@RoutePage()
class SplashPage extends BasePage<SplashCubit, SplashState, SplashEvent> {
  SplashPage({super.key,});

/*  @override
  void onWidgetCreated(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xFF0089DA),
        statusBarIconBrightness: Brightness.light,
      ),
    );
    super.onWidgetCreated(context);
  }*/

  @override
  void onEventEmitted(BuildContext context, SplashEvent event) {
    switch(event.type){
      case SplashEventType.navigateSetLanguage:
        EasyLocalization.of(context)?.setLocale(Locale('uz', 'UZ'));
        context.replaceRoute(SetLanguageRoute());
        bool isDarkMode = context.isDarkMode;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: isDarkMode ? Colors.white : Colors.transparent,
          systemNavigationBarColor: isDarkMode ? Colors.white : context.appBarColor,
          statusBarIconBrightness: isDarkMode ? Brightness.dark : Brightness.light,
        ));
      case SplashEventType.onOpenHome:
        context.router.pushAndPopUntil(DashboardRoute(), predicate: (Route<dynamic> route) => route is DashboardRoute);
        bool isDarkMode = context.isDarkMode;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: isDarkMode ? Colors.white : Colors.transparent,
          systemNavigationBarColor: isDarkMode ? Colors.white : context.appBarColor,
          statusBarIconBrightness: isDarkMode ? Brightness.dark : Brightness.light,
        ));
    }
  }
  @override
  Widget onWidgetBuild(BuildContext context, SplashState state) {
   return  Scaffold(
        backgroundColor: Color(0xFF0089DA),
        body:  Stack(
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
        )
      );

  }
}
