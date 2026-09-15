import 'dart:async';
import 'dart:io';
import 'package:daryo/presentation/support/firebase/firebase_notification_service.dart';
import 'package:daryo/presentation/support/firebase/local_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/core/gen/localization/strings.dart';
import 'package:daryo/data/datasource/network/constants/constants.dart';
import 'package:daryo/presentation/application/di/get_it_injection.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

import 'presentation/application/application.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await initializeGetIt();

    await EasyLocalization.ensureInitialized();

    try {
      LocalNotificationService.initialize();
      await Firebase.initializeApp();
      await FirebaseApi().initNotifications();
      print('✅ Firebase muvaffaqiyatli ulandi!');
    } catch (e) {
      print('❌ Firebase xatolik: $e');
    }

    await _getDeviceAndAppInfo();

    runApp(
      EasyLocalization(
        supportedLocales: Strings.supportedLocales,
        path: Assets.localization.translations,
        fallbackLocale: Strings.supportedLocales.first,
        assetLoader: CsvAssetLoader(),
        child: Application(),
      ),
    );
  }, (error, stackTrace) {
    Logger().e("application launch error = $error $stackTrace");
    // FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

Future<void> _getDeviceAndAppInfo() async {
  try {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var uuid = Uuid();
    DeviceInfo.deviceId = uuid.v4();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    DeviceInfo.appVersionName = packageInfo.version;
    DeviceInfo.appVersionCode = packageInfo.buildNumber;

    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfo.androidInfo;

      DeviceInfo.mobileOsType = "android";
      DeviceInfo.deviceName = "${info.manufacturer} ${info.model}";
      DeviceInfo.deviceModel = info.model;
      DeviceInfo.deviceManufacture = info.manufacturer;
    } else if (Platform.isIOS) {
      IosDeviceInfo info = await deviceInfo.iosInfo;

      DeviceInfo.mobileOsType = "ios";
      DeviceInfo.deviceName = info.name;
      DeviceInfo.deviceModel = info.model;
      DeviceInfo.deviceManufacture = info.systemName;
    }
  } catch (e) {
    print(e.toString());
  }
}




