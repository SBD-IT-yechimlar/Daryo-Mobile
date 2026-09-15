import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/support/extensions/controller_exts.dart';
import 'package:daryo/presentation/widgets/button/custom_elevated_button.dart';
import 'package:daryo/presentation/widgets/form_field/validator/default_validator.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../../core/gen/localization/strings.dart';
import '../../../../../../support/colors/static_colors.dart';
import '../../../../../../widgets/form_field/custom_text_form_field.dart';
import '../../../../../../widgets/form_field/validator/email_validator.dart';
import 'edit_profile_cubit.dart';

@RoutePage()
class EditProfilePage extends BasePage<EditProfileCubit, EditProfileState, EditProfileEvent> {
  EditProfilePage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController= TextEditingController();
  final TextEditingController _emailNameController= TextEditingController();

  @override
  void onEventEmitted(BuildContext context, EditProfileEvent event) {
    switch(event.type){

      case EditProfileEventType.updateProfile:
        context.router.pop();
      case EditProfileEventType.failed:

    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, EditProfileState state) {
    _fullNameController.updateOnRestore(state.name);
    _emailNameController.updateOnRestore(state.email);
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: context.iconPrimary),
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
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(child: Strings.editProfile.s(32).w(700).c(context.textPrimary)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Stack(
                    clipBehavior: Clip.none, // Muhim! Icon tashqariga chiqishi uchun
                    children: [
                      Container(
                        // padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(border: Border.all(color: StaticColors.white, width: 2), borderRadius: BorderRadius.circular(75)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(75),
                          child: state.avatar !=null?Image.file(
                            File(state.avatar!.path),
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ):
                          Container(
                            height: 150,
                            width: 150,
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
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(19),
                          onTap: (){
                            cubit(context).pickHomeImage();
                          },
                          child: Container(
                            height: 38,
                            width: 38,
                            padding: EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              color: context.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: StaticColors.white,
                                width: 2, // oq chegarasi — rasm bilan ajratish uchun
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Assets.imagesDaryo.icEditProfileIconlyLightEdit.svg(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    controller:_fullNameController,
                    textInputAction: TextInputAction.next,
                    hint: Strings.enterFirstName,
                    validator: (value) => NotEmptyValidator.validate(value),
                    prefixIcon: Assets.imagesDaryo.icEditProfileUser.svg(height: 16, width: 16),
                    onChanged: (value){
                      cubit(context).setSurname(value);
                    },
                  ),
                 // SizedBox(height: 16),
                /*  CustomTextFormField(
                    textInputAction: TextInputAction.next,
                    hint: Strings.enterFirstName,
                    validator: (value) => NotEmptyValidator.validate(value),
                    prefixIcon: Assets.imagesDaryo.icEditProfileUser.svg(height: 16, width: 16),
                    onChanged: (value){
                      cubit(context).setName(value);
                    },
                  ),*/

                  SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _emailNameController,
                    textInputAction: TextInputAction.next,
                    hint: Strings.enterEmail,
                    validator: (value) => EmailValidator.validate(value),
                    prefixIcon: Assets.imagesDaryo.icEditProfileEmailMarketing.svg(height: 16, width: 16),
                    onChanged: (value){
                      cubit(context).setEmail(value);
                    },
                  ),
                 // SizedBox(height: 16),
                /*  CustomTextFormField(
                    textInputAction: TextInputAction.next,
                    hint: "dd.MM.YYYY",
                    prefixIcon: Assets.imagesDaryo.icEditProfileHappyBirthday.svg(height: 16, width: 16),
                    *//* suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 15),
                      child: Assets.imagesDaryo.icEditProfileCalendar2.svg(height: 16, width: 16),
                    ),*//*
                  ),*/

                //  SizedBox(height: 16),
                 /* CustomTextFormField(
                    autofillHints: const [AutofillHints.telephoneNumber],
                    inputType: TextInputType.phone,
                    prefixText: "+998",
                    inputFormatters: phoneMaskFormatter,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    hint: Strings.enterPhone,
                 //   validator: (value) => PhoneNumberValidator.validate(value),
                    prefixIcon: Assets.imagesDaryo.icEditProfileCallAdd.svg(height: 16, width: 16),
                    onChanged: (value){
                      cubit(context).setPhone(value);
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
                    hint: Strings.enterPassword,
                  //  validator: (value) => NotEmptyValidator.validate(value),
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      cubit(context).setPassword(value);
                    },
                  ),*/
                  SizedBox(height: 24),
                  CustomElevatedButton(
                    text: Strings.edit,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        cubit(context).updateUser();
                      }
                    },
                    backgroundColor: Color(0xFF0089DA),
                    textSize: 14,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
