import 'package:dio/dio.dart';

class AccountService {
  final Dio _dio;

  AccountService(this._dio);

  Future<Response> getFeedback({required String fio, required String email, required String phone, required String description}) async {
    final body = {
      "fio": fio,
      "phone": phone,
      "email": email,
      "text": description,
    };
    return _dio.post("feedback", data: body);
  }

  Future<Response> getSubscriptions() async {
    return _dio.get("cabinet/subscriptions?limit=50&offset=0");
  }

  Future<Response> updateUser({String? username, String? phone, String? email, String? password}) async {
    final body = {
      "username": username,
    //  "phone": phone,
      "email": email,
    //  "password": password,
    };
    return _dio.patch("cabinet/update/user", data: body);
  }

  Future<Response> getUser() async {
    return _dio.get("cabinet/auth/me");
  }

  Future<Response> getBought() async {
    return _dio.get("cabinet/bought?limit=12&offset=0");
  }
}
