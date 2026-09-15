import 'package:daryo/data/datasource/network/dto_daryo/category/categories_response.dart';
import 'package:daryo/data/datasource/network/dto_daryo/content_detail/content_detail_response.dart';
import 'package:daryo/data/datasource/network/dto_daryo/shorts/shorts_response.dart';
import 'package:daryo/data/datasource/network/dto_daryo/slider/sliders_response.dart';
import 'package:daryo/data/datasource/network/dto_daryo/tags/tags_response.dart';
import 'package:daryo/data/datasource/network/dto_daryo/videos/videos_response.dart';
import 'package:daryo/data/datasource/network/services/public/category_service.dart';
import 'package:daryo/domain/models_daryo/content_detail/content_detail.dart';
import 'package:daryo/domain/models_daryo/recommendation/recommendation.dart';
import 'package:daryo/domain/models_daryo/video/video.dart';

import '../../domain/models_daryo/category/category.dart';
import '../../domain/models_daryo/shorts/shorts.dart';
import '../../domain/models_daryo/slider/slider.dart';
import '../../domain/models_daryo/tags/tag.dart';
import '../datasource/network/dto_daryo/recomendation/recommendation_response.dart';
import '../datasource/network/services/public/daryo_dashboard_service.dart';

class CategoryRepository {
  final CategoryService _categoryService;

  CategoryRepository(this._categoryService);

  Future<List<Common>> getRecommendations({required int limit, required int page, required String slug}) async {
    final response = await _categoryService.getNewsBySlug(limit: limit, page: page, slug: slug);
    final listResponse = CommonResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toCommon()).toList();
  }
}
