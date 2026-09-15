import 'package:freezed_annotation/freezed_annotation.dart';

part 'banners_response.freezed.dart';
part 'banners_response.g.dart';

@freezed
class DaryoIntroResponse with _$DaryoIntroResponse {
  const factory DaryoIntroResponse({
    required Map<String, DaryoIntroItemResponse> data,
    required int total,
  }) = _DaryoIntroResponse;

  factory DaryoIntroResponse.fromJson(Map<String, dynamic> json) =>
      _$DaryoIntroResponseFromJson(json);
}

@freezed
class DaryoIntroItemResponse with _$DaryoIntroItemResponse {
  const factory DaryoIntroItemResponse({
    required int id,
    required String image,
    @JsonKey(name: 'title_oz') required String titleOz,
    @JsonKey(name: 'title_ru') required String titleRu,
    @JsonKey(name: 'title_en') required String titleEn,
    required String name,
    @JsonKey(name: 'created_by') required int createdBy,
    @JsonKey(name: 'updated_by') required int updatedBy,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    required bool status,
  }) = _DaryoIntroItemResponse;

  factory DaryoIntroItemResponse.fromJson(Map<String, dynamic> json) =>
      _$DaryoIntroItemResponseFromJson(json);
}
