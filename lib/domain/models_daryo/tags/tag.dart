import 'package:daryo/data/datasource/network/dto_daryo/tags/tags_response.dart';

class Tag {
  final int id;
  final String title;
  final int sortOrder;
  final bool status;

  Tag({
    this.id = 0,
    this.title = '',
    this.sortOrder = 0,
    this.status = false,
  });

  // Copy method
  Tag copyWith({
    int? id,
    String? title,
    int? sortOrder,
    bool? status,
  }) {
    return Tag(
      id: id ?? this.id,
      title: title ?? this.title,
      sortOrder: sortOrder ?? this.sortOrder,
      status: status ?? this.status,
    );
  }

  // toMap method
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'sort_order': sortOrder,
      'status': status,
    };
  }

  // fromMap method
  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      sortOrder: map['sort_order'] ?? 0,
      status: map['status'] ?? false,
    );
  }
}

// Extension to convert from API response to domain model
extension DataX on Data {
  Tag toTag() {
    return Tag(
      id: id ?? 0,
      title: title ?? '',
      sortOrder: sortOrder ?? 0,
      status: status ?? false,
    );
  }
}

