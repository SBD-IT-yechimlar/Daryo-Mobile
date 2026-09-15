part of 'search_hashtag_cubit.dart';

@freezed
class SearchHashTagState with _$SearchHashTagState {
  const factory SearchHashTagState({
    String? searchQuery,
    @Default(LoadingState.loading) LoadingState notificationsState,
    PagingController<int, Common>? controller,
  }) = _SearchHashTagState;
}

@freezed
class SearchHashTagEvent with _$SearchHashTagEvent {
  const factory SearchHashTagEvent(SearchHashTagEventType type) = _SearchHashTagEvent;
}

enum SearchHashTagEventType { lostConnection}
