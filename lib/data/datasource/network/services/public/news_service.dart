import 'package:dio/dio.dart';

class NewsService {
  final Dio _dio;

  NewsService(this._dio);

  Future<Response> getCalendarNews({required String date, required int limit,  required int offset , String order = 'date+desc'}) async {
    final queryParams = {
      "date": date, // masalan: 2025-08-23
      "limit": limit, // optional
      "offset": offset, // optional
      "order": order, // optional
    };
    return _dio.get("site/calendar-news", queryParameters: queryParams);
  }


  /*Future<Response> getSubscriptions() async {
    return _dio.get("cabinet/subscriptions?limit=12&offset=0");
  }*/
}
