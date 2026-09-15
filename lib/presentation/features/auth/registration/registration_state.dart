part of 'registration_cubit.dart';

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
//
    @Default("") String docSeries,
    @Default("") String docNumber,
    @Default("") String brithDate,
//
    @Default("") String phoneNumber,
    @Default("") String firstName,
    @Default("") String lastName,
    @Default("") String email,
//
    @Default("") String password,
    @Default("") String confirmPassword,
//
    @Default(false) bool isLoading,
//
    @Default("") String sessionToken,
  }) = _RegistrationState;
}

@freezed
class RegistrationEvent with _$RegistrationEvent {
  const factory RegistrationEvent(RegistrationEventType type, {String? errorMessage}) = _RegistrationEvent;
}

enum RegistrationEventType {
  onOpenImagePage,
  onRegisterFailed,
  lostConnection,
}
