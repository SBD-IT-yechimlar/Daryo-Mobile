import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/form_field/validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/gen/assets/assets.gen.dart';
import '../../../../core/gen/localization/strings.dart';
import '../../../widgets/app_bar/default_app_bar.dart';
import '../../../widgets/button/custom_elevated_button.dart';
import '../../../widgets/form_field/custom_text_form_field.dart';

@RoutePage()
class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.backgroundWhiteColor,
        appBar: DefaultAppBar(
          context: context,
          titleText: "",
          titleWidget: context.isDarkMode
              ? Assets.imagesv2.appabarLogoDark.svg(width: 100.w)
              : Assets.imagesv2.appabarLogo.svg(width: 100.w),
          titleTextColor: context.textPrimary,
          backgroundColor: context.backgroundColor,
          onBackPressed: () => context.router.pop(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Strings.forgotPasswordTitle
                      .w(700)
                      .s(32)
                      .c(context.textPrimary),
                  const SizedBox(height: 12),
                  "${Strings.dontWorry}\n${Strings.weWillRestorePassword}"
                      .s(12)
                      .w(500)
                      .c(context.textSecondary),
                  const SizedBox(height: 24),
                  CustomTextFormField(
                    prefixIcon: Assets.imagesDaryo.email.svg(),
                    autofillHints: const [AutofillHints.email],
                    inputType: TextInputType.emailAddress,
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    hint: Strings.enterEmail,
                    textInputAction: TextInputAction.next,
                    controller: _emailController,
                    validator: (value) => EmailValidator.validate(value),
                  ),
                  const SizedBox(height: 16),
                  Strings.weSendSpecialPasswordNotice
                      .s(12)
                      .w(400)
                      .c(context.textSecondary),
                  const SizedBox(height: 16),
                  Strings.legalWarning.s(12).w(400).c(context.textSecondary),
                  const SizedBox(height: 24),
                  CustomElevatedButton(
                    backgroundColor: context.buttonGreenColor,
                    text: Strings.sendButton,
                    textColor: context.textPrimary,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.router.push(ForgetPasswordVerifyRoute(
                            email: _emailController.text));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
