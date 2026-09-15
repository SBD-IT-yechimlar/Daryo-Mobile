
import 'package:daryo/data/datasource/network/dto_daryo/daryo_fm/daryo_fm_response.dart';

class DaryoFm {
  final int id;
  final String title;
  final String audioPath;
  final int views;
  final bool status;
  final int sortOrder;
  final String createdAt;
  bool isPlaying;


  DaryoFm({
    required this.id,
    required this.title,
    required this.audioPath,
    required this.views,
    required this.status,
    required this.sortOrder,
    required this.createdAt,
    required this.isPlaying,
  });

  // Copy method
  DaryoFm copyWith({
    int? id,
    String? title,
    String? audioPath,
    int? views,
    bool? status,
    int? sortOrder,
    String? createdAt,
    bool? isPlaying,
  }) {
    return DaryoFm(
      id: id ?? this.id,
      title: title ?? this.title,
      audioPath: audioPath ?? this.audioPath,
      views: views ?? this.views,
      status: status ?? this.status,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
        isPlaying: isPlaying??this.isPlaying
    );
  }

  // toMap method
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'audio': audioPath,
      'views': views,
      'status': status,
      'sort_order': sortOrder,
      'created_at': createdAt,
    };
  }

  // fromMap method
  factory DaryoFm.fromMap(Map<String, dynamic> map) {
    return DaryoFm(
      id: map['id'],
      title: map['title'],
      audioPath: map['audio'],
      views: map['views'],
      status: map['status'],
      sortOrder: map['sort_order'],
      createdAt: map['created_at'],
      isPlaying: map['is_playing'],
    );
  }
}

extension NewsItemExtension on DaryoFmItemResponse {
  DaryoFm toDaryoFm() {
    return DaryoFm(
      id: id,
      title: title??"",
      audioPath: audio??"",
      views: views??0,
      status: status??false,
      sortOrder: sortOrder??0,
      createdAt: createdAt??"",
      isPlaying: false,
    );
  }
}