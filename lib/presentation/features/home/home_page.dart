import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/core/gen/localization/strings.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/services.dart';

import '../../support/colors/static_colors.dart';
import 'home_cubit.dart';

@RoutePage()
class HomePage extends BasePage<HomeCubit, HomeState, HomeEvent> {
  const HomePage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, HomeState state) {
    bool isDarkMode = context.isDarkMode;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDarkMode ? StaticColors.darkBackground : Colors.transparent,
      systemNavigationBarColor: isDarkMode ? Color(0xFF1F2937): context.appBarColor,
      statusBarIconBrightness: isDarkMode ? Brightness.dark : Brightness.light,
    ));
    return AutoTabsRouter(
      routes: [
        DashboardRoute(),
        RecommendationsRoute(),
        AdCreationChooserRoute(),
        VideosRoute(),
        DaryoFmRoute()
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: child,
          bottomNavigationBar: BottomNavigationBar(
              enableFeedback: true,
              type: BottomNavigationBarType.fixed,
              elevation: 1,
              selectedItemColor: const Color(0xFF0089DA),
              unselectedItemColor: Color(0xFFACB5BB),
              backgroundColor: context.bottomBarColor,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
              currentIndex: tabsRouter.activeIndex,
              onTap: (index) {
                HapticFeedback.lightImpact();
                tabsRouter.setActiveIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  label: Strings.home,
                  tooltip: Strings.bottomNavigationHome,
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.imagesv2.bottomBar.dashbaord.svg(),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.imagesv2.bottomBar.dashbaordActive.svg(),
                  ),
                ),
                BottomNavigationBarItem(
                  label: Strings.bottomNavbarFeed,
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.imagesv2.bottomBar.slider.svg(),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.imagesv2.bottomBar.sliderActive.svg(),
                  ),
                ),
                BottomNavigationBarItem(
                  label: Strings.menu,
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.imagesv2.bottomBar.menu
                        .svg(height: 22, width: 22),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.imagesv2.bottomBar.menuActive.svg(),
                  ),
                ),
                BottomNavigationBarItem(
                  label: Strings.videos,
                  tooltip: Strings.videos,
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Assets.imagesv2.bottomBar.vidioActive.svg(height: 22, width: 22),
                  ),
                  icon:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.imagesv2.bottomBar.video
                        .svg(height: 22, width: 22),
                  ),
                ),
                BottomNavigationBarItem(
                  label: Strings.daryoFm,
                  tooltip: Strings.daryoFm,
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.imagesv2.bottomBar.radio.svg(),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.imagesv2.bottomBar.activeRadio.svg(),
                  ),
                )
              ]),
        );
      },
    );
  }
}
