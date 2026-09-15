import 'package:dio/dio.dart';

import '../../constants/rest_query_keys.dart';

class CategoryService {
  final Dio _dio;

  CategoryService(this._dio);

  Future<Response> getNewsBySlug({required int limit, required int page, required String slug}) {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: page,
    };
    return _dio.get("site/category/news/$slug", queryParameters: queryParameters);
  }

}
