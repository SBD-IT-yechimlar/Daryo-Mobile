import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/form_field/validator/password_validator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/gen/assets/assets.gen.dart';
import '../../../../core/gen/localization/strings.dart';
import '../../../widgets/button/custom_elevated_button.dart';
import '../../../widgets/form_field/custom_text_form_field.dart';

@RoutePage()
class ForgetPasswordVerifyPage extends StatefulWidget {
  const ForgetPasswordVerifyPage({super.key, required this.email});

  final String email;

  @override
  State<ForgetPasswordVerifyPage> createState() => _ForgetPasswordVerifyPageState();
}

class _ForgetPasswordVerifyPageState extends State<ForgetPasswordVerifyPage> {
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundWhiteColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.router.pop(),
          icon: Assets.imagesDaryo.back.svg(),
        ),
        backgroundColor: context.backgroundWhiteColor,
        elevation: 0,
        centerTitle: true,
        title: Assets.imagesDaryo.pngImages.logoDaryo.image(width: 94, height: 24),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: AutofillGroup(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Strings.resetPasswordTitle.w(700).s(32).c(context.textPrimary),
                    SizedBox(height: 12),
                    tr('enter_special_code_instruction', namedArgs: {'email': widget.email}).s(12).w(500).c(context.textSecondary),
                    SizedBox(height: 24),
                    CustomTextFormField(
                      prefixIcon: Assets.imagesDaryo.lock.svg(),
                      autofillHints: const [AutofillHints.password],
                      inputType: TextInputType.visiblePassword,
                      keyboardType: TextInputType.visiblePassword,
                      maxLines: 1,
                      obscureText: true,
                      hint: Strings.enterSpecialCodeLabel,
                      textInputAction: TextInputAction.done,
                      controller: _passwordController,
                      validator: (value) =>PasswordValidator.validate(value),
                      onChanged: (value) {
                        // cubit(context).setPhone(value);
                      },
                    ),
                    SizedBox(height: 16),
                    "${Strings.oneTimeCodeNotice}\n${Strings.changePasswordAfterLoginNotice}".s(12).w(400).c(context.textSecondary),
                    SizedBox(height: 16),
                    Strings.legalWarning.s(12).w(400).c(context.textSecondary),
                    SizedBox(height: 24),
                    CustomElevatedButton(
                      backgroundColor: context.buttonGreenColor,
                      text: Strings.sendButton,
                      textColor: context.textPrimary,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
