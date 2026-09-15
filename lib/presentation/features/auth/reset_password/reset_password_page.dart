import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/localization/strings.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:daryo/presentation/widgets/button/custom_elevated_button.dart';
import 'package:daryo/presentation/widgets/button/custom_text_button.dart';
import 'package:daryo/presentation/widgets/form_field/custom_text_form_field.dart';

import 'reset_password_cubit.dart';

@RoutePage()
class ResetPasswordPage extends BasePage<ResetPasswordCubit, ResetPasswordState, ResetPasswordEvent> {
  const ResetPasswordPage({super.key});

  @override
  void onEventEmitted(BuildContext context, ResetPasswordEvent event) {
    switch (event.type) {
      case ResetPasswordEventType.navigationToHome:
        context.router.replace(HomeRoute());
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, ResetPasswordState state) {
    return Scaffold(
      backgroundColor: context.backgroundWhiteColor,
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(
        context: context,
        titleText: Strings.authRegisterRegister,
        titleTextColor: context.textPrimary,
        backgroundColor: context.backgroundGreyColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Strings.authCommonPassword
                      .w(500)
                      .s(14)
                      .c(context.textPrimary)),
              SizedBox(height: 10),
              CustomTextFormField(
                autofillHints: const [AutofillHints.password],
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                obscureText: true,
                inputType: TextInputType.visiblePassword,
                maxLines: 1,
                onChanged: (value) {
                  cubit(context).setPassword(value);
                },
                // controller: textController,
              ),
              SizedBox(height: 24),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Strings.authRegisterRepeatPassword
                      .w(500)
                      .s(14)
                      .c(context.textPrimary)),
              SizedBox(height: 10),
              CustomTextFormField(
                autofillHints: const [AutofillHints.password],
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                readOnly: false,
                maxLines: 1,
                obscureText: true,
                onChanged: (value) {
                  cubit(context).setRepeatPassword(value);
                },
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomTextButton(
                  text: Strings.authRegisterPasswordContainLeastCharacters,
                  onPressed: () {},
                ),
              ),
              CustomElevatedButton(
                text: Strings.commonContinue,
                onPressed: () {
                  TextInput.finishAutofillContext(shouldSave: true);
                },
                isEnabled: state.enabled,
                isLoading: state.loading,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
