import 'package:freezed_annotation/freezed_annotation.dart';

part 'recommendation_response.freezed.dart';
part 'recommendation_response.g.dart';
@freezed
class CommonResponse with _$CommonResponse {
  const factory CommonResponse({
    required List<CommonItemResponse>? data,
    required int? total,
  }) = _CommonResponse;

  factory CommonResponse.fromJson(Map<String, dynamic> json) =>
      _$CommonResponseFromJson(json);
}

@freezed
abstract class CommonItemResponse with _$CommonItemResponse {
  const factory CommonItemResponse({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'content') String? content,
    @JsonKey(name: 'short_content') String? shortContent,
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'category_slug') String? categorySlug,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'news_id') String? newsId,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'img') String? img,
    @JsonKey(name: 'views') int? views,
    @JsonKey(name: 'author_id') int? authorId,
    @JsonKey(name: 'author_name') String? authorName,
    @JsonKey(name: 'author_fio') String? authorFio,
    @JsonKey(name: 'author_photo') String? authorPhoto,
    @JsonKey(name: 'has_oz') bool? hasOz,
    @JsonKey(name: 'has_uz') bool? hasUz,
    @JsonKey(name: 'has_en') bool? hasEn,
    @JsonKey(name: 'has_ru') bool? hasRu,
    @JsonKey(name: 'has_images') bool? hasImages,
    @JsonKey(name: 'has_video') bool? hasVideo,
    @JsonKey(name: 'has_audio') bool? hasAudio,
    @JsonKey(name: 'author') String? author,
    @JsonKey(name: 'u_link') String? uLink,
    @JsonKey(name: 'category_ids') dynamic categoryIds,
    @JsonKey(name: 'is_lock') int? isLock,
    @JsonKey(name: 'is_important') bool? isImportant,
    @JsonKey(name: 'published_by') int? publishedBy,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'date') String? date,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _CommonItemResponse;

  factory CommonItemResponse.fromJson(Map<String, Object?> json) => _$CommonItemResponseFromJson(json);
}

