import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/domain/models/language/language.dart';
import 'package:daryo/presentation/features/home/features/tariffs/tariffs_page.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../core/gen/localization/strings.dart';
import '../../../../../domain/models/theme/app_theme_mode.dart';
import '../../../../router/app_router.dart';
import '../../../../support/colors/static_colors.dart';
import '../../../../widgets/account/account_item_svg_text.dart';
import '../../../../widgets/account/account_item_svg_text_svg.dart';
import '../../../../widgets/account/account_item_svg_text_switch.dart';
import '../../../../widgets/account/account_item_svg_text_text.dart';
import '../../../../widgets/account/custom_container.dart';
import '../../../../widgets/actions/selection_list_item.dart';
import '../../../../widgets/bottom_sheet/bottom_sheet_title.dart';
import '../../../../widgets/divider/custom_divider.dart';
import '../../../../widgets/language/language_button.dart';
import 'account_cubit.dart';
import 'features/cards/cards_page.dart';

@RoutePage()
class AccountPage extends BasePage<AccountCubit, AccountState, AccountEvent> {
  const AccountPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, AccountState state) {
    return Material(
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: context.backgroundColor,
          elevation: 0,
          actions: null,
          flexibleSpace: SizedBox(
            height: 100.h,
            child: Stack(
              children: [
                SizedBox(
                  height: 100.h,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 32,
                              width: 2,
                              color: Color(0xFF0089DA),
                            ),
                            SizedBox(width: 6),
                            Strings.profile.s(16).w(500).c(context.textPrimary),
                          ],
                        ),
                        //   Assets.imagesv2.aa.svg(height: 50.h,width: 50.h),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              context.router.pop();
                            },
                            icon: Container(
                                height: 35.h,
                                width: 35.h,
                                decoration: BoxDecoration(color: Color(0xFFF5F5F5), shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Assets.images.icAccountCloseCircle.svg(),
                                ))),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: state.avatar !=null?Image.file(
                      File(state.avatar!.path),
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ):Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFEDF1F3)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Assets.imagesv2.aa.svg(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  state.fullName.s(16).w(700).c(context.textPrimary),
                  state.email.s(12).w(400).c(context.textSecondary),
                  SizedBox(height: 16),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: context.inputStrokeInactiveColor, width: 1),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Row(
                            children: [
                              Assets.images.icSatrAccount.svg(width: 25.h, height: 25.h),
                              SizedBox(width: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "1000".s(13).w(700).c(context.textPrimary),
                                  Strings.collectedPoints.s(9).w(400).c(context.textSecondary),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: context.inputStrokeInactiveColor, width: 1),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Row(
                            children: [
                              Assets.images.icBalanceAccount.svg(width: 25.h, height: 25.h),
                              SizedBox(width: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "100 000".s(13).w(700).c(context.textPrimary),
                                  Strings.currencySom.s(9).w(400).c(context.textSecondary),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),*/
                  SizedBox(height: 16),
                  CustomContainer(crossAxisAlignmentCenter: false, children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Strings.myProfile.s(14).w(500).c(context.textPrimary),
                    ),
                    SizedBox(height: 16),
                    AccountItemSvgTextSvg(
                      title: Strings.edit,
                      icon: Assets.images.icAccountLock.svg(),
                      onTap: () {
                        context.router.push(EditProfileRoute());
                        HapticFeedback.lightImpact();
                      },
                    ),
                    //  SizedBox(height: 16),
                  /*  AccountItemSvgTextSvg(
                        onTap: () {
                          context.router.push(QuizHistoryRoute());
                        },
                        title: Strings.quizHistory,
                        icon: Assets.images.icAccountVictorinaHistory.svg()),*/

                    // SizedBox(height: 16),
                    AccountItemSvgTextSvg(
                        onTap: () {
                          context.router.push(SubscriptionsRoute());
                        },
                        title: Strings.subscriptions,
                        icon: Assets.images.icAccountSubscription.svg()),
                    //  SizedBox(height: 16),
                    AccountItemSvgTextSvg(
                      title: Strings.purchasedArticles,
                      icon: Assets.images.icAccountBuyNote.svg(),
                      onTap: () {
                        context.router.push(ByArticlesRoute());
                      },
                    ),
                  ]),
                  SizedBox(height: 16),
                  CustomContainer(crossAxisAlignmentCenter: false, children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Strings.generalSettings.s(14).w(500).c(context.textPrimary),
                    ),
                    SizedBox(height: 6),
               /*     AccountItemSvgTextSvg(
                      title: Strings.security,
                      icon: Assets.images.icAccountLock.svg(),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SecurityPage()),
                        );
                      },
                    ),*/
                    InkWell(
                      onTap: () {
                        // context.router.push(SelectLanguageAppRoute());
                        _showChangeLanguageBottomSheet(context, state);
                        HapticFeedback.lightImpact();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        child: AccountItemSvgTextText(
                          title: Strings.language,
                          icon: Assets.images.icAccountLanguageSquare.svg(),
                          text: Strings.lan,
                        ),
                      ),
                    ),
                    AccountItemSvgTextSvg(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TariffsPage()),
                          );
                        },
                        title: Strings.tariffs,
                        icon: Assets.images.icAccountTicket.svg()),
                    AccountItemSvgTextSvg(
                      title: Strings.cards,
                      icon: Assets.images.icAccountCard.svg(),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CardsPage()),
                        );
                      },
                    ),
                    InkWell(
                      onTap: (){
                        _showThemeModeBottomSheet(context, state);
                      },
                      child: AccountItemSvgTextSwitch(
                        title: Strings.theme,
                        icon: Assets.images.icAccountMask.svg(),
                        switchIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            width: 15.h,
                            height: 15.h,
                          ),
                        ),
                      ),
                    ),
                    AccountItemSvgTextSwitch(
                      title: Strings.notifications,
                      icon: Assets.images.icAccountNotificationBing.svg(),
                      switchIcon: Transform.scale(
                        alignment: Alignment.centerRight,
                        scale: 0.7,
                        child: CupertinoSwitch(
                          value: state.isNotification,
                          onChanged: (value) {
                            context.read<AccountCubit>().setNotification(value);
                          },
                          activeColor: const Color(0xFF0089DA),
                          trackColor: const Color(0xFFD9DDDF),
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(height: 16),
                  CustomContainer(crossAxisAlignmentCenter: false, children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Strings.helpSupport.s(14).w(500).c(context.textPrimary),
                    ),
                    SizedBox(height: 16),
                    AccountItemSvgTextSvg(
                      title: Strings.sendFeedback,
                      icon: Assets.images.icAccountMessage.svg(),
                      onTap: () {
                        context.router.push(SubmitApplicationRoute());
                      },
                    ),
                    AccountItemSvgTextSvg(
                      title: Strings.onlineEdition,
                      icon: Assets.images.icAccountGlobal.svg(),
                      onTap: () {
                        _openInExternalBrowser("https://daryo.uz/internet-nashr");
                     //   context.router.push(InternetPublicationRoute());
                      },
                    ),
                    AccountItemSvgTextSvg(
                      title: Strings.contactInfo,
                      icon: Assets.images.icAccountCall.svg(),
                      onTap: () {
                        _openInExternalBrowser("https://daryo.uz/aloqa-malumotlari");
                       // context.router.push(ContactInformationRoute());
                      },
                    ),
                    AccountItemSvgTextSvg(
                      title: Strings.aboutEditorial,
                      icon: Assets.images.icAccountPeople.svg(),
                      onTap: () {
                        context.router.push(AboutEditorialTeamRoute());
                      },
                    ),
                    AccountItemSvgTextSvg(title: Strings.termsOfUse, icon: Assets.images.icAccountDocumentText.svg(),onTap: (){
                      _openInExternalBrowser("https://daryo.uz/foydalanish-shartlari");
                    },),
                    AccountItemSvgTextSvg(title: Strings.privacyPolicy, icon: Assets.images.icAccountKey.svg(),
                      onTap: (){
                        _openInExternalBrowser("https://daryo.uz/maxfiylik-siyosati");
                      },
                    ),
                    AccountItemSvgTextSvg(
                      title: Strings.newsArchive,
                      icon: Assets.images.icAccountSave2.svg(),
                      onTap: () {
                        context.router.push(NewsHistoryCalendarRoute());
                      },
                    ),
                  ]),
                  SizedBox(height: 16),
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: (){
                      showYesNoBottomSheet(
                        context,
                        title: Strings.profileLogoutTitle,
                        message: Strings.profileLogoutDescription,
                        noTitle: Strings.commonNo,
                        onNoClicked: () {},
                        yesTitle: Strings.commonYes,
                        onYesClicked: () async {
                          await cubit(context).logOut();
                          context.router.replace(HomeRoute());
                        },
                      );
                      HapticFeedback.lightImpact();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color:context.isDarkMode?Color(0xFF374151): Color(0xFFEFF0F6),width: 1),
                          borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: AccountItemSvgText(
                            onTap: (){
                              showYesNoBottomSheet(
                                context,
                                title: Strings.profileLogoutTitle,
                                message: Strings.profileLogoutDescription,
                                noTitle: Strings.commonNo,
                                onNoClicked: () {},
                                yesTitle: Strings.commonYes,
                                onYesClicked: () async {
                                  await cubit(context).logOut();
                                  context.router.replace(HomeRoute());
                                },
                              );
                            },

                            title: Strings.logout,
                            icon: Assets.images.icAccountLogout.svg(),
                            color: Color(0xFFDF1525)),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showChangeLanguageBottomSheet(BuildContext context, AccountState state) {
    showCupertinoModalBottomSheet(
      context: context,
      backgroundColor: context.containerBackground,
      topRadius: Radius.circular(20),
      builder: (BuildContext bc) {
        return Material(
          color: context.containerBackground,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 12),
              BottomSheetTitle(
                title: Strings.languageSetTitle,
                onCloseClicked: () {
                  context.router.pop();
                },
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    LanguageButton(
                      text: "Uzbek (UZ)",
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        context.router.pop();
                        cubit(context).updateLanguage(Language.uzbekLatin);
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
                        context.router.pop();
                        cubit(context).updateLanguage(Language.uzbekCyrill);
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
                        context.router.pop();
                        cubit(context).updateLanguage(Language.russian);
                        EasyLocalization.of(context)?.setLocale(Locale('ru', 'RU'));
                      },
                      isSelected: Strings.daryoUz == "ru",
                      icon: Assets.images.flagRus.svg(),
                    ),
                    SizedBox(height: 16),
                    LanguageButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        context.router.pop();
                        cubit(context).updateLanguage(Language.english);
                        EasyLocalization.of(context)?.setLocale(Locale('en', 'EN'));
                      },
                      isSelected: Strings.daryoUz == "en",
                      icon: Assets.images.flagEn.svg(),
                      text: "English (EN)",
                    ),
                    SizedBox(height: 16),
                    SizedBox(height: 32)
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _showThemeModeBottomSheet(
    BuildContext context,
    AccountState state,
  ) {
    showCupertinoModalBottomSheet(
      context: context,
      backgroundColor: context.isDarkMode? Color(0xFF1F2937):context.containerBackground,
      builder: (BuildContext bc) {
        return Material(
          color: context.containerBackground,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 12),
              BottomSheetTitle(
                title: Strings.profileDarkMode,
                onCloseClicked: () {
                  context.router.pop();
                },
              ),
              SizedBox(height: 16),
              SelectionListItem(
                item: AppThemeMode.darkMode,
                title: Strings.themeModeDarkMode,
                isSelected: state.appThemeMode == AppThemeMode.darkMode,
                onClicked: (item) {
                  cubit(context).setSelectedThemeMode(item);
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor:  StaticColors.darkBackground ,
                    systemNavigationBarColor:  StaticColors.darkBackground ,
                    statusBarIconBrightness: Brightness.dark ,

                  ));
                  context.router.pop();
                },
              ),
              CustomDivider(height: 2, startIndent: 20, endIndent: 20),
              SelectionListItem(
                item: AppThemeMode.lightMode,
                title: Strings.themeModeLightMode,
                isSelected: state.appThemeMode == AppThemeMode.lightMode,
                onClicked: (item) {
                  cubit(context).setSelectedThemeMode(item);
                  context.router.pop();
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor:  Colors.transparent,
                    systemNavigationBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.light,

                  ));
                },
              ),
              CustomDivider(height: 2, startIndent: 20, endIndent: 20),
              SelectionListItem(
                item: AppThemeMode.followSystem,
                title: Strings.themeModeSystem,
                isSelected: state.appThemeMode == AppThemeMode.followSystem,
                onClicked: (item) {
                  cubit(context).setSelectedThemeMode(item);
                  context.router.pop();
                },
              ),
              SizedBox(height: 32)
            ],
          ),
        );
      },
    );
  }
  Future<void> _openInExternalBrowser(String urlString) async {
    final uri = Uri.parse(urlString);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlString';
    }
  }

}
