part of 'select_language_app_cubit.dart';

@freezed
class SelectLanguageAppState with _$SelectLanguageAppState {
  const factory SelectLanguageAppState({
    @Default(true) bool isLoading,
    @Default(false) bool isTheme,
    @Default(true) bool isNotification,
    @Default(LoadingState.loading) LoadingState loadingState,
    @Default("") String merchantToken,
  }) = _SelectLanguageAppState;
}

@freezed
class SelectLanguageAppEvent with _$SelectLanguageAppEvent {
  const factory SelectLanguageAppEvent() = _SelectLanguageAppEvent;
}
