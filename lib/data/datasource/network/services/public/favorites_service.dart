import 'package:dio/dio.dart';

class FavoritesService {
  final Dio _dio;

  FavoritesService(this._dio);

  /*Future<Response> getFeedback({required String fio, required String email, required String phone, required String description}) async {
    final body = {
      "fio": fio,
      "phone": phone,
      "email": email,
      "text": description,
    };
    return _dio.post("feedback", data: body);
  }

  Future<Response> getSubscriptions() async {
    return _dio.get("cabinet/subscriptions?limit=12&offset=0");
  }*/
}