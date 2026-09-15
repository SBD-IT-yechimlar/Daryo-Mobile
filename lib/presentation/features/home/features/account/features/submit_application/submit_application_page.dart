import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/features/home/features/account/features/submit_application/features/send_application.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/button/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../../core/gen/localization/strings.dart';
import '../../../../../../widgets/app_bar/default_app_bar.dart';
import '../../../../../../widgets/form_field/custom_text_form_field.dart';
import '../../../../../../widgets/form_field/validator/default_validator.dart';
import '../../../../../../widgets/form_field/validator/email_validator.dart';
import '../../../../../../widgets/form_field/validator/phone_number_validator.dart';
import 'submit_application_cubit.dart';

@RoutePage()
class SubmitApplicationPage extends BasePage<SubmitApplicationCubit, SubmitApplicationState, SubmitApplicationEvent> {
  SubmitApplicationPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void onEventEmitted(BuildContext context, SubmitApplicationEvent event) {
    switch (event.type) {
      case SubmitApplicationEventType.onOpenBack:
        _showModalAndClose(context);
      case SubmitApplicationEventType.onFailed:
      case SubmitApplicationEventType.lostConnection:
    }

  }

  @override
  Widget onWidgetBuild(BuildContext context, SubmitApplicationState state) {
    return Material(
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: DefaultAppBar(
          context: context,
          titleText: Strings.sendFeedback,
          titleTextColor: context.textPrimary,
          backgroundColor: context.backgroundColor,
          onBackPressed: () {
            context.router.pop();
          },
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    CustomTextFormField(
                      hint: Strings.fullName,
                      textInputAction: TextInputAction.next,
                      inputType: TextInputType.name,
                      validator: (value) => NotEmptyValidator.validate(value),
                      prefixIcon: Assets.imagesDaryo.icEditProfileUser.svg(height: 16, width: 16),
                      onChanged: (value) {
                        cubit(context).setUsername(value);
                      },
                    ),
                    SizedBox(height: 16),
                    CustomTextFormField(
                      textInputAction: TextInputAction.next,
                      inputType: TextInputType.emailAddress,
                      hint: Strings.enterEmail,
                      validator: (value) => EmailValidator.validate(value),
                      prefixIcon: Assets.imagesDaryo.icEditProfileEmailMarketing.svg(height: 16, width: 16),
                      onChanged: (value) {
                        cubit(context).setEmail(value);
                      },
                    ),
                    SizedBox(height: 16),
                    CustomTextFormField(
                      textInputAction: TextInputAction.next,
                      inputType: TextInputType.phone,
                      hint: Strings.enterPhone,
                     // validator: (value) => PhoneNumberValidator.validate(value),
                      prefixIcon: Assets.imagesDaryo.icSubmitApplicationIphoneWallPhone.svg(height: 16, width: 16),
                      onChanged: (value) {
                        cubit(context).setPhone(value);
                      },
                    ),
                    /*SizedBox(height: 16),
                    CustomTextFormField(
                      textInputAction: TextInputAction.next,
                      hint: Strings.enterSubject,
                      validator: (value) => NotEmptyValidator.validate(value),
                      onChanged: (value) {
                        cubit(context).setTheme(value);
                      },
                    ),*/
                    SizedBox(height: 16),
                    CustomTextFormField(
                      textInputAction: TextInputAction.newline,
                      inputType: TextInputType.multiline,
                      hint: Strings.enterMessage,
                      maxLines: 7,
                      validator: (value) => NotEmptyValidator.validate(value),
                      onChanged: (value) {
                        cubit(context).setDescription(value);
                      },
                    ),
                    SizedBox(height: 24),
                    CustomElevatedButton(
                      text: Strings.sendButton,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit(context).submitApplication();
                        }
                      },
                      //isEnabled: _formKey.currentState?.validate()??false,
                      backgroundColor: context.colors.primary,
                      isLoading: state.isLoading,
                      textSize: 14,
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () { _openTelegramBot();},
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 48,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: context.primary),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.imagesDaryo.icSubmitApplicationTelegram.svg(),
                            SizedBox(width: 10),
                            Strings.telegramAdmin.s(14).w(500).c(StaticColors.white),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Strings.contactNotice
                        .s(12)
                        .w(500)
                        .c(context.textSecondary)
                        .copyWith(textAlign: TextAlign.center, overflow: TextOverflow.clip, softWrap: true)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _openTelegramBot() async {
    final Uri url = Uri.parse('https://t.me/Daryoga_murojaatbot');

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication, // Telegram ilovasida ochadi
      );
    } else {
      throw 'Telegramni ochib bo‘lmadi';
    }
  }

  void _showModalAndClose(BuildContext context) async {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5), // fon yarim shaffof
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SendApplication(),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );


    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    });
  }


}
