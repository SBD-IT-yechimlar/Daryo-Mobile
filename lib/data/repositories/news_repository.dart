import 'package:daryo/data/datasource/network/services/public/news_service.dart';
import 'package:dio/dio.dart';

import '../datasource/network/dto/news_history/news_history_response.dart';

class NewsRepository {
  final NewsService _newsService;

  NewsRepository(this._newsService);

  Future<Response> getCalendarNews({required String date, int limit = 16, int offset = 0, String order = 'date+desc'}) async {
    final response = await _newsService.getCalendarNews(
      date: date,
      limit: limit,
      offset: offset,
      order: order,
    );
    return response;
  }

  Future<List<NewsHistoryList>> getCalendarNewsV2({required String date, required int limit,  required int offset, String order = 'date+desc'}) async {
    final response = await _newsService.getCalendarNews(date: date, limit: limit, offset: offset);
    final listResponse = NewsHistoryResponse.fromJson(response.data).data ?? [];
    return listResponse;
  }



}
