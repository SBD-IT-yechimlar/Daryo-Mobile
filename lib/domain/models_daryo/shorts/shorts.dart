import '../../../data/datasource/network/dto_daryo/shorts/shorts_response.dart';

class Short {
  final int id;
  final String title;
  final String image;
  final String date;
  final String createdAt;
  final String updatedAt;
  final int createdBy;
  final int updatedBy;
  final String link;
  final bool status;

  Short({
    this.id = 0,
    this.title = '',
    this.image = '',
    this.date = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.createdBy = 0,
    this.updatedBy = 0,
    this.link = '',
    this.status = false,
  });

  // Copy method
  Short copyWith({
    int? id,
    String? title,
    String? image,
    String? date,
    String? createdAt,
    String? updatedAt,
    int? createdBy,
    int? updatedBy,
    String? link,
    bool? status,
  }) {
    return Short(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      link: link ?? this.link,
      status: status ?? this.status,
    );
  }

  // toMap method
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'date': date,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'link': link,
      'status': status,
    };
  }

  // fromMap method
  factory Short.fromMap(Map<String, dynamic> map) {
    return Short(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      date: map['date'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      createdBy: map['created_by'] ?? 0,
      updatedBy: map['updated_by'] ?? 0,
      link: map['link'] ?? '',
      status: map['status'] ?? false,
    );
  }
}

// Extension to convert from API response to domain model
extension ShortDataX on ShortsItemResponse {
  Short toShort() {
    return Short(
      id: id ?? 0,
      title: title ?? '',
      image: image ?? '',
      date: date ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
      createdBy: createdBy ?? 0,
      updatedBy: updatedBy ?? 0,
      link: link ?? '',
      status: status ?? false,
    );
  }
}
