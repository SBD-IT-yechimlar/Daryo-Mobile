part of 'submit_application_cubit.dart';

@freezed
class SubmitApplicationState with _$SubmitApplicationState {
  const factory SubmitApplicationState({
    @Default(false) bool isLoading,
    @Default(false) bool isEnabled,
    @Default(LoadingState.loading) LoadingState loadingState,
    @Default("") String username,
    @Default("") String email,
    @Default("") String phone,
    @Default("") String theme,
    @Default("") String description,
  }) = _SubmitApplicationState;
}

@freezed
class SubmitApplicationEvent with _$SubmitApplicationEvent {
  const factory SubmitApplicationEvent(SubmitApplicationEventType type, {String? errorMessage}) = _SubmitApplicationEvent;
}

enum SubmitApplicationEventType {
  onOpenBack,
  onFailed,
  lostConnection,
}
