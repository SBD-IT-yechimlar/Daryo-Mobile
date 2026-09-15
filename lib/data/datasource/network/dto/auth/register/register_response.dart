import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'register_response.freezed.dart';
part 'register_response.g.dart';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());

@freezed
class RegisterResponse with _$RegisterResponse {
  const factory RegisterResponse({
    required String message,
    required String token,
    required UserRegisterResponse user,
  }) = _RegisterResponse;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);
}

@freezed
class UserRegisterResponse with _$UserRegisterResponse {
  const factory UserRegisterResponse({
    required String email,
    required int id,
    required String phone,
    required String username,
  }) = _UserRegisterResponse;

  factory UserRegisterResponse.fromJson(Map<String, dynamic> json) => _$UserRegisterResponseFromJson(json);
}
