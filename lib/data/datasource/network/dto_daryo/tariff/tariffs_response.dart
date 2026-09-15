import 'package:freezed_annotation/freezed_annotation.dart';

part 'tariffs_response.freezed.dart';
part 'tariffs_response.g.dart';

@freezed
abstract class TariffResponse with _$TariffResponse {
  const factory TariffResponse({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'type') int? type,
    @JsonKey(name: 'post_grainy') dynamic postGrainy,
    @JsonKey(name: 'amount_uzs') int? amountUzs,
    @JsonKey(name: 'amount_usd') int? amountUsd,
    @JsonKey(name: 'discount') dynamic discount,
    @JsonKey(name: 'count_date') int? countDate,
    @JsonKey(name: 'sort_order') int? sortOrder,
    @JsonKey(name: 'status') dynamic status,
    @JsonKey(name: 'created_by') dynamic createdBy,
    @JsonKey(name: 'updated_by') dynamic updatedBy,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _TariffResponse;

  factory TariffResponse.fromJson(Map<String, Object?> json) => _$TariffResponseFromJson(json);
}

