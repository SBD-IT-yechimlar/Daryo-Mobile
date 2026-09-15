import 'package:freezed_annotation/freezed_annotation.dart';

part 'shorts_response.freezed.dart';
part 'shorts_response.g.dart';

@freezed
abstract class ShortsResponse with _$ShortsResponse {
  const factory ShortsResponse({
    @JsonKey(name: 'data') List<ShortsItemResponse>? data,
    @JsonKey(name: 'success') bool? success,
    @JsonKey(name: 'total') int? total,
  }) = _ShortsResponse;

  factory ShortsResponse.fromJson(Map<String, Object?> json) => _$ShortsResponseFromJson(json);
}

@freezed
abstract class ShortsItemResponse with _$ShortsItemResponse {
  const factory ShortsItemResponse({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'date') String? date,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'created_by') int? createdBy,
    @JsonKey(name: 'updated_by') int? updatedBy,
    @JsonKey(name: 'link') String? link,
    @JsonKey(name: 'status') bool? status,
  }) = _ShortsItemResponse;

  factory ShortsItemResponse.fromJson(Map<String, Object?> json) => _$ShortsItemResponseFromJson(json);
}

