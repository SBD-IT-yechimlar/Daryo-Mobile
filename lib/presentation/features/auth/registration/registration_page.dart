import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/core/gen/localization/strings.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/support/extensions/controller_exts.dart';
import 'package:daryo/presentation/support/extensions/mask_formatters.dart';
import 'package:daryo/presentation/widgets/button/custom_elevated_button.dart';
import 'package:daryo/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:daryo/presentation/widgets/form_field/validator/default_validator.dart';
import 'package:daryo/presentation/widgets/form_field/validator/email_validator.dart';
import 'package:daryo/presentation/widgets/form_field/validator/password_confirm_validator.dart';
import 'package:daryo/presentation/widgets/form_field/validator/password_validator.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_bar/default_app_bar.dart';
import '../../../widgets/common/sending_toast.dart';
import '../../../widgets/dialog/auth_error_dialog.dart';
import '../../../widgets/form_field/validator/phone_number_validator.dart';
import 'registration_cubit.dart';

@RoutePage()
class RegistrationPage extends BasePage<RegistrationCubit, RegistrationState, RegistrationEvent> {
  RegistrationPage({
    super.key,
  });

  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void onEventEmitted(BuildContext context, RegistrationEvent event) {
    switch (event.type) {
      case RegistrationEventType.onOpenImagePage:
        context.router.pushAndPopUntil(DashboardRoute(), predicate: (Route<dynamic> route) => route is DashboardRoute);
      case RegistrationEventType.lostConnection:
        showAppToast(context, event.errorMessage ?? "");
        break;
      case RegistrationEventType.onRegisterFailed:
        showRegisterFailedDialog(context, event.errorMessage ?? "");
        break;
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, RegistrationState state) {
    _birthDateController.updateOnRestore(birthDateMaskFormatter.formatString(state.brithDate));

    return Scaffold(
      backgroundColor: context.backgroundWhiteColor,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.only(bottom: Platform.isIOS?30:10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: [
            Strings.haveAccount.s(12).w(500).c(Color(0xFF6C7278)),
            GestureDetector(
              onTap: () {
                context.router.pop();
              },
              child: Strings.login.s(12).w(600).c(context.colors.primary),
            ),
          ],
        ),
      ),
      appBar: DefaultAppBar(
        context: context,
        titleText: "",
      //  titleWidget: Assets.imagesDaryo.pngImages.logoDaryo.image(),
        titleTextColor: context.textPrimary,
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: AutofillGroup(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12),
                          Strings.register.w(700).s(32).c(context.textPrimary),
                          SizedBox(height: 12),
                          Strings.fillPersonalInfo.s(12).w(500).c(context.textSecondary),
                          SizedBox(height: 24),
                          CustomTextFormField(
                            prefixIcon: Assets.imagesDaryo.user.svg(),
                            autofillHints: const [AutofillHints.name],
                            inputType: TextInputType.name,
                            keyboardType: TextInputType.name,
                            maxLines: 1,
                            hint: Strings.enterLastName,
                            textInputAction: TextInputAction.next,
                            validator: (value) => NotEmptyValidator.validate(value),
                            controller: _lastNameController,
                            onChanged: (value) {
                              cubit(context).setLastName(value);
                            },
                          ),
                          SizedBox(height: 16),
                          CustomTextFormField(
                            prefixIcon: Assets.imagesDaryo.user.svg(),
                            autofillHints: const [AutofillHints.name],
                            inputType: TextInputType.name,
                            keyboardType: TextInputType.name,
                            maxLines: 1,
                            hint: Strings.enterFirstName,
                            textInputAction: TextInputAction.next,
                            validator: (value) => NotEmptyValidator.validate(value),
                            controller: _firstNameController,
                            onChanged: (value) {
                              cubit(context).setFirstName(value);
                            },
                          ),
                          SizedBox(height: 16),
                          CustomTextFormField(
                            prefixIcon: Assets.imagesDaryo.email.svg(),
                            autofillHints: const [AutofillHints.email],
                            inputType: TextInputType.emailAddress,
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 1,
                            hint: Strings.enterEmail,
                            textInputAction: TextInputAction.next,
                            validator: (value) => EmailValidator.validate(value),
                            controller: _emailController,
                            onChanged: (value) {
                              cubit(context).setEmail(value);
                            },
                          ),
                          /*SizedBox(height: 16),
                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              CustomTextFormField(
                                prefixIcon: Assets.imagesDaryo.birth.svg(),
                                inputType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                inputFormatters: birthDateMaskFormatter,
                                hint: Strings.selectBirthDate,
                                maxLength: 12,
                                controller: _birthDateController,
                                validator: (v) => BirthDateValidator.validate(v),
                                onChanged: (value) {
                                  cubit(context).setBrithDate(value);
                                },
                              ),
                              Container(
                                width: 42,
                                height: 42,
                                margin: EdgeInsets.only(right: 6, bottom: 6),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(6),
                                    onTap: () {
                                      showDefaultDatePickerDialog(
                                        context,
                                        maximumYear: DateTime.now().year,
                                        selectedDate: DateTime.tryParse(state.brithDate),
                                        onDateSelected: (date) {
                                          _birthDateController.text = date;
                                          cubit(context).setBrithDate(date);
                                        },
                                      );
                                      HapticFeedback.lightImpact();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Assets.imagesDaryo.calendar.svg(
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),*/
                          SizedBox(height: 16),
                          CustomTextFormField(
                            autofillHints: const [AutofillHints.telephoneNumber],
                            inputType: TextInputType.phone,
                            keyboardType: TextInputType.phone,
                            maxLines: 1,
                            hint: Strings.enterPhone,
                            prefixIcon: Assets.imagesDaryo.call.svg(),
                            prefixText: "+998",
                            textInputAction: TextInputAction.done,
                            controller: _phoneController,
                            validator: (value) => PhoneNumberValidator.validate(value),
                            inputFormatters: phoneMaskFormatter,
                            onChanged: (value) {
                              cubit(context).setInitialParams(value);
                            },
                          ),
                          SizedBox(height: 16),
                          CustomTextFormField(
                            prefixIcon: Assets.imagesDaryo.lock.svg(),
                            autofillHints: const [AutofillHints.password],
                            inputType: TextInputType.visiblePassword,
                            keyboardType: TextInputType.visiblePassword,
                            maxLines: 1,
                            obscureText: true,
                            validator: (value) => PasswordValidator.validate(value),
                            hint: Strings.enterPassword,
                            textInputAction: TextInputAction.done,
                            controller: _passwordController,
                            onChanged: (value) {
                              cubit(context).setPassword(value);
                            },
                          ),
                          SizedBox(height: 16),
                          CustomTextFormField(
                            prefixIcon: Assets.imagesDaryo.lock.svg(),
                            autofillHints: const [AutofillHints.password],
                            inputType: TextInputType.visiblePassword,
                            keyboardType: TextInputType.visiblePassword,
                            maxLines: 1,
                            obscureText: true,
                            hint: Strings.reenterPassword,
                            validator: (value) => PasswordConfirmValidator.validate(state.password, value),
                            textInputAction: TextInputAction.done,
                            controller: _confirmPasswordController,
                            onChanged: (value) {
                              cubit(context).setConfirmPassword(value);
                            },
                          ),
                          SizedBox(height: 24),
                          CustomElevatedButton(
                            text: Strings.registerButton,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                cubit(context).register();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool?> showRegisterFailedDialog(BuildContext context, String error) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) {
      return AuthErrorCustomDialog(
        icon: Assets.imagesDaryo.info.svg(),
        title: error,
        // subtitle: "Ushbu ma’lumotlar Daryo.uz bazasida maxfiy saqlanadi va hech kimga oshkor qilinmaydi.",
        actions: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8),
            CustomElevatedButton(
              buttonHeight: 40,
              backgroundColor: const Color(0xFF0089DA),
              textColor: Colors.white,
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
