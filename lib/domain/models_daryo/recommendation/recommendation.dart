
import '../../../data/datasource/network/dto_daryo/recomendation/recommendation_response.dart';

class Common {
  final int id;
  final String title;
  final String content;
  final String shortContent;
  final String category;
  final String categorySlug;
  final String type;
  final String newsId;
  final String url;
  final String img;
  final int views;
  final int authorId;
  final String authorName;
  final String authorFio;
  final String authorPhoto;
  final bool hasOz;
  final bool hasUz;
  final bool hasEn;
  final bool hasRu;
  final bool hasImages;
  final bool hasVideo;
  final bool hasAudio;
  final String author;
  final String uLink;
  final String categoryIds;
  final int isLock;
  final bool isImportant;
  final int publishedBy;
  final String slug;
  final String date;
  final String status;
  final String createdAt;

  Common({
    this.id = 0,
    this.title = '',
    this.content = '',
    this.shortContent = '',
    this.category = '',
    this.categorySlug = '',
    this.type = '',
    this.newsId = '',
    this.url = '',
    this.img = '',
    this.views = 0,
    this.authorId = 0,
    this.authorName = '',
    this.authorFio = '',
    this.authorPhoto = '',
    this.hasOz = false,
    this.hasUz = false,
    this.hasEn = false,
    this.hasRu = false,
    this.hasImages = false,
    this.hasVideo = false,
    this.hasAudio = false,
    this.author = '',
    this.uLink = '',
    this.categoryIds = '',
    this.isLock = 0,
    this.isImportant = false,
    this.publishedBy = 0,
    this.slug = '',
    this.date = '',
    this.status = '',
    this.createdAt = '',
  });

  // Copy method
  Common copyWith({
    int? id,
    String? title,
    String? content,
    String? shortContent,
    String? category,
    String? categorySlug,
    String? type,
    String? newsId,
    String? url,
    String? img,
    int? views,
    int? authorId,
    String? authorName,
    String? authorFio,
    String? authorPhoto,
    bool? hasOz,
    bool? hasUz,
    bool? hasEn,
    bool? hasRu,
    bool? hasImages,
    bool? hasVideo,
    bool? hasAudio,
    String? author,
    String? uLink,
    String? categoryIds,
    int? isLock,
    bool? isImportant,
    int? publishedBy,
    String? slug,
    String? date,
    String? status,
    String? createdAt,
  }) {
    return Common(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      shortContent: shortContent ?? this.shortContent,
      category: category ?? this.category,
      categorySlug: categorySlug ?? this.categorySlug,
      type: type ?? this.type,
      newsId: newsId ?? this.newsId,
      url: url ?? this.url,
      img: img ?? this.img,
      views: views ?? this.views,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorFio: authorFio ?? this.authorFio,
      authorPhoto: authorPhoto ?? this.authorPhoto,
      hasOz: hasOz ?? this.hasOz,
      hasUz: hasUz ?? this.hasUz,
      hasEn: hasEn ?? this.hasEn,
      hasRu: hasRu ?? this.hasRu,
      hasImages: hasImages ?? this.hasImages,
      hasVideo: hasVideo ?? this.hasVideo,
      hasAudio: hasAudio ?? this.hasAudio,
      author: author ?? this.author,
      uLink: uLink ?? this.uLink,
      categoryIds: categoryIds ?? this.categoryIds,
      isLock: isLock ?? this.isLock,
      isImportant: isImportant ?? this.isImportant,
      publishedBy: publishedBy ?? this.publishedBy,
      slug: slug ?? this.slug,
      date: date ?? this.date,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // toMap method
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'short_content': shortContent,
      'category': category,
      'category_slug': categorySlug,
      'type': type,
      'news_id': newsId,
      'url': url,
      'img': img,
      'views': views,
      'author_id': authorId,
      'author_name': authorName,
      'author_fio': authorFio,
      'author_photo': authorPhoto,
      'has_oz': hasOz,
      'has_uz': hasUz,
      'has_en': hasEn,
      'has_ru': hasRu,
      'has_images': hasImages,
      'has_video': hasVideo,
      'has_audio': hasAudio,
      'author': author,
      'u_link': uLink,
      'category_ids': categoryIds,
      'is_lock': isLock,
      'is_important': isImportant,
      'published_by': publishedBy,
      'slug': slug,
      'date': date,
      'status': status,
      'created_at': createdAt,
    };
  }

  // fromMap method
  factory Common.fromMap(Map<String, dynamic> map) {
    return Common(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      shortContent: map['short_content'] ?? '',
      category: map['category'] ?? '',
      categorySlug: map['category_slug'] ?? '',
      type: map['type'] ?? '',
      newsId: map['news_id'] ?? '',
      url: map['url'] ?? '',
      img: map['img'] ?? '',
      views: map['views'] ?? 0,
      authorId: map['author_id'] ?? 0,
      authorName: map['author_name'] ?? '',
      authorFio: map['author_fio'] ?? '',
      authorPhoto: map['author_photo'] ?? '',
      hasOz: map['has_oz'] ?? false,
      hasUz: map['has_uz'] ?? false,
      hasEn: map['has_en'] ?? false,
      hasRu: map['has_ru'] ?? false,
      hasImages: map['has_images'] ?? false,
      hasVideo: map['has_video'] ?? false,
      hasAudio: map['has_audio'] ?? false,
      author: map['author'] ?? '',
      uLink: map['u_link'] ?? '',
      categoryIds: (map['category_ids'] ?? '').toString(),
      isLock: map['is_lock'] ?? 0,
      isImportant: map['is_important'] ?? false,
      publishedBy: map['published_by'] ?? 0,
      slug: map['slug'] ?? '',
      date: map['date'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }
}

// Extension to convert from API response to domain model
extension CommonItemResponseX on CommonItemResponse {
  Common toCommon() {
    return Common(
      id: id ?? 0,
      title: title ?? '',
      content: content ?? '',
      shortContent: shortContent ?? '',
      category: category ?? '',
      categorySlug: categorySlug ?? '',
      type: type ?? '',
      newsId: newsId ?? '',
      url: url ?? '',
      img: img ?? '',
      views: views ?? 0,
      authorId: authorId ?? 0,
      authorName: authorName ?? '',
      authorFio: authorFio ?? '',
      authorPhoto: authorPhoto ?? '',
      hasOz: hasOz ?? false,
      hasUz: hasUz ?? false,
      hasEn: hasEn ?? false,
      hasRu: hasRu ?? false,
      hasImages: hasImages ?? false,
      hasVideo: hasVideo ?? false,
      hasAudio: hasAudio ?? false,
      author: author ?? '',
      uLink: uLink ?? '',
      categoryIds: categoryIds?.toString() ?? '',
      isLock: isLock ?? 0,
      isImportant: isImportant ?? false,
      publishedBy: publishedBy ?? 0,
      slug: slug ?? '',
      date: date ?? '',
      status: status ?? '',
      createdAt: createdAt ?? '',
    );
  }
}
