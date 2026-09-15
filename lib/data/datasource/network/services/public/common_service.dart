import 'package:dio/dio.dart';
import 'package:daryo/data/datasource/network/constants/rest_query_keys.dart';

class CommonService {
  final Dio _dio;

  CommonService(this._dio);

  Future<Response> getRadioFmList({required int limit, required int page}) async {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: page,
      RestQueryKeys.order: "sort_order+desc",
    };
    return _dio.get("site/daryo-fm/list", queryParameters: queryParameters);
  }

  Future<Response> getSearchHashTag({required int limit, required int page, required String tag}) async {
    final queryParameters = {
      "q": tag,
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: page,
      // RestQueryKeys.order: "sort_order+desc",
    };
    return _dio.get("site/search/hashtags", queryParameters: queryParameters);
  }

  Future<Response> getSearchNews({required int limit, required int page, required String query}) async {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: page,
      RestQueryKeys.searchQuery: query,
    };
    return _dio.get("site/search", queryParameters: queryParameters);
  }


}
