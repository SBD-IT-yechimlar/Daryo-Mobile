
import '../../../data/datasource/network/dto_daryo/category/categories_response.dart';

class Category {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String fullTitle;
  final String metaDesc;
  final String metaKeywords;
  final String metaTitle;
  final String newsUrl;
  final int parentId;
  final String slug;
  final int sortOrder;
  final bool status;
  final String title;
  final List<Category> children;

  const Category({
    this.id = 0,
    this.createdAt = '',
    this.updatedAt = '',
    this.fullTitle = '',
    this.metaDesc = '',
    this.metaKeywords = '',
    this.metaTitle = '',
    this.newsUrl = '',
    this.parentId = 0,
    this.slug = '',
    this.sortOrder = 0,
    this.status = false,
    this.title = '',
    this.children = const [],
  });

  // Copy method
  Category copyWith({
    int? id,
    String? createdAt,
    String? updatedAt,
    String? fullTitle,
    String? metaDesc,
    String? metaKeywords,
    String? metaTitle,
    String? newsUrl,
    int? parentId,
    String? slug,
    int? sortOrder,
    bool? status,
    String? title,
    List<Category>? children,
  }) {
    return Category(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      fullTitle: fullTitle ?? this.fullTitle,
      metaDesc: metaDesc ?? this.metaDesc,
      metaKeywords: metaKeywords ?? this.metaKeywords,
      metaTitle: metaTitle ?? this.metaTitle,
      newsUrl: newsUrl ?? this.newsUrl,
      parentId: parentId ?? this.parentId,
      slug: slug ?? this.slug,
      sortOrder: sortOrder ?? this.sortOrder,
      status: status ?? this.status,
      title: title ?? this.title,
      children: children ?? this.children,
    );
  }

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'full_title': fullTitle,
      'meta_desc': metaDesc,
      'meta_keywords': metaKeywords,
      'meta_title': metaTitle,
      'news_url': newsUrl,
      'parent_id': parentId,
      'slug': slug,
      'sort_order': sortOrder,
      'status': status,
      'title': title,
      'children': children.map((e) => e.toMap()).toList(),
    };
  }

  // Create from Map
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] ?? 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      fullTitle: map['full_title'] ?? '',
      metaDesc: map['meta_desc'] ?? '',
      metaKeywords: map['meta_keywords'] ?? '',
      metaTitle: map['meta_title'] ?? '',
      newsUrl: map['news_url'] ?? '',
      parentId: map['parent_id'] ?? 0,
      slug: map['slug'] ?? '',
      sortOrder: map['sort_order'] ?? 0,
      status: map['status'] ?? false,
      title: map['title'] ?? '',
      children: (map['children'] as List<dynamic>?)
          ?.map((e) => Category.fromMap(e))
          .toList() ??
          [],
    );
  }
}

// Extension: convert DTO → domain model
extension CategoryResponseX on CategoryResponse {
  Category toCategory() {
    return Category(
      id: id ?? 0,
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
      fullTitle: fullTitle ?? '',
      metaDesc: metaDesc ?? '',
      metaKeywords: metaKeywords ?? '',
      metaTitle: metaTitle ?? '',
      newsUrl: newsUrl ?? '',
      parentId: parentId ?? 0,
      slug: slug ?? '',
      sortOrder: sortOrder ?? 0,
      status: status ?? false,
      title: title ?? '',
      children: children?.map((e) => e.toCategory()).toList() ?? [],
    );
  }
}

// Extension: convert list of DTOs → list of domain models
extension CategoriesResponseX on CategoriesResponse {
  List<Category> toCategories() {
    return data?.map((e) => e.toCategory()).toList() ?? [];
  }
}
