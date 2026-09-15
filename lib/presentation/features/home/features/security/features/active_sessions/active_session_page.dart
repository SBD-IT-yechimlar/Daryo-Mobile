import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/button/custom_elevated_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../../core/gen/localization/strings.dart';
import '../../../../../../widgets/app_bar/default_app_bar.dart';

@RoutePage()
class ActiveSessionsPage extends StatefulWidget {
  const ActiveSessionsPage({super.key});

  @override
  State<ActiveSessionsPage> createState() => _ActiveSessionsPageState();
}

class _ActiveSessionsPageState extends State<ActiveSessionsPage> {
  final sessions = <Session>[
    Session(
      deviceName: "Iphone 14 Pro Max",
      deviceInfo: "Daryo, 1.0.0",
      location: "Uzbekistan, Tashkent",
      timestamp: 1759913576453,
      isCurrent: true,
    ),
    Session(
      deviceName: "Iphone 16 Pro Max",
      deviceInfo: "Daryo, 1.0.0",
      location: "Russia, Moscow",
      timestamp: 1759813576453,
      isCurrent: false,
    ),
    Session(
      deviceName: "Xiaomi Note 10 Pro",
      deviceInfo: "Daryo, 1.0.0",
      location: "Uzbekistan, Samarqand",
      timestamp: 1759911576453,
      isCurrent: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentSession = sessions.firstWhere((element) => element.isCurrent);
    final otherSessions = sessions.where((element) => !element.isCurrent).toList();
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: DefaultAppBar(
        context: context,
        titleText: Strings.activeSessions,
        titleTextColor: context.textPrimary,
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Strings.thisDevice.s(16).w(500).c(context.textPrimary),
              SizedBox(height: 16),
              SessionWidget(session: currentSession),
              SizedBox(height: 16),
              Strings.logoutOtherDevices.s(12).w(400).c(context.textSecondary),
              SizedBox(height: 16),
              CustomElevatedButton(
                textColor: context.redClickColor,
                leftIcon: Icon(
                  Icons.block,
                  color: context.redClickColor,
                  size: 20,
                ),
                backgroundColor: context.containerBackground,
                text: Strings.stopOtherSessions,
                onPressed: () {},
              ),
              SizedBox(height: 16),
              Strings.activeSessionsAlt.s(16).w(500).c(context.textPrimary),
              SizedBox(height: 16),
              ...List.generate(otherSessions.length, (index) {
                final session = otherSessions[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: SessionWidget(session: session),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class SessionWidget extends StatelessWidget {
  const SessionWidget({super.key, required this.session});

  final Session session;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (session.isCurrent) return;
        showModalBottomSheet(
            backgroundColor: context.containerBackground,
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Container(
                decoration: BoxDecoration(color: context.containerBackground, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 14),
                      Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(color: context.iconPrimary, borderRadius: BorderRadius.circular(100)),
                      ),
                      SizedBox(height: 24),
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.colors.primary,
                        ),
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.android,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(session.deviceName).s(14).w(500).c(context.textPrimary),
                      SizedBox(height: 4),
                      Text(DateFormat("H:mm dd.MM.yyyy").format(DateTime.fromMillisecondsSinceEpoch(session.timestamp)))
                          .s(12)
                          .c(context.textSecondary),
                      SizedBox(height: 20),
                      Row(
                        spacing: 12,
                        children: [
                          Assets.imagesDaryo.device.svg(),
                          Expanded(
                            child: Column(
                              spacing: 4,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(session.deviceInfo).s(14).w(500).c(context.textPrimary),
                                Strings.app.s(12).w(400).c(context.textSecondary),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        spacing: 12,
                        children: [
                          Assets.imagesDaryo.location.svg(),
                          Expanded(
                            child: Column(
                              spacing: 4,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(session.location).s(14).w(500).c(context.textPrimary),
                                Strings.ipBasedGeolocation.s(12).w(400).c(context.textSecondary),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      CustomElevatedButton(
                          backgroundColor: context.redClickColor,
                          text: Strings.endSession,
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  ),
                ),
              );
            });
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.containerBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(12),
        child: Row(
          spacing: 12,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.primary,
              ),
              padding: EdgeInsets.all(6),
              child: Icon(
                Icons.android,
                color: Colors.white,
              ),
            ),
            Expanded(
                child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(session.deviceName).s(14).w(500).c(context.textPrimary),
                Text(session.deviceInfo).s(12).c(context.textPrimary),
                Text("${session.location} • ${DateFormat("H:mm dd.MM.yyyy").format(DateTime.fromMillisecondsSinceEpoch(session.timestamp))}")
                    .s(12)
                    .c(context.textSecondary),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class Session {
  final String deviceName;
  final String deviceInfo;
  final String location;
  final int timestamp;
  final bool isCurrent;

  Session({required this.deviceName, required this.deviceInfo, required this.location, required this.timestamp, required this.isCurrent});
}
