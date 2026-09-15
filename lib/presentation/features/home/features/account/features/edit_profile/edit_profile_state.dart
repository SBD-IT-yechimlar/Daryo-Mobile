part of 'edit_profile_cubit.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState({
    @Default(true) bool isLoading,
    @Default(false) bool isTheme,
    @Default(true) bool isNotification,
    @Default(LoadingState.loading) LoadingState loadingState,
    @Default("") String merchantToken,
    @Default("") String surname,
    @Default("") String name,
    @Default("") String email,
    @Default("") String phone,
    @Default("") String birthday,
    @Default("") String password,
    XFile? avatar
  }) = _EditProfileState;
}

@freezed
class EditProfileEvent with _$EditProfileEvent {
  const factory EditProfileEvent(EditProfileEventType type, {String? errorMessage}) = _EditProfileEvent;
}

enum EditProfileEventType {
  updateProfile,
  failed,
}