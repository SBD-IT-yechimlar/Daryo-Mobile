import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_ad_detail_response.freezed.dart';

part 'user_ad_detail_response.g.dart';

@freezed
class UserAdDetailRootResponse with _$UserAdDetailRootResponse {
  const factory UserAdDetailRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required Data data,
    dynamic response,
  }) = _UserAdDetailRootResponse;

  factory UserAdDetailRootResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAdDetailRootResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    @JsonKey(name: "results") required UserAdDetailResponse userAdDetail,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class UserAdDetailResponse with _$UserAdDetailResponse {
  const factory UserAdDetailResponse({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "sale_type") String? saleType,
    @JsonKey(name: "main_type_status") String? mainTypeStatus,
    @JsonKey(name: "category") UserAdDetailResponseCategory? category,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "price") int? price,
    @JsonKey(name: "currency") String? currency,
    @JsonKey(name: "is_contract") bool? isContract,
    @JsonKey(name: "route_type") String? routeType,
    @JsonKey(name: "property_status") String? propertyStatus,
    @JsonKey(name: "has_installment") bool? hasInstallment,
    @JsonKey(name: 'region') UserAdDetailRegionInfoResponse? regionInfo,
    @JsonKey(name: 'district') UserAdDetailDistrictInfoResponse? districtInfo,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "phone_number") String? phoneNumber,
    @JsonKey(name: "is_auto_renew") bool? isAutoRenew,
    @JsonKey(name: "type_status") String? typeStatus,
    @JsonKey(name: "begin_date") String? beginDate,
    @JsonKey(name: "end_date") String? endDate,
    @JsonKey(name: "seller") UserAdDetailResponseSeller? seller,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(name: "other_name") String? otherName,
    @JsonKey(name: "other_category")
    UserAdDetailResponseExchangeCategory? exchangeCategory,
    @JsonKey(name: "other_description") String? otherDescription,
    @JsonKey(name: "other_route_type") dynamic otherRouteType,
    @JsonKey(name: "other_property_status") dynamic otherPropertyStatus,
    @JsonKey(name: "type") String? type,
    @JsonKey(name: "show_social") bool? showSocial,
    @JsonKey(name: "tin") int? tin,
    @JsonKey(name: "has_free_shipping") bool? hasFreeShipping,
    @JsonKey(name: "has_shipping") bool? hasShipping,
    @JsonKey(name: "has_warehouse") bool? hasWarehouse,
    @JsonKey(name: "shipping_price") int? shippingPrice,
    @JsonKey(name: "shipping_unit_id") int? shippingUnitId,
    @JsonKey(name: "view") int? viewCount,
    @JsonKey(name: "selected") int? favoriteCount,
    @JsonKey(name: "phone_view") int? phoneViewCount,
    @JsonKey(name: "message_number") int? smsViewCount,
    @JsonKey(name: "type_expire_date") dynamic typeExpireDate,
    @JsonKey(name: "unit_id") int? unitId,
    @JsonKey(name: "to_price") int? toPrice,
    @JsonKey(name: "from_price") int? fromPrice,
    @JsonKey(name: "address_id") int? addressId,
    @JsonKey(name: "video") String? video,
    @JsonKey(name: "category_id") int? categoryId,
    @JsonKey(name: "installments") UserAdDetailInstallmentInfo? installmentInfo,
    @JsonKey(name: "plan_payments")
    List<UserAdDetailResponsePlanPayments>? planPayments,
    @JsonKey(name: "params") List<dynamic>? params,
    @JsonKey(name: "social_medias") List<dynamic>? socialMedias,
    @JsonKey(name: "warehouses") List<dynamic>? warehouses,
    @JsonKey(name: "shippings") List<dynamic>? shippings,
    @JsonKey(name: "photos") List<UserAdDetailResponsePhoto>? photos,
    @JsonKey(name: "payment_types")
    List<UserAdDetailResponsePaymentType>? paymentTypes,
  }) = _UserAdDetailResponse;

  factory UserAdDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAdDetailResponseFromJson(json);
}

