import 'package:dio/dio.dart';
import 'package:daryo/data/datasource/network/constants/rest_query_keys.dart';
import 'package:daryo/domain/models/stats/stats_type.dart';

class DaryoFmService {
  final Dio _dio;

  DaryoFmService(this._dio);

  Future<Response> getRadioFmList({required int limit, required int page}) async {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: page,
      RestQueryKeys.order: "sort_order+desc",
    };
    return _dio.get("site/daryo-fm/list", queryParameters: queryParameters);
  }

}
