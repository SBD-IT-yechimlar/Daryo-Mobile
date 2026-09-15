import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/features/home/features/account/features/tariffs/tariffs_cubit.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/errors/full_screen_error.dart';
import 'package:daryo/presentation/widgets/loading/loader_state_widget.dart';
import 'package:daryo/presentation/widgets_daryo/tariff/tariff_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/gen/localization/strings.dart';
import '../../../../../../widgets/app_bar/default_app_bar.dart';


@RoutePage()
class TariffsPage extends BasePage<TariffsCubit, TariffsState, TariffsEvent> {
  const TariffsPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, TariffsState state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        titleText: "anj",
        titleTextColor: Colors.black,
        backgroundColor: Colors.white,
        onBackPressed: () => context.router.pop(),
        context: context,
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
                                  "Daryo.uz cheksiz mutolaa uchun",
                                  textAlign: TextAlign.center,
                                ).s(20).w(500),
                                SizedBox(height: 16),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 30.0),
                                  child: Text(
                                    "Cheksiz kirish imkoniyati bilan faktlar, ekspert tahlillari va fikrlari va boshqalardan xabardor bo'ling.",
                                    textAlign: TextAlign.center,
                                  ).c(Color(0xFF6C7278)),
                                ),
                                SizedBox(height: 26),
                              ],
                            ),
                          ),
                          LoaderStateWidget(
                            errorBody: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: FullScreenErrorWidget(
                                  onItemClicked: (){
                                    cubit(context).getTariffs();

                                  }),
                            ),
                            loadingState: state.loadingState,
                            loadingBody: _loadingView(context),
                            successBody:  TariffsCarousel(tariffs: state.tariffs),)
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
                      Text("Barcha huquqlar himoyalangan!")
                          .s(12)
                          .w(500)
                          .c(Color(0xFF6C7278)),
                      GestureDetector(
                        onTap: () {},
                        child: Text("Ommaviy oferta")
                            .s(12)
                            .w(600)
                            .c(context.colors.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.red,

          )
        ],
      ),
    );
  }
  Widget _loadingView(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 250.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFDFF1FF).withOpacity(0.6),
            ),
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation(Color(0xFF0089DA)),
            ),
          ),
          SizedBox(height: 24),
          Strings.dataLoading.s(14).w(500).c(Color(0xFF6C7278)).a(TextAlign.center),
        ],
      ),
    );
  }

}
