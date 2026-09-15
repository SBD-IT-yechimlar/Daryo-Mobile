import 'package:daryo/data/repositories/category_repository.dart';
import 'package:daryo/data/repositories/daryo_fm_repository.dart';
import 'package:daryo/data/repositories/daryo_information_repository.dart';
import 'package:get_it/get_it.dart';

import 'package:daryo/data/repositories/auth_repository.dart';
import 'package:daryo/data/repositories/common_repository.dart';
import 'package:daryo/data/repositories/language_repository.dart';
import 'package:daryo/data/repositories/state_repository.dart';
import 'package:daryo/data/repositories/theme_mode_repository.dart';
import '../../../data/repositories/account_repository.dart';
import '../../../data/repositories/daryo_subscription_repository.dart';
import '../../../data/repositories/dashboard_repository.dart';
import '../../../data/repositories/favorites_repository.dart';
import '../../../data/repositories/news_repository.dart';
import '../../../data/repositories/recommendation_repository.dart';

extension GetItModuleExtension on GetIt {
  Future<void> repositoryModule() async {
    registerLazySingleton(() => StateRepository(get(), get()));

    registerLazySingleton(
      () => LanguageRepository(get(), get(), get(), get(), get()),
    );

    registerLazySingleton(
        () => AuthRepository(get(), get(), get(), get(), get(), get(), get()));

    registerLazySingleton(() => CommonRepository(
          get(),
        ));
    registerLazySingleton(() => ThemeModeRepository(get()));

    ///
    registerLazySingleton(() => DaryoFmRepository(get()));
    registerLazySingleton(() => RecommendationRepository(get()));
    registerLazySingleton(() => DaryoDashboardRepository(get()));
    registerLazySingleton(() => DaryoInformationRepository(get()));
    registerLazySingleton(() => DaryoSubscriptionRepository(get()));
    registerLazySingleton(() => CategoryRepository(get()));
    registerLazySingleton(() => AccountRepository(get(), get(), get()));
    registerLazySingleton(() => FavoritesRepository(get()));
    registerLazySingleton(() => NewsRepository(get()));

    await allReady();
  }
}
