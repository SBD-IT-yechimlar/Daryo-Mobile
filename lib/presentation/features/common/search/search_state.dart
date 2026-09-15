part of 'search_cubit.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    @Default("") String searchQuery,
    @Default(null) PagingController<int, Common>? controller,
  }) = _SearchState;
}

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.queryChanged(String query) = _QueryChanged;
}

