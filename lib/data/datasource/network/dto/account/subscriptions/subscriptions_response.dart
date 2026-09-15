// To parse this JSON data, do
//
//     final subscriptionsResponse = subscriptionsResponseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'subscriptions_response.freezed.dart';
part 'subscriptions_response.g.dart';

SubscriptionsResponse subscriptionsResponseFromJson(String str) => SubscriptionsResponse.fromJson(json.decode(str));

String subscriptionsResponseToJson(SubscriptionsResponse data) => json.encode(data.toJson());

@freezed
class SubscriptionsResponse with _$SubscriptionsResponse {
  const factory SubscriptionsResponse({
    required List<SubscriptionsListResponse> data,
  }) = _SubscriptionsResponse;

  factory SubscriptionsResponse.fromJson(Map<String, dynamic> json) => _$SubscriptionsResponseFromJson(json);
}

@freezed
class SubscriptionsListResponse with _$SubscriptionsListResponse {
  const factory SubscriptionsListResponse({
    required int id,
    required String type,
    required String post_grainy,
    required String start_date,
    required String end_date,
    required String count_date,
    required String status,
    required int? bought,
    required String type_name,
    required String count,
    required Order? order,
  }) = _SubscriptionsListResponse;

  factory SubscriptionsListResponse.fromJson(Map<String, dynamic> json) => _$SubscriptionsListResponseFromJson(json);
}

@freezed
class Order with _$Order {
  const factory Order({
    required int id,
    required dynamic user_id,
    required num? amount,
    required int? tariff_id,
    required String? currency,
    required String? payment_type,
    required int? status,
    required String? create_time,
    required dynamic tariff,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
