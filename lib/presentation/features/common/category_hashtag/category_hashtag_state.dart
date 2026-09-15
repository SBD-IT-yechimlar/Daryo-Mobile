part of 'category_hashtag_cubit.dart';

@freezed
class CategoryHashTagState with _$CategoryHashTagState {
  const factory CategoryHashTagState({
    String? searchQuery,
    @Default(LoadingState.loading) LoadingState notificationsState,
    PagingController<int, Common>? controller,
  }) = _CategoryHashTagState;
}

@freezed
class CategoryHashTagEvent with _$CategoryHashTagEvent {
  const factory CategoryHashTagEvent(CategoryHashTagEventType type) = _CategoryHashTagEvent;
}

enum CategoryHashTagEventType { lostConnection}
