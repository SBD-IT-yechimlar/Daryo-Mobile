import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/localization/strings.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/account/account_item_svg_text.dart';
import 'package:daryo/presentation/widgets/account/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../widgets/app_bar/default_app_bar.dart';
import 'contact_information_cubit.dart';

@RoutePage()
class ContactInformationPage extends BasePage<ContactInformationCubit, ContactInformationState, ContactInformationEvent> {
  const ContactInformationPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, ContactInformationState state) {
    List<Widget> socialMedia = [
      Assets.imagesDaryo.icTelegram.svg(),
      Assets.imagesDaryo.icYoutube.svg(),
      Assets.imagesDaryo.icFacebook.svg(),
      Assets.imagesDaryo.icInstagramm.svg(),
      Assets.imagesDaryo.icXTwitter.svg(),
    ];

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: DefaultAppBar(
        context: context,
        titleText: Strings.contactInfo,
        titleTextColor: context.textPrimary,
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                CustomContainer(crossAxisAlignmentCenter: false, children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      "Tahririyat".s(14).w(500).c(context.textPrimary),
                      SizedBox(height: 16),
                      AccountItemSvgText(title: "info@simple.uz", icon: Assets.imagesDaryo.icContactInfoSms.svg(),color: context.textPrimary,),
                      SizedBox(height: 16),
                      AccountItemSvgText(title: "+998 90 830 71 75", icon: Assets.imagesDaryo.icContactInfoCallCalling.svg(),color: context.textPrimary),
                    ],),
                  )
                ]),
                SizedBox(height: 20),
                CustomContainer(crossAxisAlignmentCenter: false, children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Reklama bo‘limi".s(14).w(500).c(context.textPrimary),
                        SizedBox(height: 16),
                        AccountItemSvgText(title: "+998 90 185 03 93", icon: Assets.imagesDaryo.icContactInfoCallCalling.svg(),color: context.textPrimary),
                        SizedBox(height: 16),
                        AccountItemSvgText(title: "+998 90 185 02 32", icon: Assets.imagesDaryo.icContactInfoCallCalling.svg(),color: context.textPrimary),
                      ],),
                  ),

                ]),
                SizedBox(height: 20),
                CustomContainer(crossAxisAlignmentCenter: false, children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Manzil".s(14).w(500).c(context.textPrimary),
                        SizedBox(height: 16),
                        AccountItemSvgText(
                            title: "100000, Toshkent sh.,Shayxontoxur tumani, Navoiy 30", icon: Assets.imagesDaryo.icContactInfoLocaton.svg(),color: context.textPrimary),
                      ],
                    ),
                  )

                ]),
                SizedBox(height: 20),
                CustomContainer(crossAxisAlignmentCenter: false, children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      "Ish vaqtlari".s(14).w(500).c(context.textPrimary),
                      SizedBox(height: 16),
                      AccountItemSvgText(title: "Dushanba - Juma: 9:00 dan 18:00 gacha", icon: Assets.imagesDaryo.icContactClock.svg(),color: context.textPrimary),

                    ],),
                  )

                ]),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(
                        children: [
                          Container(
                            height: 32,
                            width: 2,
                            color: context.primary,
                          ),
                          SizedBox(width: 6),
                          "Ijtimoiy tarmoqlar".s(16).w(500).c(context.textPrimary),
                        ],
                      ),
                      SizedBox.shrink()
                    ]),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: socialMedia,
                    )
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                  child: Assets.imagesDaryo.pngImages.locationMapYandex.image(height: 200),
                ),
                SizedBox(height: 20.h),
                Column(children: [
                  Assets.images.sbd.svg(color: context.isDarkMode? Colors.white:Color(0xFF1A1C1E)),
                  SizedBox(height: 10),
                  "SBD tomonidan taqdim etilgan".s(14).w(700).c(context.textPrimary),
                  SizedBox(height: 20.h),

                ],)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
