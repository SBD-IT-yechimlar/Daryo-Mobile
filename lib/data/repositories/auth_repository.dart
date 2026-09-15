import 'dart:async';

import 'package:daryo/data/datasource/floor/dao/ad_entity_dao.dart';
import 'package:daryo/data/datasource/floor/dao/user_address_entity_dao.dart';
import 'package:daryo/data/datasource/floor/dao/user_entity_dao.dart';
import 'package:daryo/data/datasource/network/dto/auth/login/login_response.dart';
import 'package:daryo/data/datasource/network/dto/auth/register/register_response.dart';
import 'package:daryo/data/datasource/network/services/private/auth_service.dart';
import 'package:daryo/data/datasource/preference/auth_preferences.dart';
import 'package:daryo/data/datasource/preference/notification_count_preferences.dart';
import 'package:daryo/data/datasource/preference/user_preferences.dart';
import 'package:logger/logger.dart';

import '../datasource/network/dto_daryo/banners/banners_response.dart';

class AuthRepository {
  final AdEntityDao _adEntityDao;
  final AuthPreferences _authPreferences;
  final AuthService _authService;
  final NotificationCountPreferences _notificationCountPreferences;
  final UserAddressEntityDao _userAddressEntityDao;
  final UserEntityDao _userEntityDao;
  final UserPreferences _userPreferences;

  AuthRepository(
    this._adEntityDao,
    this._authPreferences,
    this._authService,
    this._notificationCountPreferences,
    this._userAddressEntityDao,
    this._userEntityDao,
    this._userPreferences,
  );

  Future<void> login(String email, String password) async {
    final response = await _authService.login(email: email, password: password);
    final loginResponse = LoginRootDataRes.fromJson(response.data).data;
    if (loginResponse != null) {
      await _authPreferences.setToken(loginResponse.token ?? "");
      await _authPreferences.setIsAuthorized(true);
      await _userPreferences.setUserInfo(loginResponse.user);
    }
    return;
  }

  Future<void> loginWithGoogle(String token) async {
    final response = await _authService.loginWithGoogle(token: token);
    final loginResponse = LoginRootRes.fromJson(response.data);
    if (loginResponse != null) {
      Logger().w("ancajdcnsdcn ${loginResponse.user?.email}");
      Logger().w("ancajdcnsdcn22 ${loginResponse.user?.username}");
      await _authPreferences.setToken(loginResponse.token ?? "");
      await _authPreferences.setIsAuthorized(true);
      await _userPreferences.setUserInfo(loginResponse.user);
    }
    return;
  }

  Future<void> setFCMToken(String token) async {
    final response = await _authService.setFCMToken(token: token);
  }

  Future<void> registration(String email, String password, String phone, String username) async {
    final response = await _authService.registration(email: email, password: password, phone: phone, username: username);
    final registerResponse = RegisterResponse.fromJson(response.data);
    await _authPreferences.setToken(registerResponse.token);
    await _authPreferences.setIsAuthorized(true);
    await _userPreferences.setUserRegisterInfo(registerResponse.user);
      return;
  }


  Future<void> logOut() async {
    await _adEntityDao.clear();
    await _authPreferences.clear();
    await _notificationCountPreferences.clear();
    await _userAddressEntityDao.clear();
    await _userEntityDao.clear();
    await _userPreferences.clear();
    return;
  }


  /// banners

  Future<Map<String, DaryoIntroItemResponse>> banners() async {
    final response = await _authService.banners();
    final banners = DaryoIntroResponse.fromJson(response.data);
    return banners.data;
  }
}
