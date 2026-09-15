import 'package:dio/dio.dart';
import '../../../../domain/models/logout_event/logout_event_type.dart';
import '../../../../presentation/stream_controllers/logout_event_stream_controller.dart';
import '../../floor/dao/user_entity_dao.dart';
import '../../preference/auth_preferences.dart';
import '../../preference/user_preferences.dart';
import '../constants/rest_header_keys.dart';

class AuthInterceptor extends Interceptor {
  final AuthPreferences _authPreferences;
  final LogoutEventStreamController _logoutEventStreamController;
  final UserEntityDao _userEntityDao;
  final UserPreferences _userPreferences;

  AuthInterceptor(
    this._authPreferences,
    this._logoutEventStreamController,
    this._userEntityDao,
    this._userPreferences,
  );

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var token = _authPreferences.token;
    if (token.isNotEmpty) {
      final headers = {RestHeaderKeys.authorization: "Bearer $token"};
      options.headers.addAll(headers);
    }

    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        await _authPreferences.clear();
        await _userEntityDao.clear();
        await _userPreferences.clear();

        _logoutEventStreamController.add(LogoutEvent.onTokenExpired);

        // final requestOptions = err.requestOptions;
        // final path = requestOptions.path;
        // final actualHeaders = requestOptions.headers
        //   ..remove(RestHeaderKeys.authorization);

        // final options = Options(
        //   method: err.requestOptions.method,
        //   headers: actualHeaders,
        // );

        // final Dio dio = Dio();

        // final response = await dio.request(path, options: options);
        // return handler.resolve(response);

        return handler.next(err);
      } on DioError catch (e) {
        return handler.next(e);
      }
    }

    return handler.next(err);
  }
}
