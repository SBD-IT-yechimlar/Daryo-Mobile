import 'package:get_it/get_it.dart';
import 'package:daryo/presentation/stream_controllers/app_theme_mode_stream_controller.dart';
import 'package:daryo/presentation/stream_controllers/category_selection_stream_controller.dart';
import 'package:daryo/presentation/stream_controllers/language_selection_stream_controller.dart';
import 'package:daryo/presentation/stream_controllers/logout_event_stream_controller.dart';
import 'package:daryo/presentation/stream_controllers/region_selection_stream_controller.dart';

import '../../stream_controllers/update_profile_stream_controller.dart';

extension GetItModuleApp on GetIt {
  Future<void> streamControllerModule() async {
    registerLazySingleton(() => AppThemeModeStreamController());
    registerLazySingleton(() => CategorySelectionStreamController());
    registerLazySingleton(() => LanguageSelectionStreamController());
    registerLazySingleton(() => LogoutEventStreamController());
    registerLazySingleton(() => RegionSelectionStreamController());
    registerLazySingleton(() => UpdateProfileStreamController());
    await allReady();
  }
}
