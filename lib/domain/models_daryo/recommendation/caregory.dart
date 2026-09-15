class CategoryModel {
  final int id;
   int byCategoryId;
  final String name;
  final String slug;

  CategoryModel({
    required this.id,
    required this.byCategoryId,
    required this.name,
    required this.slug,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? 0,
      byCategoryId: map['byCategoryId'] ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
    };
  }
}
