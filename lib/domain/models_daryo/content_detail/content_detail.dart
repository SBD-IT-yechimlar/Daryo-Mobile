import '../../../data/datasource/network/dto_daryo/content_detail/content_detail_response.dart';

class ContentDetail {
  final String author;
  final String category;
  final String categorySlug;
  final List<dynamic> comments;
  final String content;
  final String date;
  final int dislikesCount;
  final bool expired;
  final String hashtag;
  final int id;
  final List<ImageItem> images;
  final int likesCount;
  final String metaDesc;
  final String metaKeywords;
  final String metaTitle;
  final String newsId;
  final String shortContent;
  final String slug;
  final String status;
  final String title;
  final String type;
  final String url;
  final int views;

  const ContentDetail({
    this.author = '',
    this.category = '',
    this.categorySlug = '',
    this.comments = const [],
    this.content = '',
    this.date = '',
    this.dislikesCount = 0,
    this.expired = false,
    this.hashtag = '',
    this.id = 0,
    this.images = const [],
    this.likesCount = 0,
    this.metaDesc = '',
    this.metaKeywords = '',
    this.metaTitle = '',
    this.newsId = '',
    this.shortContent = '',
    this.slug = '',
    this.status = '',
    this.title = '',
    this.type = '',
    this.url = '',
    this.views = 0,
  });

  // Copy method
  ContentDetail copyWith({
    String? author,
    String? category,
    String? categorySlug,
    List<dynamic>? comments,
    String? content,
    String? date,
    int? dislikesCount,
    bool? expired,
    String? hashtag,
    int? id,
    List<ImageItem>? images,
    int? likesCount,
    String? metaDesc,
    String? metaKeywords,
    String? metaTitle,
    String? newsId,
    String? shortContent,
    String? slug,
    String? status,
    String? title,
    String? type,
    String? url,
    int? views,
  }) {
    return ContentDetail(
      author: author ?? this.author,
      category: category ?? this.category,
      categorySlug: categorySlug ?? this.categorySlug,
      comments: comments ?? this.comments,
      content: content ?? this.content,
      date: date ?? this.date,
      dislikesCount: dislikesCount ?? this.dislikesCount,
      expired: expired ?? this.expired,
      hashtag: hashtag ?? this.hashtag,
      id: id ?? this.id,
      images: images ?? this.images,
      likesCount: likesCount ?? this.likesCount,
      metaDesc: metaDesc ?? this.metaDesc,
      metaKeywords: metaKeywords ?? this.metaKeywords,
      metaTitle: metaTitle ?? this.metaTitle,
      newsId: newsId ?? this.newsId,
      shortContent: shortContent ?? this.shortContent,
      slug: slug ?? this.slug,
      status: status ?? this.status,
      title: title ?? this.title,
      type: type ?? this.type,
      url: url ?? this.url,
      views: views ?? this.views,
    );
  }

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'category': category,
      'category_slug': categorySlug,
      'comments': comments,
      'content': content,
      'date': date,
      'dislikes_count': dislikesCount,
      'expired': expired,
      'hashtag': hashtag,
      'id': id,
      'images': images.map((e) => e.toMap()).toList(),
      'likes_count': likesCount,
      'meta_desc': metaDesc,
      'meta_keywords': metaKeywords,
      'meta_title': metaTitle,
      'news_id': newsId,
      'short_content': shortContent,
      'slug': slug,
      'status': status,
      'title': title,
      'type': type,
      'url': url,
      'views': views,
    };
  }

  // Create from Map
  factory ContentDetail.fromMap(Map<String, dynamic> map) {
    return ContentDetail(
      author: map['author'] ?? '',
      category: map['category'] ?? '',
      categorySlug: map['category_slug'] ?? '',
      comments: List<dynamic>.from(map['comments'] ?? []),
      content: map['content'] ?? '',
      date: map['date'] ?? '',
      dislikesCount: map['dislikes_count'] ?? 0,
      expired: map['expired'] ?? false,
      hashtag: map['hashtag'] ?? '',
      id: map['id'] ?? 0,
      images: (map['images'] as List<dynamic>? ?? [])
          .map((e) => ImageItem.fromMap(e))
          .toList(),
      likesCount: map['likes_count'] ?? 0,
      metaDesc: map['meta_desc'] ?? '',
      metaKeywords: map['meta_keywords'] ?? '',
      metaTitle: map['meta_title'] ?? '',
      newsId: map['news_id'] ?? '',
      shortContent: map['short_content'] ?? '',
      slug: map['slug'] ?? '',
      status: map['status'] ?? '',
      title: map['title'] ?? '',
      type: map['type'] ?? '',
      url: map['url'] ?? '',
      views: map['views'] ?? 0,
    );
  }
}

class ImageItem {
  final int id;
  final String ext;
  final String name;
  final String path;
  final String size;
  final String excerpt;
  final String source;
  final bool isMain;
  final int sortOrder;

  const ImageItem({
    this.id = 0,
    this.ext = '',
    this.name = '',
    this.path = '',
    this.size = '',
    this.excerpt = '',
    this.source = '',
    this.isMain = false,
    this.sortOrder = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ext': ext,
      'name': name,
      'path': path,
      'size': size,
      'excerpt': excerpt,
      'source': source,
      'is_main': isMain,
      'sort_order': sortOrder,
    };
  }

  factory ImageItem.fromMap(Map<String, dynamic> map) {
    return ImageItem(
      id: map['id'] ?? 0,
      ext: map['ext'] ?? '',
      name: map['name'] ?? '',
      path: map['path'] ?? '',
      size: map['size'] ?? '',
      excerpt: map['excerpt'] ?? '',
      source: map['source'] ?? '',
      isMain: map['is_main'] ?? false,
      sortOrder: map['sort_order'] ?? 0,
    );
  }
}

// Extension to convert DTO → domain model
extension ContentDetailResponseX on ContentDetailResponse {
  ContentDetail toContentDetail() {
    return ContentDetail(
      author: author ?? '',
      category: category ?? '',
      categorySlug: categorySlug ?? '',
      comments: comments ?? const [],
      content: content ?? '',
      date: date ?? '',
      dislikesCount: dislikesCount ?? 0,
      expired: expired ?? false,
      hashtag: hashtag ?? '',
      id: id ?? 0,
      images: (images ?? []).map((e) => e.toImageItem()).toList(),
      likesCount: likesCount ?? 0,
      metaDesc: metaDesc ?? '',
      metaKeywords: metaKeywords ?? '',
      metaTitle: metaTitle ?? '',
      newsId: newsId ?? '',
      shortContent: shortContent ?? '',
      slug: slug ?? '',
      status: status ?? '',
      title: title ?? '',
      type: type ?? '',
      url: url ?? '',
      views: views ?? 0,
    );
  }
}

extension ImagesX on Images {
  ImageItem toImageItem() {
    return ImageItem(
      id: id ?? 0,
      ext: ext ?? '',
      name: name ?? '',
      path: path ?? '',
      size: size ?? '',
      excerpt: excerpt ?? '',
      source: source ?? '',
      isMain: isMain ?? false,
      sortOrder: sortOrder ?? 0,
    );
  }
}
