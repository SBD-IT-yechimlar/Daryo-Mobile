import 'package:freezed_annotation/freezed_annotation.dart';

part 'videos_response.freezed.dart';
part 'videos_response.g.dart';

@freezed
abstract class VideosResponse with _$VideosResponse {
  const factory VideosResponse({
    @JsonKey(name: 'data') List<VideoItemResponse>? data,
    @JsonKey(name: 'total') int? total,
  }) = _VideosResponse;

  factory VideosResponse.fromJson(Map<String, Object?> json) => _$VideosResponseFromJson(json);
}

@freezed
abstract class VideoItemResponse with _$VideoItemResponse {
  const factory VideoItemResponse({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'short_content') String? shortContent,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'video') String? video,
    @JsonKey(name: 'ULink') String? ULink,
    @JsonKey(name: 'status') bool? status,
    @JsonKey(name: 'date') String? date,
    @JsonKey(name: 'sort_order') int? sortOrder,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _VideoItemResponse;

  factory VideoItemResponse.fromJson(Map<String, Object?> json) => _$VideoItemResponseFromJson(json);
}

