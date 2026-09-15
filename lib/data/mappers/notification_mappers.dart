import 'package:daryo/data/datasource/network/dto/notification/app_notification_response.dart';
import 'package:daryo/domain/models/notification/notification.dart';

extension AppNotificationRootResponseMapper on DataResponse {
  AppNotificationInfo toAppNotificationInfo() {
    return AppNotificationInfo(
      unreadCount: unreadCount,
      totalCount: totalCount,
      results: results?.map((e) => e.toAppNotification()).toList() ?? [],
    );
  }
}

extension AppNotificationResponseMapper on AppNotificationResponse {
  AppNotification toAppNotification() {
    return AppNotification(
      id: id,
      createdAt: createdAt,
      tinOrPinfl: tinOrPinfl,
      title: title,
      message: message,
      link: link,
      status: status,
    );
  }
}
