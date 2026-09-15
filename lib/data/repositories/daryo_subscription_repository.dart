import 'package:daryo/data/datasource/network/dto_daryo/face_behind/face_behind_response.dart';
import 'package:daryo/data/datasource/network/dto_daryo/tariff/tariffs_response.dart';
import 'package:daryo/domain/models_daryo/face_behind/face_behind.dart';
import 'package:daryo/domain/models_daryo/specialist/specialist.dart';

import '../../domain/models_daryo/tariff/tariff.dart';
import '../datasource/network/dto_daryo/specialists/specialists_response.dart';
import '../datasource/network/services/public/daryo_information_service.dart';
import '../datasource/network/services/public/daryo_subscription_service.dart';

class DaryoSubscriptionRepository {
  final DaryoSubscriptionService _daryoSubscriptionService;

  DaryoSubscriptionRepository(this._daryoSubscriptionService);

  Future<List<Tariff>> getTariffs() async {
    final response = await _daryoSubscriptionService.getTariffs();
    final listResponse =
        List.from(response.data).map((e) => TariffResponse.fromJson(e));
    return listResponse.map((e) => e.toTariff()).toList();
  }
}
