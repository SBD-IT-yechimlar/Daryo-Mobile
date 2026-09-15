import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/presentation/support/cubit/base_page.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/button/custom_elevated_button.dart';

import '../../../../core/gen/localization/strings.dart';
import 'registration_cubit.dart';

@RoutePage()
class RegistrationImagePage
    extends BasePage<RegistrationCubit, RegistrationState, RegistrationEvent> {
  RegistrationImagePage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget onWidgetBuild(BuildContext context, RegistrationState state) {
    File? pickedImage;

    return StatefulBuilder(
      builder: (context, setState) {
        Future<void> pickImage() async {
          final picker = ImagePicker();
          final XFile? image =
              await picker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            setState(() => pickedImage = File(image.path));
          }
        }

        return Scaffold(
          backgroundColor: context.backgroundWhiteColor,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () => context.router.pop(),
              icon: Assets.imagesDaryo.back.svg(),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Strings.register.w(700).s(32).c(context.textPrimary),
                      const SizedBox(height: 12),
                      "${Strings.addPhotoOptional} (${Strings.optional})"
                          .s(12)
                          .w(500)
                          .c(context.textSecondary),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: context.inputStrokeInactiveColor,
                            ),
                          ),
                          child: pickedImage == null
                              ? AspectRatio(
                                  aspectRatio: 1,
                                  child: Center(
                                    child: Assets.imagesDaryo.galleryAdd.svg(),
                                  ))
                              : Stack(
                                  children: [
                                    Image.file(
                                      pickedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      bottom: 15,
                                      right: 15,
                                      child: Assets.imagesDaryo.edit.svg(),
                                    )
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomElevatedButton(
                        text: Strings.finish,
                        textColor: context.colors.primary,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
