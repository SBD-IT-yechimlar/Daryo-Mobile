part of 'splash_cubit.dart';

@freezed
class SplashState with _$SplashState {
  const SplashState._();

  const factory SplashState({
    @Default(false) bool loading,
    @Default(2) int timerTime,
  }) = _SplashState;
}

@freezed
class SplashEvent with _$SplashEvent {
  const factory SplashEvent(SplashEventType type, {String? message}) =
      _SplashEvent;
}

enum SplashEventType {
  navigateSetLanguage,
  onOpenHome,
}
