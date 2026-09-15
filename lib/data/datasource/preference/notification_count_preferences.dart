import 'package:injectable/injectable.dart';
import 'package:daryo/data/datasource/preference/preferences_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationCountPreferences {
  final SharedPreferences _preferences;

  NotificationCountPreferences(this._preferences);

  static const String _keyUnreadCount = 'notification_unread_count';
  static const String _keyTotalCount = 'notification_total_count';
  static const String _keyUpdateAt = 'notification_count_update_at';

  @factoryMethod
  static Future<NotificationCountPreferences> create() async {
    final prefs = await SharedPreferences.getInstance();
    return NotificationCountPreferences(prefs);
  }

  int get unreadCount {
    try {
      return _preferences.getInt(_keyUnreadCount) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  int get totalCount {
    try {
      return _preferences.getInt(_keyTotalCount) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  int? get updateAt {
    try {
      return _preferences.getInt(_keyUpdateAt);
    } catch (e) {
      return null;
    }
  }

  bool get isExpired {
    final lastUpdateAt = updateAt;
    if (lastUpdateAt == null || unreadCount == 0) return true;
    final now = DateTime.now().millisecondsSinceEpoch;
    final difference = (now - lastUpdateAt);
    const expireDifference = Duration.millisecondsPerMinute * 5;
    return difference >= expireDifference;
  }

  Future<void> setUnreadCount(int unreadCount) async {
    await _preferences.setOrRemove(_keyUnreadCount, unreadCount);
    await _preferences.setOrRemove(
      _keyUpdateAt,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<void> setTotalCount(int totalCount) async =>
      await _preferences.setOrRemove(_keyTotalCount, totalCount);

  Future<void> clear() async {
    try {
      await _preferences.remove(_keyUnreadCount);
      await _preferences.remove(_keyTotalCount);
    } catch (e) {
      print('Error clearing preferences: $e');
    }
  }
}
