import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/core/gen/localization/strings.dart';
import 'package:daryo/presentation/features/auth/start/auth_launch_type.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/support/extensions/controller_exts.dart';
import 'package:daryo/presentation/widgets/button/custom_elevated_button.dart';
import 'package:daryo/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../domain/models/language/language.dart';
import '../../../widgets/app_bar/default_app_bar.dart';
import '../../../widgets/bottom_sheet/bottom_sheet_title.dart';
import '../../../widgets/button/custom_outlined_button.dart';
import '../../../widgets/common/sending_toast.dart';
import '../../../widgets/dialog/auth_error_dialog.dart';
import '../../../widgets/language/language_button.dart';
import 'auth_start_cubit.dart';

@RoutePage()
class AuthStartPage extends BasePage<AuthStartCubit, AuthStartState, AuthStartEvent> {
  final String? phone;
  final AuthLaunchType authLaunchType;

  AuthStartPage({super.key, this.phone, this.authLaunchType = AuthLaunchType
      .launchByDefault});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void onWidgetCreated(BuildContext context) {
  }

  @override
  void onEventEmitted(BuildContext context, AuthStartEvent event) {
    switch (event.type) {
      case AuthStartEventType.onEdsLoginFailed:
        showLoginFailedDialog(context);
        break;
      case AuthStartEventType.onOpenHome:
        context.router.pushAndPopUntil(
            DashboardRoute(),
            predicate: (Route<dynamic> route) => route is DashboardRoute);
      case AuthStartEventType.lostConnection:
        showAppToast(
          context,
           event.errorMessage??"",
        );
        break;
      case AuthStartEventType.googleFailed:
        showGoogleLoginFailedDialog(context, event.errorMessage??"");
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, AuthStartState state) {
    _emailController.updateOnRestore(state.phone);
    return Scaffold(
      backgroundColor: context.backgroundWhiteColor,
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.only(bottom: Platform.isIOS? 15:0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6,
          children: [
            Strings.dontHaveAccount.s(12).w(500).c(Color(0xFF6C7278)),
            TextButton(
              onPressed: () {
                context.router.push(RegistrationRoute());
              },
              child: "${Strings.register}"
                  .s(12)
                  .w(600)
                  .c(context.colors.primary),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
      appBar: DefaultAppBar(
        titleText: Strings.authStartSingin,
        titleTextColor: context.textPrimary,
        backgroundColor: context.appBarColor,
        onBackPressed: () => context.router.pop(),
        context: context,
      ),
      body: Padding(
       // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        padding: const EdgeInsets.only(right: 24,left: 24, bottom: 24),
        child: AutofillGroup(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: (){
                              _showChangeLanguageBottomSheet(context,state);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: context.containerBackground
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Assets.images.icTranslate.svg(color: Color(0xFF8D8A8D)),
                                  SizedBox(width: 4),
                                  Strings.translateTiitle.s(14).w(500).c(context.textPrimary),
                                  SizedBox(width: 4),
                                  Assets.images.icTranslateDown.svg()
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if(Platform.isIOS)
                        SizedBox(height: 10.h),
                      Center(child: Assets.imagesv2.aa.svg(height: 60.h)),
                      SizedBox(height: 22),
                      Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: Strings.loginToPersonalAccount.s(32).w(700).c(context.textPrimary),
                      ),
                      SizedBox(height: 12),
                      Strings.enterEmailAndPassword.s(12).w(500).c(context.textSecondary),
                      SizedBox(height: 32),
                      CustomTextFormField(
                        prefixIcon: Assets.imagesDaryo.user.svg(),
                        autofillHints: const [AutofillHints.email],
                        inputType: TextInputType.emailAddress,
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 1,
                        hint: Strings.enterEmailAddress,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          cubit(context).setEmail(value);
                        },
                      ),
                      SizedBox(height: 8),
                      CustomTextFormField(
                        prefixIcon: Assets.imagesDaryo.lock.svg(),
                        autofillHints: const [AutofillHints.password],
                        inputType: TextInputType.visiblePassword,
                        keyboardType: TextInputType.visiblePassword,
                        maxLines: 1,
                        obscureText: true,
                        hint: Strings.enterPassword,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          cubit(context).setPassword(value);
                        },
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          /*  Transform.scale(
                            scale: 0.8,
                            child: Checkbox(
                              value: false,
                              onChanged: (value) {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              side: BorderSide(
                                  color: context.textSecondary, width: 1.5),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                          Strings.rememberMe.s(12).w(500).c(context.textSecondary),*/
                          Spacer(),
                       /*   TextButton(
                            onPressed: () {
                              context.router.push(ForgetPasswordRoute());
                            },
                            child: Strings.forgotPassword.s(12).w(500).c(context.brownClickColor),
                          ),*/
                          SizedBox(height: 25.h)
                        ],
                      ),
                      SizedBox(height: 24),
                      CustomElevatedButton(
                        text: Strings.login,
                        onPressed: () => {cubit(context).login(), HapticFeedback.mediumImpact()},
                        backgroundColor: context.buttonGreenColor,
                        disableTextColor: Colors.white,
                        isEnabled: (state.email.length > 4) && (state.password.length > 4),
                        isLoading: state.loading,
                      ),
                      SizedBox(height: 16),
                   /// enable code
                    /*  Row(
                        spacing: 16,
                        children: [
                          Expanded(child: Divider()),
                          Strings.orKeyWord.c(context.textSecondary).s(12),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: 16),
                      CustomOutlinedButton(
                        leftIcon: Assets.imagesDaryo.google.svg(),
                        text: Strings.continueWithGoogle,
                        onPressed: () => {
                          cubit(context).loginWithGoogle(),
                         // loginWithGoogle(),
                          HapticFeedback.mediumImpact()
                        },
                        strokeColor: context.inputStrokeInactiveColor,
                      ),*/
                    /*  SizedBox(height: 8),
                      CustomOutlinedButton(
                        leftIcon: Assets.imagesDaryo.facebook.svg(),
                        text: Strings.continueWithFacebook,
                        onPressed: () => {},
                        strokeColor: context.inputStrokeInactiveColor,
                      ),*/
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _showChangeLanguageBottomSheet(BuildContext context, AuthStartState state) {
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
}

Future<bool?> showLoginFailedDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) {
      return AuthErrorCustomDialog(
        icon: Assets.imagesDaryo.info.svg(),
        title: Strings.incorrectEmailOrPassword,
        subtitle: Strings.fillFieldsCarefully,
        actions: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8),
            CustomElevatedButton(
              buttonHeight: 40,
              backgroundColor: context.buttonPrimary,
              textColor: StaticColors.white,
              text: Strings.understood,
              onPressed: () {
                Navigator.pop(context, false); // Return false
              },
            ),
          ],
        ),
      );
    },
  );
}

