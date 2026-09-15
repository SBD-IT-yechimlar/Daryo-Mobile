part of 'intro_cubit.dart';

@freezed
class IntroState with _$IntroState {
  const factory IntroState(
      {@Default("") String email,
      @Default("") String password,
      @Default("") String phone,
      @Default(false) bool validation,
      @Default(false) bool oriflameCheckBox,
      @Default({}) Map<String, DaryoIntroItemResponse> introData,
      @Default(LoadingState.loading) LoadingState introState,
      @Default(0) int index,
      @Default(4) int length,
      @Default(false) bool loading}) = _IntroState;
}

@freezed
class IntroEvent with _$IntroEvent {
  const factory IntroEvent(IntroEventType type, {String? errorMessage}) =
      _IntroEvent;
}

enum IntroEventType { onEdsLoginFailed, lostConnection, onOpenHome }
