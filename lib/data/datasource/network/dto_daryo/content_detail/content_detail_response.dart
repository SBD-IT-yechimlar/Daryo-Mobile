import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_detail_response.freezed.dart';
part 'content_detail_response.g.dart';

@freezed
abstract class ContentDetailResponse with _$ContentDetailResponse {
  const factory ContentDetailResponse({
    @JsonKey(name: 'author') String? author,
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'category_slug') String? categorySlug,
    @JsonKey(name: 'comments') List<dynamic>? comments,
    @JsonKey(name: 'content') String? content,
    @JsonKey(name: 'date') String? date,
    @JsonKey(name: 'dislikes_count') int? dislikesCount,
    @JsonKey(name: 'expired') bool? expired,
    @JsonKey(name: 'hashtag') String? hashtag,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'images') List<Images>? images,
    @JsonKey(name: 'likes_count') int? likesCount,
    @JsonKey(name: 'meta_desc') String? metaDesc,
    @JsonKey(name: 'meta_keywords') String? metaKeywords,
    @JsonKey(name: 'meta_title') String? metaTitle,
    @JsonKey(name: 'news_id') String? newsId,
    @JsonKey(name: 'short_content') String? shortContent,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'views') int? views,
  }) = _ContentDetailResponse;

  factory ContentDetailResponse.fromJson(Map<String, Object?> json) => _$ContentDetailResponseFromJson(json);
}

@freezed
abstract class Images with _$Images {
  const factory Images({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'ext') String? ext,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'path') String? path,
    @JsonKey(name: 'size') String? size,
    @JsonKey(name: 'excerpt') String? excerpt,
    @JsonKey(name: 'source') String? source,
    @JsonKey(name: 'is_main') bool? isMain,
    @JsonKey(name: 'sort_order') int? sortOrder,
  }) = _Images;

  factory Images.fromJson(Map<String, Object?> json) => _$ImagesFromJson(json);
}

