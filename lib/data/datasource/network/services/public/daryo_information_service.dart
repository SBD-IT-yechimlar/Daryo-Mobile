import 'package:dio/dio.dart';

import '../../constants/rest_query_keys.dart';

class DaryoInformationService {
  final Dio _dio;

  DaryoInformationService(this._dio);

  Future<Response> getSpecialists({required int limit, required int page}) {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: page,
    };
    return _dio.get("site/specialists", queryParameters: queryParameters);
  }
  Future<Response> getFaceBehinds({required int limit, required int page}) {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: page,
      RestQueryKeys.order: "date%2Bdesc",
    };
    return _dio.get("site/face-behind", queryParameters: queryParameters);
  }
}
