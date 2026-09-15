import 'package:freezed_annotation/freezed_annotation.dart';

part 'sliders_response.freezed.dart';
part 'sliders_response.g.dart';

@freezed
abstract class SlidersResponse with _$SlidersResponse {
  const factory SlidersResponse({
    @JsonKey(name: 'data') List<SliderItemResponse>? data,
    @JsonKey(name: 'total') int? total,
  }) = _SlidersResponse;

  factory SlidersResponse.fromJson(Map<String, Object?> json) => _$SlidersResponseFromJson(json);
}

@freezed
abstract class SliderItemResponse with _$SliderItemResponse {
  const factory SliderItemResponse({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'content') String? content,
    @JsonKey(name: 'img') String? img,
    @JsonKey(name: 'news_id') String? newsId,
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'category_slug') String? categorySlug,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'date') String? date,
    @JsonKey(name: 'status') String? status,
  }) = _SliderItemResponse;

  factory SliderItemResponse.fromJson(Map<String, Object?> json) => _$SliderItemResponseFromJson(json);
}

