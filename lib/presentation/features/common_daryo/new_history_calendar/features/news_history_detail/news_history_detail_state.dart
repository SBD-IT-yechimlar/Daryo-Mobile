part of 'news_history_detail_cubit.dart';

@freezed
class NewsHistoryDetailState with _$NewsHistoryDetailState {
  const factory NewsHistoryDetailState({
    @Default(true) bool isLoading,
    @Default(false) bool isTheme,
    @Default(true) bool isNotification,
    @Default(LoadingState.loading) LoadingState loadingState,
    @Default("") String selectDate,
    @Default(null) List<NewsHistoryList>? newsHistoryList,
  }) = _NewsHistoryDetailState;
}

@freezed
class NewsHistoryDetailEvent with _$NewsHistoryDetailEvent {
  const factory NewsHistoryDetailEvent() = _NewsHistoryDetailEvent;
}
