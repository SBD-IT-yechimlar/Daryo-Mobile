import 'package:daryo/data/datasource/network/dto/auth/register/register_response.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/data/datasource/network/dto/auth/login/login_response.dart';
import 'package:daryo/data/datasource/preference/preferences_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

// @lazySingleton
class UserPreferences {
  UserPreferences(this._preferences);

  final String _keyUserId= "integer_user_id";
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserName = 'user_name';
  final String _keyUserPinfl = "integer_user_pinfl";
  final String _keyIsUserIdentified = "bool_is_user_identified";
  final String _keyIsUserLikes = "likes";
  final String _photoXFile = "photoXFile";
  final String _fcmToken = "fcm_token";

  final SharedPreferences _preferences;

  @FactoryMethod(preResolve: true)
  static Future<UserPreferences> create() async {
    final prefs = await SharedPreferences.getInstance();
    return UserPreferences(prefs);
  }



  Future<void> saveXFile(XFile file) async {
    await _preferences.setString(_photoXFile, file.path);
  }

  Future<XFile?> getSavedXFile() async {
    final path = _preferences.getString(_photoXFile);
    if (path != null) {
      return XFile(path);
    }
    return null;
  }

  Future<XFile?> deleteSavedXFile() async {
    final path = _preferences.remove(_photoXFile);
    return null;
  }



  String get fcmToken => _preferences.getString(_fcmToken) ?? "";

  Future<void> setFCMToken(String token) async => await _preferences.setString(_fcmToken, token);


  bool get isIdentified => _preferences.getBool(_keyIsUserIdentified) ?? false;

  bool get isNotIdentified => !isIdentified;

  int? get id => _preferences.getInt(_keyUserId);

  Future<void> setUserId(int? id) async => await _preferences.setOrRemove(_keyUserId, id);

  List<String> get userLikes => _preferences.getStringList(_keyIsUserLikes) ?? [];

  Future<void> setUserLikes(List<String> emails) async => await _preferences.setStringList(_keyIsUserLikes, emails);

  Future<void> addUserLike(String email) async {
    final currentLikes = _preferences.getStringList(_keyIsUserLikes) ?? [];
    if (!currentLikes.contains(email)) {
      currentLikes.add(email);
      await _preferences.setStringList(_keyIsUserLikes, currentLikes);
    }
  }
  Future<void> removeUserLike(String email) async {
    final currentEmails = _preferences.getStringList(_keyIsUserLikes) ?? [];
    currentEmails.remove(email);
    await _preferences.setStringList(_keyIsUserLikes, currentEmails);
  }



  // Email - String
  String? get email => _preferences.getString(_keyUserEmail);

  Future<void> setUserEmail(String? email) async =>
      await _preferences.setOrRemove(_keyUserEmail, email);

  // Username - String
  String? get username => _preferences.getString(_keyUserName);

  Future<void> setUsername(String? username) async =>
      await _preferences.setOrRemove(_keyUserName, username);




  int? get pinfl => _preferences.getInt(_keyUserPinfl);


  Future<void> setIdentityState(bool? isIdentified) async =>
      await _preferences.setOrRemove(_keyIsUserIdentified, isIdentified);


  Future<void> setUserPinfl(int? pinfl) async =>
      await _preferences.setOrRemove(_keyUserPinfl, pinfl);

  Future<void> setUserInfo(LoginUserRes? user) async {
    await _preferences.setOrRemove(_keyUserId, user?.id);
    await _preferences.setOrRemove(_keyUserEmail, user?.email);
    await _preferences.setOrRemove(_keyUserName, user?.username);
  }

  Future<void> setUserRegisterInfo(UserRegisterResponse user) async {
    await _preferences.setOrRemove(_keyUserId, user.id);
    await _preferences.setOrRemove(_keyUserEmail, user.email);
    await _preferences.setOrRemove(_keyUserName, user.username);
  }

  Future<void> clear() async {
    await _preferences.remove(_keyUserId);
    await _preferences.remove(_keyUserEmail);
    await _preferences.remove(_keyUserName);
    await deleteSavedXFile();
  }
}
