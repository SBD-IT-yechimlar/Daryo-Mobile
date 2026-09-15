/*
part of 'search_cubit.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    String? searchQuery,
    @Default(LoadingState.loading) LoadingState notificationsState,
    PagingController<int, Recommendation>? controller,
  }) = _SearchState;
}

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent(
    SearchEventType type) = _SearchEvent;
}

enum SearchEventType { onOpenSubRecommendations, onOpenProductList }
*/
