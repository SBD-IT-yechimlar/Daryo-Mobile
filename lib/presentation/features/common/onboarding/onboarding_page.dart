import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/localization/strings.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/button/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/gen/assets/assets.gen.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;
  double _currentPage = 0;

  final pages = [
    {
      "title": "So'nggi yangiliklarni ishonchli manbadan oling.",
      "image":
          "https://i.pinimg.com/736x/41/48/0a/41480a509636fe6714775b2c0ab6422c.jpg"
    },
    {
      "title": "Dunyo voqealarini birinchi bo‘lib bilib oling.",
      "image":
          "https://i.pinimg.com/736x/41/48/0a/41480a509636fe6714775b2c0ab6422c.jpg"
    },
    {
      "title": "Sizga kerakli yangiliklar bir joyda.",
      "image":
          "https://i.pinimg.com/736x/41/48/0a/41480a509636fe6714775b2c0ab6422c.jpg"
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.router.pushAndPopUntil(
          DashboardRoute(),
          predicate: (Route<dynamic> route) => route is DashboardRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_currentPage + 1) / pages.length;

    return Scaffold(
      backgroundColor: context.backgroundWhiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: context.backgroundWhiteColor,
        elevation: 0,
        centerTitle: false,
        title: Container(
            child: Assets.imagesv2.appabarLogo.svg(width: 94, height: 24)),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: TextButton(
                 onPressed: (){
                   HapticFeedback.lightImpact();
                   context.router.pushAndPopUntil(DashboardRoute(), predicate: (Route<dynamic> route) => route is DashboardRoute);
                 },
                  child: Text(Strings.commonSkip).c(context.textPrimary).w(500)),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Positioned.fill(
                  child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                         /* Positioned.fill(
                            child: RoundedCachedNetworkImage(
                              imageId: pages[index]["image"]!,
                            ),
                          ),*/
                          Assets.images.pngImages.welcoemSplash.image(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 110,
                            right: 20,
                            left: 20,
                            child: Text(
                              pages[index]["title"]!,
                            ).w(700).s(28).c(Colors.white),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 26,
                  right: 20,
                  left: 20,
                  child: Column(
                    children: [
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                            thumbShape: SliderComponentShape.noThumb,
                            trackHeight: 4),
                        child: Slider(
                          value: progress.clamp(0.0, 1.0),
                          onChanged: (_) {},
                          activeColor: context.colors.primary,
                          inactiveColor: Color(0xFFACB5BB),
                          padding: EdgeInsets.symmetric(horizontal: 40),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                        buttonHeight: 40,
                        text: Strings.next,
                        onPressed: _onNextPressed,
                        backgroundColor: Colors.white,
                        textColor: context.colors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
