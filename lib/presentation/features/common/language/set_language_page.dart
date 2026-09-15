import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/core/gen/localization/strings.dart';
import 'package:daryo/domain/models/language/language.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/button/custom_elevated_button.dart';
import 'package:daryo/presentation/widgets/language/language_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'set_language_cubit.dart';

// just for push

@RoutePage()
class SetLanguagePage extends BasePage<SetLanguageCubit, SetLanguageState, SetLanguageEvent> {
  const SetLanguagePage({super.key});
  @override
  void onWidgetCreated(BuildContext context) {
    bool isDarkMode = context.isDarkMode;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDarkMode ? Colors.white : Colors.transparent,
      systemNavigationBarColor: isDarkMode ? Colors.white : context.appBarColor,
      statusBarIconBrightness: isDarkMode ? Brightness.dark : Brightness.light,
    ));
    super.onWidgetCreated(context);
  }

  @override
  Widget onWidgetBuild(BuildContext context, SetLanguageState state) {
    bool isDarkMode = context.isDarkMode;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDarkMode ? Colors.white : Colors.transparent,
      systemNavigationBarColor: isDarkMode ? Colors.white : context.appBarColor,
      statusBarIconBrightness: isDarkMode ? Brightness.dark : Brightness.light,
    ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.backgroundWhiteColor,
        elevation: 0,
        centerTitle: true,
        title: Assets.imagesv2.appabarLogo.svg(width: 94, height: 24),
      ),
      backgroundColor: context.backgroundWhiteColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(Strings.languageSetTitle).w(700).s(16).c(context.textPrimary),
              SizedBox(height: 16),
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
                      isSelected: Strings.daryoUz == "uz",
                      icon: Assets.images.flagUzb.svg(width: 20, height: 15),
                    ),
                    SizedBox(height: 16),
                    LanguageButton(
                      text: "Узбек (UZK)",
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        cubit(context).setLanguage(Language.uzbekCyrill);
                        EasyLocalization.of(context)?.setLocale(Locale('uz', 'UZK'));
                      },
                      isSelected: Strings.daryoUz == "uzk",
                      icon: Assets.images.flagUzb.svg(width: 20, height: 15),
                    ),
                    SizedBox(height: 16),
                    LanguageButton(
                      text: "Русский (RU)",
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        cubit(context).setLanguage(Language.russian);
                        EasyLocalization.of(context)?.setLocale(Locale('ru', 'RU'));
                      },
                      isSelected: Strings.daryoUz == "ru",
                      icon: Assets.images.flagRus.svg(),
                    ),
                    SizedBox(height: 16),
                    LanguageButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        cubit(context).setLanguage(Language.english);
                        EasyLocalization.of(context)?.setLocale(Locale('en', 'EN'));
                      },
                      isSelected: Strings.daryoUz == "en",
                      icon: Assets.images.flagEn.svg(),
                      text: "English (EN)",
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              )),
              CustomElevatedButton(
                text: Strings.commonSave,
                textColor: StaticColors.white,
                onPressed: () {
                  context.router.push(IntroRoute());
                },
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
