import 'package:freezed_annotation/freezed_annotation.dart';

part 'recommendation_response.freezed.dart';
part 'recommendation_response.g.dart';

@freezed
class RecommendationResponse with _$RecommendationResponse {
  const factory RecommendationResponse({
    List<RecommendationItemResponse>? data,
    int? total,
  }) = _RecommendationResponse;

  factory RecommendationResponse.fromJson(Map<String, dynamic> json) =>
      _$RecommendationResponseFromJson(json);
}

@freezed
class RecommendationItemResponse with _$RecommendationItemResponse {
  const factory RecommendationItemResponse({
    int? id,
    String? title,
    String? content,
    @JsonKey(name: 'short_content') String? shortContent,
    String? category,
    @JsonKey(name: 'category_slug') String? categorySlug,
    String? type,
    @JsonKey(name: 'news_id') String? newsId,
    String? url,
    String? img,
    int? views,
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
    String? author,
    @JsonKey(name: 'u_link') String? uLink,
    @JsonKey(name: 'category_ids') List<dynamic>? categoryIds,
    @JsonKey(name: 'is_lock') int? isLock,
    @JsonKey(name: 'is_important') bool? isImportant,
    @JsonKey(name: 'published_by') int? publishedBy,
    String? slug,
    String? date,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _RecommendationItemResponse;

  factory RecommendationItemResponse.fromJson(Map<String, dynamic> json) =>
      _$RecommendationItemResponseFromJson(json);
}