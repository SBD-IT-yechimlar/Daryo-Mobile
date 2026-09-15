import 'package:freezed_annotation/freezed_annotation.dart';

part 'face_behind_response.freezed.dart';
part 'face_behind_response.g.dart';

@freezed
abstract class FaceBehindResponse with _$FaceBehindResponse {
  const factory FaceBehindResponse({
    @JsonKey(name: 'data') List<FaceBehindItemResponse>? data,
    @JsonKey(name: 'total') int? total,
  }) = _FaceBehindResponse;

  factory FaceBehindResponse.fromJson(Map<String, Object?> json) => _$FaceBehindResponseFromJson(json);
}

@freezed
abstract class FaceBehindItemResponse with _$FaceBehindItemResponse {
  const factory FaceBehindItemResponse({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'video') String? video,
    @JsonKey(name: 'link') String? link,
    @JsonKey(name: 'fio') String? fio,
    @JsonKey(name: 'date') String? date,
    @JsonKey(name: 'created_by') int? createdBy,
    @JsonKey(name: 'updated_by') int? updatedBy,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'status') bool? status,
  }) = _FaceBehindItemResponse;

  factory FaceBehindItemResponse.fromJson(Map<String, Object?> json) => _$FaceBehindItemResponseFromJson(json);
}

