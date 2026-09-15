import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/localization/strings.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../widgets/app_bar/default_app_bar.dart';
import 'internet_publication_cubit.dart';

@RoutePage()
class InternetPublicationPage extends BasePage<InternetPublicationCubit, InternetPublicationState, InternetPublicationEvent> {
  const InternetPublicationPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, InternetPublicationState state) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: DefaultAppBar(
        context: context,
        titleText: Strings.onlineEdition,
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
                """“Daryo” internet-nashri 2013-yilning yanvar oyidan buyon faoliyat ko‘rsatadi. 
                \nShiorimiz:“Yangiliklar daryosidan chetda qolmang!”."""
                    .s(14)
                    .w(500)
                    .c(context.textPrimary)
                    .copyWith(
                      overflow: TextOverflow.clip,
                      softWrap: true,
                    ),
                SizedBox(height: 20),
                """“Daryo” — bu jahonda va O‘zbekistonda sodir bo‘layotgan eng so‘nggi yangiliklarni o‘quvchilarga sodda va tushunarli tilda hamda tezkor yetkazib berishga mo‘ljallangan internet-nashr."""
                    .s(12)
                    .w(400)
                    .c(context.textSecondary)
                    .copyWith(overflow: TextOverflow.clip, softWrap: true),
                SizedBox(height: 20),
                """“Daryo” internet-nashri O‘zbekistondagi yetakchi ommaviy axborot vositalaridan biri hisoblanadi."""
                    .s(12)
                    .w(400)
                    .c(context.textSecondary)
                    .copyWith(overflow: TextOverflow.clip, softWrap: true),
                SizedBox(height: 20),
                """“Daryo” 2013-yilda Uz Milliy domeni internet-festivalida “Yil yangiligi” nominatsiyasi bo‘yicha 3-oʻrinni egallagan. 2014-yilda Uz domeni internet-festivalining eng ommabop OAV sayti yoʻnalishida birinchi oʻringa loyiq topilgan."""
                    .s(12)
                    .w(400)
                    .c(context.textSecondary)
                    .copyWith(overflow: TextOverflow.clip, softWrap: true),
                SizedBox(height: 20),
                """Nashr yangiliklarini 1 oyda 4 milliondan ortiq kishi o‘qiydi. Saytdagi ko‘rishlar soni esa 1 oyda 21 milliondan oshadi."""
                    .s(12)
                    .w(400)
                    .c(context.textSecondary)
                    .copyWith(overflow: TextOverflow.clip, softWrap: true),
                SizedBox(height: 20),
                """Bugungi kunda nashrda 50 dan ortiq tajribali, taniqli yosh jurnalistlar, shuningdek, muharrir hamda musahhihlar faoliyat olib boradi."""
                    .s(12)
                    .w(400)
                    .c(context.textSecondary)
                    .copyWith(overflow: TextOverflow.clip, softWrap: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
