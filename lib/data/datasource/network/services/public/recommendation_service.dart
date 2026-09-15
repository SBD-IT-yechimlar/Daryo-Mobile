import 'package:dio/dio.dart';
import 'package:daryo/data/datasource/network/constants/rest_query_keys.dart';
import 'package:daryo/domain/models/stats/stats_type.dart';

class RecommendationService {
  final Dio _dio;

  RecommendationService(this._dio);

  Future<Response> getRecommendations({required int limit, required int page}) async {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: page,
     // RestQueryKeys.order: "sort_order+desc",
    };
    return _dio.get("site/news/recommended", queryParameters: queryParameters);
  }

  Future<Response> getLastNews({required int limit, required int page}) async {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: page,
    };
    return _dio.get("site/news-latest", queryParameters: queryParameters);
  }

}
