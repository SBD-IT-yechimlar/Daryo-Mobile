import '../../domain/models_daryo/recommendation/reccommendation.dart';
import '../../domain/models_daryo/recommendation/recommendation.dart';
import '../datasource/network/dto_daryo/recomendation/recommendation_response.dart';
import '../datasource/network/dto_daryo/recommendation/recommendation_response.dart';
import '../datasource/network/services/public/recommendation_service.dart';


class RecommendationRepository {
  final RecommendationService _recommendationService;

  RecommendationRepository(this._recommendationService);


  Future<List<RecommendationModel>> getRecommendations({required int page, required int limit}) async {
    final response = await _recommendationService.getRecommendations(page: page, limit: limit);
    final listResponse = RecommendationResponse.fromJson(response.data).data??[];
    return listResponse.map((e)=>e.toRecommendationModel()).toList();
  }

  Future<List<Common>> getLastNews({required int page, required int limit}) async {
    final response = await _recommendationService.getLastNews(page: page, limit: limit);
    final listResponse = CommonResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toCommon()).toList();

  }

}
