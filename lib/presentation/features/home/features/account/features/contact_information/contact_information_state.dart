part of 'contact_information_cubit.dart';

@freezed
class ContactInformationState with _$ContactInformationState {
  const factory ContactInformationState({
    @Default(true) bool isLoading,
    @Default(false) bool isTheme,
    @Default(true) bool isNotification,
    @Default(LoadingState.loading) LoadingState loadingState,
    @Default("") String merchantToken,
  }) = _ContactInformationState;
}

@freezed
class ContactInformationEvent with _$ContactInformationEvent {
  const factory ContactInformationEvent() = _ContactInformationEvent;
}
