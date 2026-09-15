import 'package:daryo/data/datasource/network/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../constants/rest_query_keys.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DaryoDashboardService {
  final Dio _dio;

  DaryoDashboardService(this._dio);

  Future<Response> getRecommendations({required int limit, required int page}) {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: page,
    };
    return _dio.get("site/news/recommended", queryParameters: queryParameters);
  }

  Future<Response> getMenuCategory({required String slug}) {
    final queryParameters = {
      RestQueryKeys.limit: 5,
      RestQueryKeys.offset: 0,
    };
    return _dio.get("site/category/news/$slug", queryParameters: queryParameters);
  }

  Future<Response> getDashboardAsiaNews({required int id}) {
    final queryParameters = {
      RestQueryKeys.limit: 5,
      RestQueryKeys.offset: 0,
    };
    return _dio.get("site/news/by-category/$id", queryParameters: queryParameters);
  }

  Future<Response> getHotNews({required int limit, required int page}) {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: page,
    };
    return _dio.get("site/news-latest", queryParameters: queryParameters);
  }

  Future<Response> getDunyoNews({required int limit, required int page}) {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: page,
      "category_id": 2,
      "type": "news"
    };
    return _dio.get("site/news/list", queryParameters: queryParameters);
  }

  Future<Response> getAutoNews({required int limit, required int page}) {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: page,
    };
    return _dio.get("site/news-latest", queryParameters: queryParameters);
  }

  Future<Response> getLatestNews({required int limit, required int page}) {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: page,
    };
    return _dio.get("site/news-latest", queryParameters: queryParameters);
  }

  Future<Response> getTags({required int limit, required int page}) {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: page,
    };
    return _dio.get("site/tag/list");
  }

  Future<Response> getShorts({required int limit, required int page}) {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: page,
      RestQueryKeys.order: "date%2Bdesc",
    };
    return _dio.get("site/shorts/list", queryParameters: queryParameters);
  }

  Future<Response> getVideos({required int limit, required int page}) {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: page,
      RestQueryKeys.order: "date%2Bdesc",
    };
    return _dio.get("site/video/list", queryParameters: queryParameters);
  }

  Future<Response> getSliders({required int limit, required int page}) {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: page,
      RestQueryKeys.order: "date%2Bdesc",
    };
    return _dio.get("site/news-slider", queryParameters: queryParameters);
  }

  Future<Response> getRelatedNewsByTag({required int limit, required int offset, required String tag}) {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.offset: offset,
      RestQueryKeys.order: "date%2Bdesc",
      "q": tag,
    };
    return _dio.get("site/search/hashtags", queryParameters: queryParameters);
  }

  /// get news detail
  Future<Response> getContentDetail({required String slug}) {
    return _dio.get("site/news/$slug");
  }

  Future<Response> getCategories() {
    return _dio.get(
      "site/category/list",
    );
  }

/*
  Future<Response> likeOrDislike(int postId, String action) {
    final queryParameters = {
     "post_id": postId,
      "action": action,
    };
    return _dio.post("site/like-dislike", data: queryParameters);
  }
*/


  Future<Map<String, dynamic>> likeOrDislike(int postId, String action) async {
    final url = Uri.parse("${Constants.baseUrl}site/like-dislike");
    final body = {
      "post_id": postId,
      "action": action,
    };

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    Logger().w("scscsd00 ${response.body}");


    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // agar error bo‘lsa ham JSON bo‘lishi mumkin
      try {
        return jsonDecode(response.body);
      } catch (_) {
        throw Exception("Xatolik: ${response.body}");
      }
    }
  }





}
