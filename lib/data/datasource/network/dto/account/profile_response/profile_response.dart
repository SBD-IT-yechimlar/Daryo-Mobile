// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromMap(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_response.freezed.dart';
part 'profile_response.g.dart';

/*ProfileResponse profileResponseFromMap(String str) => ProfileResponse.fromMap(json.decode(str));

String profileResponseToMap(ProfileResponse data) => json.encode(data.toMap());*/

@freezed
class ProfileResponse with _$ProfileResponse {
  const factory ProfileResponse({
    String? email,
    int? id,
    String? phone,
    String? role,
    String? username,
  }) = _ProfileResponse;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => _$ProfileResponseFromJson(json);
}
