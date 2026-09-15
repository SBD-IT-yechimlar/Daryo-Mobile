import '../../../data/datasource/network/dto_daryo/specialists/specialists_response.dart';

class Specialist {
  final String email;
  final String facebook;
  final String fio;
  final String firstName;
  final int id;
  final String information;
  final String lastName;
  final String ok;
  final String patronymic;
  final String photo;
  final String position;
  final int specialistId;
  final String speciality;
  final bool status;
  final String telegram;
  final String twitter;
  final String username;

  const Specialist({
    this.email = '',
    this.facebook = '',
    this.fio = '',
    this.firstName = '',
    this.id = 0,
    this.information = '',
    this.lastName = '',
    this.ok = '',
    this.patronymic = '',
    this.photo = '',
    this.position = '',
    this.specialistId = 0,
    this.speciality = '',
    this.status = false,
    this.telegram = '',
    this.twitter = '',
    this.username = '',
  });

  // Copy method
  Specialist copyWith({
    String? email,
    String? facebook,
    String? fio,
    String? firstName,
    int? id,
    String? information,
    String? lastName,
    String? ok,
    String? patronymic,
    String? photo,
    String? position,
    int? specialistId,
    String? speciality,
    bool? status,
    String? telegram,
    String? twitter,
    String? username,
  }) {
    return Specialist(
      email: email ?? this.email,
      facebook: facebook ?? this.facebook,
      fio: fio ?? this.fio,
      firstName: firstName ?? this.firstName,
      id: id ?? this.id,
      information: information ?? this.information,
      lastName: lastName ?? this.lastName,
      ok: ok ?? this.ok,
      patronymic: patronymic ?? this.patronymic,
      photo: photo ?? this.photo,
      position: position ?? this.position,
      specialistId: specialistId ?? this.specialistId,
      speciality: speciality ?? this.speciality,
      status: status ?? this.status,
      telegram: telegram ?? this.telegram,
      twitter: twitter ?? this.twitter,
      username: username ?? this.username,
    );
  }

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'facebook': facebook,
      'fio': fio,
      'first_name': firstName,
      'id': id,
      'information': information,
      'last_name': lastName,
      'ok': ok,
      'patronymic': patronymic,
      'photo': photo,
      'position': position,
      'specialist_id': specialistId,
      'speciality': speciality,
      'status': status,
      'telegram': telegram,
      'twitter': twitter,
      'username': username,
    };
  }

  // Create from Map
  factory Specialist.fromMap(Map<String, dynamic> map) {
    return Specialist(
      email: map['email'] ?? '',
      facebook: map['facebook'] ?? '',
      fio: map['fio'] ?? '',
      firstName: map['first_name'] ?? '',
      id: map['id'] ?? 0,
      information: map['information'] ?? '',
      lastName: map['last_name'] ?? '',
      ok: map['ok'] ?? '',
      patronymic: map['patronymic'] ?? '',
      photo: map['photo'] ?? '',
      position: map['position'] ?? '',
      specialistId: map['specialist_id'] ?? 0,
      speciality: map['speciality'] ?? '',
      status: map['status'] ?? false,
      telegram: map['telegram'] ?? '',
      twitter: map['twitter'] ?? '',
      username: map['username'] ?? '',
    );
  }
}

// Extension to convert DTO → domain model
extension SpecialistItemResponseX on SpecialistItemResponse {
  Specialist toSpecialist() {
    return Specialist(
      email: email ?? '',
      facebook: facebook ?? '',
      fio: fio ?? '',
      firstName: firstName ?? '',
      id: id ?? 0,
      information: information ?? '',
      lastName: lastName ?? '',
      ok: ok ?? '',
      patronymic: patronymic ?? '',
      photo: photo ?? '',
      position: position ?? '',
      specialistId: specialistId ?? 0,
      speciality: speciality ?? '',
      status: status ?? false,
      telegram: telegram ?? '',
      twitter: twitter ?? '',
      username: username ?? '',
    );
  }
}
