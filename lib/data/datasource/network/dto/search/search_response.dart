import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_response.freezed.dart';
part 'search_response.g.dart';

@freezed
class SearchResponse with _$SearchResponse {
  const factory SearchResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required Data data,
    dynamic response,
  }) = _SearchResponse;

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    required List<SearchAdResponse> ads,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class SearchAdResponse with _$SearchAdResponse {
  const factory SearchAdResponse({
    @JsonKey(name: "id") required int adId,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "category_id")  int? categoryId,
    @JsonKey(name: "main_photo") String? adImage,
    @JsonKey(name: "price") int? price,
    @JsonKey(name: "type") String? priorityLevel,
  }) = _SearchAdResponse;

  factory SearchAdResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchAdResponseFromJson(json);
}
