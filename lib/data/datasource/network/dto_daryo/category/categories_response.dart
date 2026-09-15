import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories_response.freezed.dart';
part 'categories_response.g.dart';

@freezed
abstract class CategoriesResponse with _$CategoriesResponse {
  const factory CategoriesResponse({
    @JsonKey(name: 'data') List<CategoryResponse>? data,
  }) = _CategoriesResponse;

  factory CategoriesResponse.fromJson(Map<String, Object?> json) => _$CategoriesResponseFromJson(json);
}

@freezed
abstract class CategoryResponse with _$CategoryResponse {
  const factory CategoryResponse({
    @JsonKey(name: 'children') List<CategoryResponse>? children,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'full_title') String? fullTitle,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'meta_desc') String? metaDesc,
    @JsonKey(name: 'meta_keywords') String? metaKeywords,
    @JsonKey(name: 'meta_title') String? metaTitle,
    @JsonKey(name: 'news_url') String? newsUrl,
    @JsonKey(name: 'parent_id') int? parentId,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'sort_order') int? sortOrder,
    @JsonKey(name: 'status') bool? status,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _CategoryResponse;

  factory CategoryResponse.fromJson(Map<String, Object?> json) => _$CategoryResponseFromJson(json);
}


