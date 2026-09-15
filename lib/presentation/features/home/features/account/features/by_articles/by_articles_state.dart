part of 'by_articles_cubit.dart';

@freezed
class ByArticlesState with _$ByArticlesState {
  const factory ByArticlesState({
    @Default(true) bool isLoading,
    @Default(false) bool isTheme,
    @Default(true) bool isNotification,
    @Default(LoadingState.loading) LoadingState loadingState,
    @Default("") String merchantToken,
  }) = _ByArticlesState;
}

@freezed
class ByArticlesEvent with _$ByArticlesEvent {
  const factory ByArticlesEvent() = _ByArticlesEvent;
}
