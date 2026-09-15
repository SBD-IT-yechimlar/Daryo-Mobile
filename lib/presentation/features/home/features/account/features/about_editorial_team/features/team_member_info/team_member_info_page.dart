import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/account/custom_container.dart';
import 'package:daryo/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../core/gen/assets/assets.gen.dart';
import 'team_member_info_cubit.dart';

@RoutePage()
class TeamMemberInfoPage extends BasePage<TeamMemberInfoCubit, TeamMemberInfoState, TeamMemberInfoEvent> {
  const TeamMemberInfoPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, TeamMemberInfoState state) {
    List<Widget> socialMedia = [
      Assets.imagesDaryo.icTelegram.svg(),
      Assets.imagesDaryo.icInstagramm.svg(),
      Assets.imagesDaryo.icXTwitter.svg(),
    ];

    return Material(
      child: Scaffold(
        /*appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Assets.imagesDaryo.icEditProfileArrowLeft.svg(),
              "Tahririyat".s(16).w(700).c(Color(0xFF1A1C1E)),
              SizedBox.shrink(),
            ],
          ),
        ),*/
        appBar: DefaultAppBar(
            titleText: "Tahririyat",
            titleTextColor: context.textPrimary,
            backgroundColor: context.backgroundColor,
            onBackPressed: () {},
            context: context),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Assets.imagesDaryo.pngImages.img.image(fit: BoxFit.cover),
                  ),
                  SizedBox(height: 20),
                  "Azizbek Abduvaliyev".s(20).w(500).c(context.textPrimary),
                  SizedBox(height: 8),
                  "Muxbir".s(16).w(400).c(context.textSecondary),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: socialMedia,
                  ),
                  SizedBox(height: 16),
                  """Olimjon Safoyev 1987 yil Toshkent shahrida tug'ilgan. Millati – o'zbek. Ma'lumoti – oliy. 2011-2015 yillarda O'zbekiston davlat san'at va madaniyat instituti bakalavriatini, 2015-2017 yillarda magistraturani tamomlagan. Olimjon Safoyev 2019 yilning mart oyidan buyon Daryo.uz internet nashri muxbiri o'laroq faoliyat boshladi."""
                      .s(12)
                      .w(400)
                      .c(context.textSecondary)
                      .copyWith(overflow: TextOverflow.clip, softWrap: true),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: CustomContainer(crossAxisAlignmentCenter: false, children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Assets.imagesDaryo.icTeamMemberInfoTaskScuare.svg(),
                                Column(
                                  children: ["6987".s(20).w(500).c(context.textPrimary), "Maqola".s(12).w(400).c(context.textSecondary)],
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomContainer(crossAxisAlignmentCenter: false, children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Assets.imagesDaryo.icTeamMemberInfoEye.svg(),
                                Expanded(
                                  child: Column(
                                    children: [
                                      "98 ming+".s(20).w(500).c(context.textPrimary).copyWith(overflow: TextOverflow.ellipsis, softWrap: true),
                                      "Ko‘rishlar soni".s(12).w(400).c(context.textSecondary).copyWith(overflow: TextOverflow.ellipsis, softWrap: true)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                    ],
                  ),
                  SizedBox(height: 50)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
