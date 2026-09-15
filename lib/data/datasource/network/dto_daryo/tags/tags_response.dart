import 'package:freezed_annotation/freezed_annotation.dart';

part 'tags_response.freezed.dart';
part 'tags_response.g.dart';

@freezed
abstract class TagsResponse with _$TagsResponse {
  const factory TagsResponse({
    @JsonKey(name: 'data') List<Data>? data,
    @JsonKey(name: 'total') int? total,
  }) = _TagsResponse;

  factory TagsResponse.fromJson(Map<String, Object?> json) => _$TagsResponseFromJson(json);
}

@freezed
abstract class Data with _$Data {
  const factory Data({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'sort_order') int? sortOrder,
    @JsonKey(name: 'status') bool? status,
  }) = _Data;

  factory Data.fromJson(Map<String, Object?> json) => _$DataFromJson(json);
}

