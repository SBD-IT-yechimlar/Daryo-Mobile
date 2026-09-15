import 'package:freezed_annotation/freezed_annotation.dart';

part 'specialists_response.freezed.dart';
part 'specialists_response.g.dart';

@freezed
abstract class SpecialistsResponse with _$SpecialistsResponse {
  const factory SpecialistsResponse({
    @JsonKey(name: 'data') List<SpecialistItemResponse>? data,
    @JsonKey(name: 'total') int? total,
  }) = _SpecialistsResponse;

  factory SpecialistsResponse.fromJson(Map<String, Object?> json) => _$SpecialistsResponseFromJson(json);
}

@freezed
abstract class SpecialistItemResponse with _$SpecialistItemResponse {
  const factory SpecialistItemResponse({
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'facebook') String? facebook,
    @JsonKey(name: 'fio') String? fio,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'information') String? information,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'ok') String? ok,
    @JsonKey(name: 'patronymic') String? patronymic,
    @JsonKey(name: 'photo') String? photo,
    @JsonKey(name: 'position') String? position,
    @JsonKey(name: 'specialist_id') int? specialistId,
    @JsonKey(name: 'speciality') String? speciality,
    @JsonKey(name: 'status') bool? status,
    @JsonKey(name: 'telegram') String? telegram,
    @JsonKey(name: 'twitter') String? twitter,
    @JsonKey(name: 'username') String? username,
  }) = _SpecialistItemResponse;

  factory SpecialistItemResponse.fromJson(Map<String, Object?> json) => _$SpecialistItemResponseFromJson(json);
}

