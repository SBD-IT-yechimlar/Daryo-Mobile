import 'package:freezed_annotation/freezed_annotation.dart';

part 'daryo_fm_response.freezed.dart';
part 'daryo_fm_response.g.dart';

@freezed
class DaryoFmResponse with _$DaryoFmResponse {
  const factory DaryoFmResponse({
    required List<DaryoFmItemResponse>? data,
    required int? total,
  }) = _DaryoFmResponse;

  factory DaryoFmResponse.fromJson(Map<String, dynamic> json) =>
      _$DaryoFmResponseFromJson(json);
}

@freezed
class DaryoFmItemResponse with _$DaryoFmItemResponse {
  const factory DaryoFmItemResponse({
    required int id,
    String?  title,
    String? audio,
    int? views,
    bool?  status,
    @JsonKey(name: 'sort_order')  int?  sortOrder,
    @JsonKey(name: 'created_at')  String? createdAt,
  }) = _DaryoFmItemResponse;

  factory DaryoFmItemResponse.fromJson(Map<String, dynamic> json) =>
      _$DaryoFmItemResponseFromJson(json);
}