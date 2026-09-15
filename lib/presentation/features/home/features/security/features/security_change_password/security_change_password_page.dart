import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/button/custom_elevated_button.dart';
import 'package:daryo/presentation/widgets/form_field/validator/password_validator.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../../core/gen/localization/strings.dart';
import '../../../../../../router/app_router.dart';
import '../../../../../../widgets/app_bar/default_app_bar.dart';
import '../../../../../../widgets/form_field/custom_text_form_field.dart';

@RoutePage()
class SecurityChangePasswordPage extends StatefulWidget {
  const SecurityChangePasswordPage({super.key});

  @override
  State<SecurityChangePasswordPage> createState() => _SecurityChangePasswordPageState();
}

class _SecurityChangePasswordPageState extends State<SecurityChangePasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: DefaultAppBar(
        context: context,
        titleText: Strings.changePassword,
        titleTextColor: context.textPrimary,
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Strings.passwordChangeInfo.w(500).c(context.textPrimary).s(14),
                CustomTextFormField(
                  prefixIcon: Assets.imagesDaryo.lock.svg(),
                  autofillHints: const [AutofillHints.password],
                  inputType: TextInputType.visiblePassword,
                  keyboardType: TextInputType.visiblePassword,
                  maxLines: 1,
                  obscureText: true,
                  hint: Strings.oldPassword,
                  textInputAction: TextInputAction.next,
                  validator: (value) => PasswordValidator.validate(value),
                  controller: _passwordController,
                  onChanged: (value) {},
                ),
                CustomTextFormField(
                  prefixIcon: Assets.imagesDaryo.lock.svg(),
                  autofillHints: const [AutofillHints.password],
                  inputType: TextInputType.visiblePassword,
                  keyboardType: TextInputType.visiblePassword,
                  maxLines: 1,
                  obscureText: true,
                  hint: Strings.newPassword,
                  textInputAction: TextInputAction.next,
                  validator: (value) => PasswordValidator.validate(value),
                  controller: _newPasswordController,
                  onChanged: (value) {},
                ),
                CustomTextFormField(
                  prefixIcon: Assets.imagesDaryo.lock.svg(),
                  autofillHints: const [AutofillHints.password],
                  inputType: TextInputType.visiblePassword,
                  keyboardType: TextInputType.visiblePassword,
                  maxLines: 1,
                  obscureText: true,
                  hint: Strings.confirmNewPassword,
                  textInputAction: TextInputAction.done,
                  validator: (value) => PasswordValidator.validate(value),
                  controller: _confirmPasswordController,
                  onChanged: (value) {},
                ),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.router.push(ForgetPasswordRoute());
                    }
                  },
                  child: Strings.forgotPasswordTitle.s(12).w(500).c(context.brownClickColor),
                ),
                CustomElevatedButton(
                  text: Strings.changePassword,
                  textColor: Colors.white,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
