import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner_response.freezed.dart';
part 'banner_response.g.dart';

@freezed
class BannerRootResponse with _$BannerRootResponse {
  const factory BannerRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required List<BannerResponse> data,
    dynamic response,
  }) = _BannerRootResponse;

  factory BannerRootResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerRootResponseFromJson(json);
}

@freezed
class BannerResponse with _$BannerResponse {
  const factory BannerResponse({
    required int id,
    @JsonKey(name: 'action_type') String? actionType,
    @JsonKey(name: 'action_data') String? actionData,
    @JsonKey(name: 'action_title') String? actionTitle,
    String? image,
  }) = _BannerResponse;

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);
}
