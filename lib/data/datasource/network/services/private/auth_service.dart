import 'dart:async';
import 'package:daryo/data/datasource/network/constants/constants.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:daryo/data/datasource/network/constants/rest_query_keys.dart';
import 'package:logger/logger.dart';


class AuthService {
  final Dio _dio;
  final firebaseAuth = FirebaseAuth.instance;

  AuthService(this._dio);

  /// Normal login (email/password)
  Future<Response> login({
    required String email,
    required String password,
  }) {
    final body = {
      RestQueryKeys.email: email,
      RestQueryKeys.password: password,
    };
    return _dio.post('auth', data: body);
  }

  Future<Response> setFCMToken({
    required String token,
  }) {
    final body = {
      "token": token,
      "os": "mobile",
      "version": Constants.appVersionCode,
    };
    return _dio.post('site/push/save-token', data: body);
  }


  Future<Response> loginWithGoogle({required String token}) {
    final body = {
      "id_token": token,
    };
    return _dio.post('mobile/google/login', data: body);
  }


  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status != LoginStatus.success) return null;

    final OAuthCredential credential =
        FacebookAuthProvider.credential(result.accessToken!.token);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await firebaseAuth.signInWithCredential(credential);
    return userCredential;
  }

  /// Logout both from Google and backend if needed
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
    } catch (e) {
      print('Google sign-out error: $e');
    }
    Future<Response> login({required String email, required String password}) {
      final body = {
        RestQueryKeys.email: email,
        RestQueryKeys.password: password
      };
      return _dio.post('auth', data: body);
    }
  }

  Future<Response> registration({required String email, required String password, required String phone, required String username}) {
    final body = {
      RestQueryKeys.email: email,
      RestQueryKeys.password: password,
      RestQueryKeys.phone: phone,
      RestQueryKeys.queryUserName: username
    };
    return _dio.post('register', data: body);
  }

  /// banners
  Future<Response> banners() {
    return _dio.get('mobile/banners?limit=15&offset=15&order=id+asc');

  }
}
