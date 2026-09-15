part of 'quiz_history_cubit.dart';

@freezed
class QuizHistoryState with _$QuizHistoryState {
  const factory QuizHistoryState({
    @Default(true) bool isLoading,
    @Default(false) bool isTheme,
    @Default(true) bool isNotification,
    @Default(LoadingState.loading) LoadingState loadingState,
    @Default("") String merchantToken,
  }) = _QuizHistoryState;
}

@freezed
class QuizHistoryEvent with _$QuizHistoryEvent {
  const factory QuizHistoryEvent() = _QuizHistoryEvent;
}
