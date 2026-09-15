import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'local_notification_service.dart';



Future<void> handleBackgroundMessage(RemoteMessage message) async {

  debugPrint("Title: ${message.notification?.title}");
  debugPrint("Body: ${message.notification?.body}");
  debugPrint("Data: ${message.data}");
  debugPrint("Handling a background message: ${message.messageId}");
}

class FirebaseApi {
  late AndroidNotificationChannel channel;
  String? fcmToken;
  final _firebaseMessaging = FirebaseMessaging.instance;


  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
  /// appRouter.push(NotificationEntryRoute());
  }

  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        handleMessage(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(message);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission(
      sound: true,
      alert: true,
      badge: true,
    );
    channel = const AndroidNotificationChannel('high_importance_channel', 'High Importance Notifications',
        description: 'This channel is used for important notifications.', importance: Importance.high,playSound: true);
    var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    if (Platform.isAndroid) {
      await FirebaseMessaging.instance.setAutoInitEnabled(true);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        LocalNotificationService().display(message);
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                color: Color(0xFFF8635E),
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: "@drawable/notification_app",
                sound: RawResourceAndroidNotificationSound('alarm'),
                playSound: true,
                // largeIcon: ByteArrayAndroidBitmap.fromBase64String(await networkImageToBase64(message.data["userPhoto"]))
              ),
            ),
          );
        }
      },
      );
    } else if (Platform.isIOS) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        const AppleNotificationSound(name: "alarm.wav", critical: true, volume: 100);
        // LocalNotificationService().display(message);
        RemoteNotification? notification = message.notification;
        if (notification != null) {
          debugPrint("AAA");
          flutterLocalNotificationsPlugin.show(notification.hashCode, notification.title, notification.body,
              const NotificationDetails(iOS: DarwinNotificationDetails(sound: "alarm.wav", presentSound: true, presentAlert: true, interruptionLevel: InterruptionLevel.active)));
        }
      },
      );
    }

    if (Platform.isIOS) {
      String? apnsToken = await _firebaseMessaging.getAPNSToken();
      debugPrint("APNS Token: $apnsToken");
      fcmToken = await _firebaseMessaging.getToken();
      debugPrint("FCM Token: $fcmToken");
      if (apnsToken == null) {
        debugPrint('APNS token not available');
        return;
      }
    } else {
      fcmToken = await _firebaseMessaging.getToken();
      debugPrint("FCM Token: $fcmToken");
    }

    await initPushNotifications();
  }

  Future<String?> getFcmToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      print("📌 FCM Token: $token");
      return token;
    } catch (e) {
      print("❌ FCM token olishda xatolik: $e");
      return null;
    }
  }
}
