import 'package:daryo/data/datasource/network/dto_daryo/category/categories_response.dart';
import 'package:daryo/data/datasource/network/dto_daryo/content_detail/content_detail_response.dart';
import 'package:daryo/data/datasource/network/dto_daryo/shorts/shorts_response.dart';
import 'package:daryo/data/datasource/network/dto_daryo/slider/sliders_response.dart';
import 'package:daryo/data/datasource/network/dto_daryo/tags/tags_response.dart';
import 'package:daryo/data/datasource/network/dto_daryo/videos/videos_response.dart';
import 'package:daryo/domain/models_daryo/content_detail/content_detail.dart';
import 'package:daryo/domain/models_daryo/recommendation/recommendation.dart';
import 'package:daryo/domain/models_daryo/video/video.dart';

import '../../domain/models_daryo/category/category.dart';
import '../../domain/models_daryo/shorts/shorts.dart';
import '../../domain/models_daryo/slider/slider.dart';
import '../../domain/models_daryo/tags/tag.dart';
import '../datasource/network/dto_daryo/content_detail/like_dislike_response.dart';
import '../datasource/network/dto_daryo/recomendation/recommendation_response.dart';
import '../datasource/network/services/public/daryo_dashboard_service.dart';

class DaryoDashboardRepository {
  final DaryoDashboardService _daryoDashboardService;

  DaryoDashboardRepository(this._daryoDashboardService);

  Future<List<Common>> getRecommendations({required int limit, required int page}) async {
    final response = await _daryoDashboardService.getRecommendations(limit: limit, page: page);
    final listResponse = CommonResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toCommon()).toList();
  }

  Future<List<Common>> getMenuCategory({required String slug}) async {
    final response = await _daryoDashboardService.getMenuCategory(slug: slug);
    final listResponse = CommonResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toCommon()).toList();
  }

  Future<List<Common>> getDashboardAsiaNews({required int id}) async {
    final response = await _daryoDashboardService.getDashboardAsiaNews(id: id);
    final listResponse = CommonResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toCommon()).toList();
  }

  Future<List<Common>> getHotNews({required int limit, required int page}) async {
    final response = await _daryoDashboardService.getHotNews(limit: limit, page: page);
    final listResponse = CommonResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toCommon()).toList();
  }


  Future<List<Common>> getDunyoNews({required int limit, required int page}) async {
    final response = await _daryoDashboardService.getDunyoNews(limit: limit, page: page);
    final listResponse = CommonResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toCommon()).toList();
  }

  Future<List<Common>> getAutoNews({required int limit, required int page}) async {
    final response = await _daryoDashboardService.getAutoNews(limit: limit, page: page);
    final listResponse = CommonResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toCommon()).toList();
  }

  Future<List<Common>> getLatestNews({required int limit, required int page}) async {
    final response = await _daryoDashboardService.getLatestNews(limit: limit, page: page);
    final listResponse = CommonResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toCommon()).toList();
  }

  Future<List<Tag>> getTags({required int limit, required int page}) async {
    final response =
        await _daryoDashboardService.getTags(limit: limit, page: page);
    final listResponse = TagsResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toTag()).toList();
  }

  Future<List<Short>> getShorts({required int limit, required int page}) async {
    final response = await _daryoDashboardService.getShorts(limit: limit, page: page);
    final listResponse = ShortsResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toShort()).toList();
  }

  Future<List<Video>> getVideos({required int limit, required int page}) async {
    final response = await _daryoDashboardService.getVideos(limit: limit, page: page);
    final listResponse = VideosResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toVideo()).toList();
  }

  Future<List<SliderModel>> getSliders({required int limit, required int page}) async {
    final response = await _daryoDashboardService.getSliders(limit: limit, page: page);
    final listResponse = SlidersResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toSlider()).toList();
  }

  Future<ContentDetail> getContentDetail({required String slug}) async {
    final response = await _daryoDashboardService.getContentDetail(slug: slug);
    final responseModel = ContentDetailResponse.fromJson(response.data);
    return responseModel.toContentDetail();
  }

  Future<List<Common>> getRelatedNewsByTag({required int limit, required int offset, required String tag}) async {
    final response = await _daryoDashboardService.getRelatedNewsByTag(limit: limit, offset: offset, tag: tag);
    final listResponse = CommonResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toCommon()).toList();
  }

  Future<List<Category>> getCategories() async {
    final response = await _daryoDashboardService.getCategories();
    final listResponse = CategoriesResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toCategory()).toList();
  }

  Future<List<Category>> getDashboardCategories() async {
    final response = await _daryoDashboardService.getCategories();
    final listResponse = CategoriesResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toCategory()).toList();
  }

  Future<Map<String, dynamic>> likeDislike(int postId, String action) async {
    final response = await _daryoDashboardService.likeOrDislike(postId, action);
    return response;
  }
  
  
}
