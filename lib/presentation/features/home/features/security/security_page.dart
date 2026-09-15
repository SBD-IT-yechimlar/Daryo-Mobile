import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/features/home/features/security/features/active_sessions/active_session_page.dart';
import 'package:daryo/presentation/features/home/features/security/features/security_change_password/security_change_password_page.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/gen/localization/strings.dart';

@RoutePage()
class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: DefaultAppBar(
        context: context,
        titleText: Strings.security,
        titleTextColor: context.textPrimary,
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            spacing: 16,
            children: [
              SecurityButton(
                title: Strings.changePassword,
                rightWidget: Icon(
                  Icons.chevron_right,
                  size: 18,
                ),
                subtitle: Strings.updatePasswordDescription,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecurityChangePasswordPage()),
                  );
                //  context.router.push(SecurityChangePasswordRoute());
                },
              ),
              SecurityButton(
                title: Strings.biometricLogin,
                rightWidget:
                    CupertinoSwitch(value: true, onChanged: (value) {}, activeColor: context.colors.primary),
                subtitle: Strings.biometricLoginDescription,
                onTap: () {},
              ),
              SecurityButton(
                title: Strings.loginHistory,
                rightWidget: Icon(
                  Icons.chevron_right,
                  size: 18,
                ),
                subtitle: Strings.checkLoginHistory,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ActiveSessionsPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecurityButton extends StatelessWidget {
  const SecurityButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.rightWidget,
  });

  final String title;
  final String subtitle;
  final Function() onTap;
  final Widget rightWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: context.inputStrokeInactiveColor,
          ),
        ),
        child: Row(
          children: [
            Expanded(
                child: Column(
              spacing: 2,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title.c(context.textPrimary).s(14).w(400),
                Text(subtitle).s(12).c(context.textSecondary).w(400)
              ],
            )),
            rightWidget
          ],
        ),
      ),
    );
  }
}
