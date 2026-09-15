import '../../../data/datasource/network/dto_daryo/slider/sliders_response.dart';

class SliderModel {
  final int id;
  final String title;
  final String content;
  final String img;
  final String newsId;
  final String category;
  final String categorySlug;
  final String url;
  final String slug;
  final String date;
  final String status;

  const SliderModel({
    this.id = 0,
    this.title = '',
    this.content = '',
    this.img = '',
    this.newsId = '',
    this.category = '',
    this.categorySlug = '',
    this.url = '',
    this.slug = '',
    this.date = '',
    this.status = '',
  });

  // Copy method
  SliderModel copyWith({
    int? id,
    String? title,
    String? content,
    String? img,
    String? newsId,
    String? category,
    String? categorySlug,
    String? url,
    String? slug,
    String? date,
    String? status,
  }) {
    return SliderModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      img: img ?? this.img,
      newsId: newsId ?? this.newsId,
      category: category ?? this.category,
      categorySlug: categorySlug ?? this.categorySlug,
      url: url ?? this.url,
      slug: slug ?? this.slug,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'img': img,
      'news_id': newsId,
      'category': category,
      'category_slug': categorySlug,
      'url': url,
      'slug': slug,
      'date': date,
      'status': status,
    };
  }

  // Create from Map
  factory SliderModel.fromMap(Map<String, dynamic> map) {
    return SliderModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      img: map['img'] ?? '',
      newsId: map['news_id'] ?? '',
      category: map['category'] ?? '',
      categorySlug: map['category_slug'] ?? '',
      url: map['url'] ?? '',
      slug: map['slug'] ?? '',
      date: map['date'] ?? '',
      status: map['status'] ?? '',
    );
  }
}

// Extension to convert DTO → domain model
extension SliderItemResponseX on SliderItemResponse {
  SliderModel toSlider() {
    return SliderModel(
      id: id ?? 0,
      title: title ?? '',
      content: content ?? '',
      img: img ?? '',
      newsId: newsId ?? '',
      category: category ?? '',
      categorySlug: categorySlug ?? '',
      url: url ?? '',
      slug: slug ?? '',
      date: date ?? '',
      status: status ?? '',
    );
  }
}
