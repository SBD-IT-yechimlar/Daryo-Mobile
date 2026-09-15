import 'package:daryo/data/datasource/network/dto/account/subscriptions/subscriptions_response.dart';
import 'package:dio/dio.dart';

import '../datasource/floor/dao/user_entity_dao.dart';
import '../datasource/network/dto/account/profile_response/profile_response.dart';
import '../datasource/network/services/public/account_service.dart';
import '../datasource/preference/user_preferences.dart';

class AccountRepository {
  final UserEntityDao _userEntityDao;
  final UserPreferences _userPreferences;
  final AccountService _accountService;

  AccountRepository(this._userEntityDao, this._userPreferences, this._accountService);

  Future<void> getFeedback({required String fio, required String email, required String phone, required String description}) async {
    final response = await _accountService.getFeedback(fio: fio, email: email, phone: phone, description: description);
    return;
  }

  Future<List<SubscriptionsListResponse>> getSubscriptions() async {
    final response = await _accountService.getSubscriptions();
    final listSubscriptions = SubscriptionsResponse.fromJson(response.data).data;
    return listSubscriptions;
  }

  Future<Response> updateUser({String? username, String? phone, String? email, String? password}) async {
    final response = await _accountService.updateUser(username: username, phone: phone, email: email, password: password);
    return response;
  }

  Future<ProfileResponse> getUser() async {
    final response = await _accountService.getUser();
    final profileResponse = ProfileResponse.fromJson(response.data);
    return profileResponse;
  }

  Future<Response> getBought() async {
    final response = await _accountService.getBought();
    return response;
  }
}
