import 'package:dio/dio.dart';

class DaryoSubscriptionService {
  final Dio _dio;

  DaryoSubscriptionService(this._dio);

  Future<Response> getTariffs() {
    return _dio.get("site/tariffs");
  }
}