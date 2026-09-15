import 'package:daryo/data/datasource/network/dto_daryo/face_behind/face_behind_response.dart';
import 'package:daryo/domain/models_daryo/face_behind/face_behind.dart';
import 'package:daryo/domain/models_daryo/specialist/specialist.dart';

import '../datasource/network/dto_daryo/specialists/specialists_response.dart';
import '../datasource/network/services/public/daryo_information_service.dart';

class DaryoInformationRepository {
  final DaryoInformationService _daryoInformationService;

  DaryoInformationRepository(this._daryoInformationService);

  Future<List<Specialist>> getSpecialists(
      {required int limit, required int page}) async {
    final response =
        await _daryoInformationService.getSpecialists(limit: limit, page: page);
    final listResponse = SpecialistsResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toSpecialist()).toList();
  }
  Future<List<FaceBehind>> getFaceBehinds(
      {required int limit, required int page}) async {
    final response =
        await _daryoInformationService.getFaceBehinds(limit: limit, page: page);
    final listResponse = FaceBehindResponse.fromJson(response.data).data ?? [];
    return listResponse.map((e) => e.toFaceBehind()).toList();
  }
}
