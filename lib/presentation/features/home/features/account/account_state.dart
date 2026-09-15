part of 'account_cubit.dart';

@freezed
class AccountState with _$AccountState {
  const factory AccountState({
    @Default(true) bool isLoading,
    @Default(false) bool isTheme,
    @Default(true) bool isNotification,
    @Default(LoadingState.loading) LoadingState loadingState,
    @Default("") String merchantToken,

    @Default("") String fullName,
    @Default("") String email,
    XFile? avatar,
    AppThemeMode? appThemeMode,
  }) = _AccountState;
}

@freezed
class AccountEvent with _$AccountEvent {
  const factory AccountEvent() = _AccountEvent;
}
