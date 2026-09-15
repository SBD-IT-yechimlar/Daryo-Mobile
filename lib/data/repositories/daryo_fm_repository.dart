
import 'package:daryo/domain/models_daryo/daryo_fm/darto_fm_item.dart';

import '../datasource/network/dto_daryo/daryo_fm/daryo_fm_response.dart';
import '../datasource/network/services/public/daryo_fm_service.dart';

class DaryoFmRepository {
  final DaryoFmService _daryoFmService;

  DaryoFmRepository(this._daryoFmService);


  Future<List<DaryoFm>> getRadioFmList({required int page, required int limit}) async {
    final response = await _daryoFmService.getRadioFmList(page: page, limit: limit);
    final listResponse = DaryoFmResponse.fromJson(response.data).data??[];
    return listResponse.map((e)=>e.toDaryoFm()).toList();
  }

  Future<List<DaryoFm>> getFirstFm() async {
    final response = await _daryoFmService.getRadioFmList(page: 0, limit: 2);
    final listResponse = DaryoFmResponse.fromJson(response.data).data??[];
    return listResponse.map((e)=>e.toDaryoFm()).toList();
  }



}
