import '../../../data/datasource/network/dto_daryo/tariff/tariffs_response.dart';

class Tariff {
  final int id;
  final String title;
  final String description;
  final int type;
  final String postGrainy;
  final int amountUzs;
  final int amountUsd;
  final String discount;
  final int countDate;
  final int sortOrder;
  final String status;
  final String createdBy;
  final String updatedBy;
  final String createdAt;
  final String updatedAt;

  const Tariff({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.type = 0,
    this.postGrainy = '',
    this.amountUzs = 0,
    this.amountUsd = 0,
    this.discount = '',
    this.countDate = 0,
    this.sortOrder = 0,
    this.status = '',
    this.createdBy = '',
    this.updatedBy = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  // Copy method
  Tariff copyWith({
    int? id,
    String? title,
    String? description,
    int? type,
    String? postGrainy,
    int? amountUzs,
    int? amountUsd,
    String? discount,
    int? countDate,
    int? sortOrder,
    String? status,
    String? createdBy,
    String? updatedBy,
    String? createdAt,
    String? updatedAt,
  }) {
    return Tariff(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      postGrainy: postGrainy ?? this.postGrainy,
      amountUzs: amountUzs ?? this.amountUzs,
      amountUsd: amountUsd ?? this.amountUsd,
      discount: discount ?? this.discount,
      countDate: countDate ?? this.countDate,
      sortOrder: sortOrder ?? this.sortOrder,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'post_grainy': postGrainy,
      'amount_uzs': amountUzs,
      'amount_usd': amountUsd,
      'discount': discount,
      'count_date': countDate,
      'sort_order': sortOrder,
      'status': status,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Create from Map
  factory Tariff.fromMap(Map<String, dynamic> map) {
    return Tariff(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      type: map['type'] ?? 0,
      postGrainy: map['post_grainy']?.toString() ?? '',
      amountUzs: map['amount_uzs'] ?? 0,
      amountUsd: map['amount_usd'] ?? 0,
      discount: map['discount']?.toString() ?? '',
      countDate: map['count_date'] ?? 0,
      sortOrder: map['sort_order'] ?? 0,
      status: map['status']?.toString() ?? '',
      createdBy: map['created_by']?.toString() ?? '',
      updatedBy: map['updated_by']?.toString() ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }
}

// Extension to convert DTO → domain model
extension TariffResponseX on TariffResponse {
  Tariff toTariff() {
    return Tariff(
      id: id ?? 0,
      title: title ?? '',
      description: description ?? '',
      type: type ?? 0,
      postGrainy: postGrainy?.toString() ?? '',
      amountUzs: amountUzs ?? 0,
      amountUsd: amountUsd ?? 0,
      discount: discount?.toString() ?? '',
      countDate: countDate ?? 0,
      sortOrder: sortOrder ?? 0,
      status: status?.toString() ?? '',
      createdBy: createdBy?.toString() ?? '',
      updatedBy: updatedBy?.toString() ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
    );
  }
}
