import 'package:daryo/data/datasource/network/services/public/account_service.dart';
import 'package:daryo/data/datasource/network/services/public/category_service.dart';
import 'package:daryo/data/datasource/network/services/public/daryo_fm_service.dart';
import 'package:daryo/data/datasource/network/services/public/daryo_information_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:daryo/data/datasource/network/constants/constants.dart';
import 'package:daryo/data/datasource/network/interceptor/auth_interceptor.dart';
import 'package:daryo/data/datasource/network/interceptor/common_interceptor.dart';
import 'package:daryo/data/datasource/network/interceptor/error_interceptor.dart';
import 'package:daryo/data/datasource/network/interceptor/language_interceptor.dart';
import 'package:daryo/data/datasource/network/interceptor/region_interceptor.dart';
import 'package:daryo/data/datasource/network/services/private/auth_service.dart';
import 'package:daryo/data/datasource/network/services/private/card_service.dart';
import 'package:daryo/data/datasource/network/services/private/favorite_service.dart';
import 'package:daryo/data/datasource/network/services/private/identity_service.dart';
import 'package:daryo/data/datasource/network/services/public/dashboard_service.dart';
import 'package:daryo/data/datasource/network/services/public/report_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../data/datasource/network/services/public/common_service.dart';
import '../../../data/datasource/network/services/public/daryo_subscription_service.dart';
import '../../../data/datasource/network/services/public/favorites_service.dart';
import '../../../data/datasource/network/services/public/news_service.dart';
import '../../../data/datasource/network/services/public/recommendation_service.dart';

import '../../../data/datasource/network/services/public/daryo_dashboard_service.dart';
import '../../support/connection/connectivity_provider.dart';

const String private = "dio_with_authorization";
const String public = "dio_without_authorization";

extension GetItModuleNetwork on GetIt {
  Future<void> networkModule() async {
    registerLazySingleton(() => AuthInterceptor(get(), get(), get(), get(),),);
    registerLazySingleton(() => CommonInterceptor());
    registerLazySingleton(() => LanguageInterceptor(get()));
    registerLazySingleton(() => ErrorInterceptor());
    registerLazySingleton(() => RegionInterceptor(get()));

    registerLazySingleton(
          () => InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          options.headers.addAll(<String, String>{});
          handler.next(options);
        },
      ),
    );
    registerLazySingleton(
          () => PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    AuthInterceptor authInterceptor = get();
    CommonInterceptor commonInterceptor = get();
    LanguageInterceptor languageInterceptor = get();
    RegionInterceptor regionInterceptor = get();
    ErrorInterceptor errorInterceptor = get();
    InterceptorsWrapper headerInterceptor = get();
    PrettyDioLogger loggerInterceptor = get();

    ///
    /// Providing public dio and services
    ///

    registerSingleton<Dio>(
      provideDio(
        interceptors: [
          commonInterceptor,
          languageInterceptor,
          regionInterceptor,
          loggerInterceptor,
          errorInterceptor,
          headerInterceptor,
        ],
      ),
      instanceName: public,
    );

    registerLazySingleton(() => ConnectivityService());
    registerLazySingleton(() => DashboardService(get(instanceName: public)));
    registerLazySingleton(() => ReportService(get(instanceName: public)));
    registerLazySingleton(() => CommonService(get(instanceName: public)));

    ///
    registerLazySingleton(() => DaryoFmService(get(instanceName: public)));
    registerLazySingleton(() => RecommendationService(get(instanceName: public)));

    registerLazySingleton(() => DaryoDashboardService(get(instanceName: public)));
    registerLazySingleton(() => CategoryService(get(instanceName: public)));
    registerLazySingleton(() => DaryoInformationService(get(instanceName: public)));
    registerLazySingleton(() => FavoritesService(get(instanceName: public)));
    registerLazySingleton(() => DaryoSubscriptionService(get(instanceName: public)));
    registerLazySingleton(() => NewsService(get(instanceName: public)));

    ///
    /// Providing private dio and services
    ///

    registerSingleton<Dio>(
      provideDio(
        interceptors: [
          authInterceptor,
          commonInterceptor,
          languageInterceptor,
          loggerInterceptor,
          errorInterceptor,
          headerInterceptor,
        ],
      ),
      instanceName: private,
    );


    registerLazySingleton(() => AuthService(get(instanceName: private)));
    registerLazySingleton(() => CardService(get(instanceName: private)));
    registerLazySingleton(() => FavoriteService(get(instanceName: private)));
    registerLazySingleton(() => IdentityService(get(instanceName: private)));
    registerLazySingleton(() => AccountService(get(instanceName: private)));



    ///

    await allReady();
  }
}

Dio provideDio({List<Interceptor> interceptors = const []}) {
  final Dio dio = Dio();

  final timeout = Duration(seconds: 120);
  final options = BaseOptions(
    baseUrl: Constants.baseUrl,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  dio.options = options
    ..connectTimeout = timeout
    ..receiveTimeout = timeout
    ..sendTimeout = timeout;

  dio.interceptors.addAll(interceptors);

  return dio;
}
