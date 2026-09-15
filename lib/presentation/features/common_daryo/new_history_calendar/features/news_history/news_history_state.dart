part of 'news_history_cubit.dart';

@freezed
class NewsHistoryState with _$NewsHistoryState {
  const factory NewsHistoryState({
    @Default(true) bool isLoading,
    @Default(false) bool isTheme,
    @Default(true) bool isNotification,
    @Default(LoadingState.loading) LoadingState loadingState,
    @Default(null) List<NewsHistoryList>? newsHistoryList,

    @Default(LoadingState.loading) LoadingState newsState,
    PagingController<int, NewsHistoryList>? controller,
    @Default("") String selectDate,


  }) = _NewsHistoryState;
}

@freezed
class NewsHistoryEvent with _$NewsHistoryEvent {
  const factory NewsHistoryEvent() = _NewsHistoryEvent;
}