@freezed
class UserAdDetailResponseCategory with _$UserAdDetailResponseCategory {
  const factory UserAdDetailResponseCategory({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "is_sell") bool? isSell,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "key_word") String? keyWord,
  }) = _UserAdDetailResponseCategory;

  factory UserAdDetailResponseCategory.fromJson(Map<String, dynamic> json) =>
      _$UserAdDetailResponseCategoryFromJson(json);
}

@freezed
class UserAdDetailInstallmentInfo with _$UserAdDetailInstallmentInfo {
  const factory UserAdDetailInstallmentInfo({
    @JsonKey(name: "month_id") required int monthCount,
    @JsonKey(name: "monthly_price") required double monthlyPrice,
  }) = _UserAdDetailInstallmentInfo;

  factory UserAdDetailInstallmentInfo.fromJson(Map<String, dynamic> json) =>
      _$UserAdDetailInstallmentInfoFromJson(json);
}

@freezed
class UserAdDetailRegionInfoResponse with _$UserAdDetailRegionInfoResponse {
  const factory UserAdDetailRegionInfoResponse({
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "id") int? id,
  }) = _UserAdDetailRegionInfoResponse;

  factory UserAdDetailRegionInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAdDetailRegionInfoResponseFromJson(json);
}

@freezed
class UserAdDetailDistrictInfoResponse with _$UserAdDetailDistrictInfoResponse {
  const factory UserAdDetailDistrictInfoResponse({
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "id") int? id,
  }) = _UserAdDetailDistrictInfoResponse;

  factory UserAdDetailDistrictInfoResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UserAdDetailDistrictInfoResponseFromJson(json);
}

@freezed
class UserAdDetailResponsePaymentType with _$UserAdDetailResponsePaymentType {
  const factory UserAdDetailResponsePaymentType({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "name") String? name,
  }) = _UserAdDetailResponsePaymentType;

  factory UserAdDetailResponsePaymentType.fromJson(Map<String, dynamic> json) =>
      _$UserAdDetailResponsePaymentTypeFromJson(json);
}

@freezed
class UserAdDetailResponseExchangeCategory
    with _$UserAdDetailResponseExchangeCategory {
  const factory UserAdDetailResponseExchangeCategory({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "name") String? name,
  }) = _UserAdDetailResponseExchangeCategory;

  factory UserAdDetailResponseExchangeCategory.fromJson(
          Map<String, dynamic> json) =>
      _$UserAdDetailResponseExchangeCategoryFromJson(json);
}

@freezed
class UserAdDetailResponsePhoto with _$UserAdDetailResponsePhoto {
  const factory UserAdDetailResponsePhoto({
    @JsonKey(name: "image") required String image,
    @JsonKey(name: "is_main") bool? isMain,
  }) = _UserAdDetailResponsePhoto;

  factory UserAdDetailResponsePhoto.fromJson(Map<String, dynamic> json) =>
      _$UserAdDetailResponsePhotoFromJson(json);
}

@freezed
class UserAdDetailResponseSeller with _$UserAdDetailResponseSeller {
  const factory UserAdDetailResponseSeller({
    @JsonKey(name: "full_name") String? fullName,
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "tin") int? tin,
    @JsonKey(name: "last_login_at") String? lastLoginAt,
    @JsonKey(name: "photo") String? photo,
  }) = _UserAdDetailResponseSeller;

  factory UserAdDetailResponseSeller.fromJson(Map<String, dynamic> json) =>
      _$UserAdDetailResponseSellerFromJson(json);
}

@freezed
class UserAdDetailResponsePlanPayments with _$UserAdDetailResponsePlanPayments {
  const factory UserAdDetailResponsePlanPayments({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "product_id") int? productId,
    @JsonKey(name: "month_id") int? monthId,
    @JsonKey(name: "monthly_price") double? monthlyPrice,
    @JsonKey(name: "starting_price") double? startingPrice,
    @JsonKey(name: "starting_percentage") double? startingPercentage,
    @JsonKey(name: "total_price") double? totalPrice,
    @JsonKey(name: "overtime_price") double? overtimePrice,
    @JsonKey(name: "overtime_percentage") double? overtimePercentage,
  }) = _UserAdDetailResponsePlanPayments;

  factory UserAdDetailResponsePlanPayments.fromJson(
          Map<String, dynamic> json) =>
      _$UserAdDetailResponsePlanPaymentsFromJson(json);
}
