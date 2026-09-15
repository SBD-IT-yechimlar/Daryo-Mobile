import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/core/gen/localization/strings.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/button/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceUpdateDialog extends StatelessWidget {
  const ForceUpdateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Dialog(
        backgroundColor:context.isDarkMode ?Color(0xFF1F2937): Color(0xFFe6e6e6), // fon rangi
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Illyustratsiya rasmi
                  Assets.images.appForcceUpdate.svg(),
                  const SizedBox(height: 20),
                  Strings.forseUpdateTitle.s(14).w(600).c(context.textPrimary),
                  const SizedBox(height: 10),
                  Strings.forseUpdateDesc.s(12).w(500).c(context.textSecondary).copyWith(textAlign: TextAlign.center),
                  const SizedBox(height: 25),

                  CustomElevatedButton(text: Strings.commonRefresh, onPressed: ()async{
                    if(Platform.isIOS){
                      final Uri uri = Uri.parse("https://apps.apple.com/uz/app/daryo/id865012404");
                      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                        throw Exception('Play Store ochilmadi');
                      }
                    }else{
                      final Uri uri = Uri.parse("https://play.google.com/store/apps/details?id=uz.muloqot.daryo");
                      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                        throw Exception('Play Store ochilmadi');
                      }
                    }
                  })
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

}
