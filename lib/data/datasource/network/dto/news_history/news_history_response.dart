import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'news_history_response.freezed.dart';
part 'news_history_response.g.dart';

/*NewsHistoryResponse newsHistoryResponseFromMap(String str) => NewsHistoryResponse.fromMap(json.decode(str));

String newsHistoryResponseToMap(NewsHistoryResponse data) => json.encode(data.toMap());*/

@freezed
class NewsHistoryResponse with _$NewsHistoryResponse {
  const factory NewsHistoryResponse({
    List<NewsHistoryList>? data,
    int? total,
  }) = _NewsHistoryResponse;

  factory NewsHistoryResponse.fromJson(Map<String, dynamic> json) => _$NewsHistoryResponseFromJson(json);
}

@freezed
class NewsHistoryList with _$NewsHistoryList {
  const factory NewsHistoryList({
    int? id,
    String? title,
    String? content,
    String? img,
    String? newsId,
    String? category,
    String? categorySlug,
    String? url,
    String? slug,
    String? date,
    String? status,
  }) = _NewsHistoryList;

  factory NewsHistoryList.fromJson(Map<String, dynamic> json) => _$NewsHistoryListFromJson(json);
}
