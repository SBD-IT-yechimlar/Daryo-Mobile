import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:auto_route/auto_route.dart'; // agar context.router ishlatayotgan bo‘lsangiz
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';

import '../../../data/datasource/preference/auth_preferences.dart';
import '../../router/app_router.dart';

class ImageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final BuildContext context;
  final VoidCallback onBackPressed;
  final List<Widget>? actions;
  final Color backgroundColor;
  final Color titleTextColor;
  final Widget? flexibleSpace;

  const ImageAppBar({
    super.key,
    required this.titleText,
    required this.context,
    required this.titleTextColor,
    required this.backgroundColor,
    required this.onBackPressed,
    this.actions,
    this.flexibleSpace,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final authPref = GetIt.I<AuthPreferences>(); // 🟩 shu yerda chaqiramiz
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: true,
      title: titleText.w(500).s(16).c(titleTextColor),
      leadingWidth: 100,
      actionsPadding: const EdgeInsets.only(right: 8),
      leading: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: context.isDarkMode?Assets.imagesv2.appabarLogoDark.svg():Assets.imagesv2.appabarLogo.svg(),
        ),
      ),
      actions: [
        IconButton(
            onPressed: (){
              context.router.push(SearchRoute());
              HapticFeedback.lightImpact();
            },
            icon: Container(
                height: 35.h,
                width: 35.h,
                decoration: BoxDecoration(
                    color: context.containerBackground,
                    shape: BoxShape.circle
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Assets.imagesv2.icSearch.svg(colorFilter: ColorFilter.mode(context.iconPrimary, BlendMode.srcIn)),
                ))),
        IconButton(
            onPressed: (){
              HapticFeedback.lightImpact();
              if(authPref.isAuthorized){
                context.router.push(AccountRoute());
              }else{
                context.router.push(AuthStartRoute());
              }
            },
            icon: Container(
                height: 35.h,
                width: 35.h,
                decoration: BoxDecoration(
                    color: context.containerBackground,
                    shape: BoxShape.circle
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Assets.imagesv2.icProfile.svg(colorFilter: ColorFilter.mode(context.iconPrimary, BlendMode.srcIn)),
                ))),
      ],
    );
  }
}
