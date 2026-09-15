import '../../domain/models_daryo/recommendation/recommendation.dart';
import '../datasource/network/dto_daryo/recomendation/recommendation_response.dart';
import '../datasource/network/services/public/common_service.dart';

class CommonRepository {
  final CommonService _commonService;

  CommonRepository(
    this._commonService,
  );

  Future<List<Common>> getSearchHashTag({required int page, required int limit, required String tag}) async {
    final response = await _commonService.getSearchHashTag(page: page, limit: limit, tag: tag);
    final listResponse = CommonResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toCommon()).toList();
  }

  Future<List<Common>> getSearchNews({required int page, required int limit, required String query}) async {
    final response = await _commonService.getSearchNews(page: page, limit: limit, query: query);
    final listResponse = CommonResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toCommon()).toList();
  }
}
