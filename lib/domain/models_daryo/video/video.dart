import '../../../data/datasource/network/dto_daryo/videos/videos_response.dart';

class Video {
  final int id;
  final String title;
  final String shortContent;
  final String image;
  final String video;
  final String uLink;
  final bool status;
  final String date;
  final int sortOrder;
  final String createdAt;

  const Video({
    this.id = 0,
    this.title = '',
    this.shortContent = '',
    this.image = '',
    this.video = '',
    this.uLink = '',
    this.status = false,
    this.date = '',
    this.sortOrder = 0,
    this.createdAt = '',
  });

  // Copy method
  Video copyWith({
    int? id,
    String? title,
    String? shortContent,
    String? image,
    String? video,
    String? uLink,
    bool? status,
    String? date,
    int? sortOrder,
    String? createdAt,
  }) {
    return Video(
      id: id ?? this.id,
      title: title ?? this.title,
      shortContent: shortContent ?? this.shortContent,
      image: image ?? this.image,
      video: video ?? this.video,
      uLink: uLink ?? this.uLink,
      status: status ?? this.status,
      date: date ?? this.date,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'short_content': shortContent,
      'image': image,
      'video': video,
      'u_link': uLink,
      'status': status,
      'date': date,
      'sort_order': sortOrder,
      'created_at': createdAt,
    };
  }

  // Create from Map
  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      shortContent: map['short_content'] ?? '',
      image: map['image'] ?? '',
      video: map['video'] ?? '',
      uLink: map['u_link'] ?? '',
      status: map['status'] ?? false,
      date: map['date'] ?? '',
      sortOrder: map['sort_order'] ?? 0,
      createdAt: map['created_at'] ?? '',
    );
  }
}

// Extension to convert DTO → domain model
extension VideoItemResponseX on VideoItemResponse {
  Video toVideo() {
    return Video(
      id: id ?? 0,
      title: title ?? '',
      shortContent: shortContent ?? '',
      image: image ?? '',
      video: video ?? '',
      uLink: ULink ?? '',
      status: status ?? false,
      date: date ?? '',
      sortOrder: sortOrder ?? 0,
      createdAt: createdAt ?? '',
    );
  }
}
