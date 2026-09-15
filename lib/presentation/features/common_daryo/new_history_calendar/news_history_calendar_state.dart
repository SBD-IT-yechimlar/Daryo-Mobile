part of 'news_history_calendar_cubit.dart';

@freezed
class NewsHistoryCalendarState with _$NewsHistoryCalendarState {
  const factory NewsHistoryCalendarState({
    @Default(true) bool isLoading,
    @Default(false) bool isTheme,
    @Default(true) bool isNotification,
    @Default(LoadingState.loading) LoadingState loadingState,
    @Default("") String selectedDate,
  }) = _NewsHistoryCalendarState;
}

@freezed
class NewsHistoryCalendarEvent with _$NewsHistoryCalendarEvent {
  const factory NewsHistoryCalendarEvent() = _NewsHistoryCalendarEvent;
}
