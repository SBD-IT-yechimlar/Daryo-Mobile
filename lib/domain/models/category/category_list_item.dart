import 'package:daryo/domain/models/category/category_type.dart';

class CategoryListItem {
  int id;
  String name;
  int? parentId;
  String? keyWord;
  int? adCount;
  String? icon;
  bool isOpened;
  bool isSelected;
  bool isVisible;
  int? selectedChildCount;
  int? totalChildCount;
  CategoryType type;

  CategoryListItem({
    required this.id,
    required this.name,
    required this.parentId,
    required this.keyWord,
    required this.adCount,
    required this.icon,
    required this.type,
    required this.totalChildCount,
    required this.selectedChildCount,
    this.isOpened = false,
    this.isSelected = false,
    this.isVisible = false,
  });

  bool get isParent => parentId == null || parentId! <= 0;

  bool get isNotParent => parentId != null && parentId! > 0;

  bool get hasParent => parentId == null || parentId! <= 0;

  bool get hasChildren => true;

  bool get hasAdCount => adCount != null && adCount! > 0;

  bool get hasIcon => icon != null;
}
