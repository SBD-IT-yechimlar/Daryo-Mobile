import 'package:get_it/get_it.dart';
import 'package:daryo/data/datasource/preference/auth_preferences.dart';
import 'package:daryo/data/datasource/preference/language_preferences.dart';
import 'package:daryo/data/datasource/preference/notification_count_preferences.dart';
import 'package:daryo/data/datasource/preference/region_preferences.dart';
import 'package:daryo/data/datasource/preference/theme_mode_preferences.dart';
import 'package:daryo/data/datasource/preference/user_preferences.dart';

extension GetItModulePreference on GetIt {
  Future<void> preferencesModule() async {
    registerSingletonAsync(() async => await AuthPreferences.create());
    registerSingletonAsync(() async => await LanguagePreferences.create());
    registerSingletonAsync(() async => await NotificationCountPreferences.create());
    registerSingletonAsync(() async => await RegionPreferences.create());
    registerSingletonAsync(() async => await ThemeModePreferences.create());
    registerSingletonAsync(() async => await UserPreferences.create());
    await allReady();
  }
}