Future<bool?> showGoogleLoginFailedDialog(BuildContext context,String message) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) {
      return AuthErrorCustomDialog(
        icon: Assets.imagesDaryo.info.svg(),
        title: message,
        subtitle: "",
        actions: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8),
            CustomElevatedButton(
              buttonHeight: 40,
              backgroundColor: context.buttonPrimary,
              textColor: StaticColors.white,
              text: Strings.understood,
              onPressed: () {
                Navigator.pop(context, false); // Return false
              },
            ),
          ],
        ),
      );
    },
  );
}

void loginWithGoogle() async {
  print('login with google');
  final _googleSignIn = GoogleSignIn();
  _googleSignIn.signIn().then((result) {
    result?.authentication.then((googleKey) {
      print("-----------------------------");
      print("-----------------------------");

      print(googleKey.idToken);
      print("-----------------------------");
      print("-----------------------------");

      print(googleKey.accessToken ?? '');
      print("-----------------------------");
      print("-----------------------------");

      print(_googleSignIn.currentUser?.displayName);
     /* authBloc.add(
        AuthWithGoogle(
          tokenFromGoogle: googleKey.accessToken ?? '',
          themeProvider: themeProvider,
        ),
      );
      Navigator.pop(context, true);*/
    }).catchError((err) {
      print('inner error');
    });
  }).catchError((err) {
    print('error occured $err');
  });
}


