import 'package:daryo/data/datasource/network/services/public/favorites_service.dart';

class FavoritesRepository {
  final FavoritesService _favoritesService;

  FavoritesRepository(this._favoritesService);

  /*Future<void> getFeedback({required String fio, required String email, required String phone, required String description}) async {
    final response = await _accountService.getFeedback(fio: fio, email: email, phone: phone, description: description);
    return;
  }

  Future<List<SubscriptionsListResponse>> getSubscriptions() async {
    final response = await _accountService.getSubscriptions();
    final listSubscriptions= SubscriptionsResponse.fromJson(response.data).data;
    return listSubscriptions;
  }*/
}
