import 'package:auto_route/auto_route.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/app_bar/action_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../../core/gen/localization/strings.dart';
import '../../../../../../../domain/models/language/language.dart';
import '../../../../../../widgets/account/custom_elevated_button.dart';
import '../../../../../../widgets/language/language_button.dart';
import 'select_language_app_cubit.dart';

@RoutePage()
class SelectLanguageAppPage extends BasePage<SelectLanguageAppCubit, SelectLanguageAppState, SelectLanguageAppEvent> {
  const SelectLanguageAppPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, SelectLanguageAppState state) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: ActionAppBar(
            iconColor: context.textPrimary,
            titleText: Strings.languageSetTitle,
            titleTextColor: context.textPrimary,
            backgroundColor: Colors.white,
            onBackPressed: (){}),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          LanguageButton(
                            text: "Uzbek (UZ)",
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              cubit(context).setLanguage(Language.uzbekLatin);
                              EasyLocalization.of(context)?.setLocale(Locale('uz', 'UZ'));
                            },
                            isSelected: Strings.daryoUz=="uz",
                            icon: Assets.images.flagUzb.svg(width: 20, height: 15),
                          ),
                          SizedBox(height: 16),
                          LanguageButton(
                            text: "Русский (RU)",
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              cubit(context).setLanguage(Language.russian);
                              EasyLocalization.of(context)
                                  ?.setLocale(Locale('ru', 'RU'));
                            },
                            isSelected: Strings.daryoUz=="ru",
                            icon: Assets.images.flagRus.svg(),
                          ),
                          SizedBox(height: 16),
                          LanguageButton(
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              cubit(context).setLanguage(Language.english);
                              EasyLocalization.of(context)?.setLocale(Locale('en', 'EN'));
                            },
                            isSelected: Strings.daryoUz=="en",
                            icon:Assets.images.flagEn.svg(),
                            text: "English (EN)",
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    )),
                CustomElevatedButton(
                  text: Strings.commonSave,
                  onPressed: () {
                    context.router.pop();

                  },
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
