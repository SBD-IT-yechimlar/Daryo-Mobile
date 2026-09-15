import 'package:dio/dio.dart';

class VersionService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://data.daryo.uz/api/v1/', // <-- bu yerda o'zingning API bazasini yoz
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  Future<VersionInfo?> getAppVersion() async {
    try {
      final response = await _dio.get('mobile/device/version'); // endpointni o'zgartir
      if (response.statusCode == 200) {
        final data = response.data['data'];
        return VersionInfo.fromJson(data);
      }
    } catch (e) {
      print('Version olishda xatolik: $e');
    }
    return null;
  }
}

class VersionInfo {
  final int id;
  final String minVersion;
  final String currentVersion;
  final DateTime createdAt;
  final DateTime updatedAt;

  VersionInfo({
    required this.id,
    required this.minVersion,
    required this.currentVersion,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VersionInfo.fromJson(Map<String, dynamic> json) {
    return VersionInfo(
      id: json['id'],
      minVersion: json['min_version'],
      currentVersion: json['current_version'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
