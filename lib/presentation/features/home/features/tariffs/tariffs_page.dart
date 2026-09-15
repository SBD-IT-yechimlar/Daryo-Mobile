import 'package:auto_route/auto_route.dart';
import 'package:blur/blur.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/localization/strings.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/loading/loader_state_widget.dart';
import 'package:daryo/presentation/widgets_daryo/tariff/tariff_item.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/app_bar/default_app_bar.dart';
import 'tariffs_cubit.dart';

@RoutePage()
class TariffsPage extends BasePage<TariffsCubit, TariffsState, TariffsEvent> {
  const TariffsPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, TariffsState state) {
    // final tariffs = [
    //   Tariff(
    //     isTop: true,
    //     title: "Daryo 5",
    //     description:
    //         "\"Ko‘proq xabardorlikni xohlovchilar uchun. Daryo 5 obunasi sizga 5 ta yangilikni o‘qish imkonini beradi. Muhim voqealarni kuzatib borish uchun yetarli hajm.\"",
    //     price: 5000,
    //     buttonText: "Daryo 5 ni oling",
    //   ),
    //   Tariff(
    //     isTop: false,
    //     title: "Daryo 10",
    //     description:
    //         "\"Ko‘proq xabardorlikni xohlovchilar uchun. Daryo 5 obunasi sizga 5 ta yangilikni o‘qish imkonini beradi. Muhim voqealarni kuzatib borish uchun yetarli hajm.\"",
    //     price: 9000,
    //     buttonText: "Daryo 10 ni oling",
    //   ),
    //   Tariff(
    //     isTop: false,
    //     title: "Daryo Unlimited",
    //     description:
    //         "\"Ko‘proq xabardorlikni xohlovchilar uchun. Daryo 5 obunasi sizga 5 ta yangilikni o‘qish imkonini beradi. Muhim voqealarni kuzatib borish uchun yetarli hajm.\"",
    //     price: 15000,
    //     buttonText: "Daryo Unlimited ni oling",
    //   ),
    // ];
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: DefaultAppBar(
        context: context,
        titleText: Strings.tariffs,
        titleTextColor: context.textPrimary,
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 16),
                                Text(
                                  Strings.daryoUnlimited,
                                  textAlign: TextAlign.center,
                                ).s(20).w(500).c(context.textPrimary),
                                SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Text(
                                    Strings.unlimitedAccess,
                                    textAlign: TextAlign.center,
                                  ).c(context.textSecondary),
                                ),
                                SizedBox(height: 26),
                              ],
                            ),
                          ),
                          LoaderStateWidget(
                            loadingState: state.loadingState,
                            loadingBody: SizedBox(),
                            successBody: TariffsCarousel(tariffs: state.tariffs),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 6,
                    children: [
                      Strings.allRightsReserved.s(12).w(500).c(context.textSecondary),
                      GestureDetector(
                        onTap: () {},
                        child: Strings.publicOffer.s(12).w(600).c(context.colors.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Blur(
                blur: 3,
                blurColor: context.backgroundWhiteColor.withOpacity(0.7),
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: "".s(12).w(400),
                    ),
                  ],
                ),
              ),
              Center(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Strings.inProgressPart.s(16).w(500).c(context.textPrimary).copyWith(textAlign: TextAlign.center),
              ))
            ],
          ),
        ],
      ),
    );
  }
}
