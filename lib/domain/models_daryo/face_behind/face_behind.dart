import '../../../data/datasource/network/dto_daryo/face_behind/face_behind_response.dart';

class FaceBehind {
  final int id;
  final String image;
  final String video;
  final String link;
  final String fio;
  final String date;
  final int createdBy;
  final int updatedBy;
  final String createdAt;
  final String updatedAt;
  final bool status;

  const FaceBehind({
    this.id = 0,
    this.image = '',
    this.video = '',
    this.link = '',
    this.fio = '',
    this.date = '',
    this.createdBy = 0,
    this.updatedBy = 0,
    this.createdAt = '',
    this.updatedAt = '',
    this.status = false,
  });

  // Copy method
  FaceBehind copyWith({
    int? id,
    String? image,
    String? video,
    String? link,
    String? fio,
    String? date,
    int? createdBy,
    int? updatedBy,
    String? createdAt,
    String? updatedAt,
    bool? status,
  }) {
    return FaceBehind(
      id: id ?? this.id,
      image: image ?? this.image,
      video: video ?? this.video,
      link: link ?? this.link,
      fio: fio ?? this.fio,
      date: date ?? this.date,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
    );
  }

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'video': video,
      'link': link,
      'fio': fio,
      'date': date,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'status': status,
    };
  }

  // Create from Map
  factory FaceBehind.fromMap(Map<String, dynamic> map) {
    return FaceBehind(
      id: map['id'] ?? 0,
      image: map['image'] ?? '',
      video: map['video'] ?? '',
      link: map['link'] ?? '',
      fio: map['fio'] ?? '',
      date: map['date'] ?? '',
      createdBy: map['created_by'] ?? 0,
      updatedBy: map['updated_by'] ?? 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      status: map['status'] ?? false,
    );
  }
}

// Extension to convert DTO → domain model (with default values)
extension FaceBehindItemResponseX on FaceBehindItemResponse {
  FaceBehind toFaceBehind() {
    return FaceBehind(
      id: id ?? 0,
      image: image ?? '',
      video: video ?? '',
      link: link ?? '',
      fio: fio ?? '',
      date: date ?? '',
      createdBy: createdBy ?? 0,
      updatedBy: updatedBy ?? 0,
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
      status: status ?? false,
    );
  }
}
