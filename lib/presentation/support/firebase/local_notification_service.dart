import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  late AndroidNotificationChannel channel;
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initializationSettings = InitializationSettings(
      android: const AndroidInitializationSettings("@drawable/notification_app"),
      iOS: DarwinInitializationSettings(
          defaultPresentSound: true,
          defaultPresentAlert: true,
          defaultPresentBadge: true,
          // requestAlertPermission: true,
          // requestBadgePermission: true,
          // requestSoundPermission: true,
          onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {}),
    );
    _notificationsPlugin.initialize(initializationSettings);
  }

  void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            color: Color(0xFFF8635E),
            icon: "@drawable/notification_app",
            "channel.id",
            "channel.name",
            channelDescription: "channel.description",
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            sound: RawResourceAndroidNotificationSound('alarm'),
          ),
          iOS: DarwinNotificationDetails(
            presentBanner: true,
            presentList: true,
            presentSound: true,
            presentBadge: true,
            presentAlert: true,
            threadIdentifier: "appName",
            sound: "alarm.wav",
            interruptionLevel: InterruptionLevel.active,
          ));
      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    } on Exception catch (e) {
      debugPrint("$e");
    }
  }
}
