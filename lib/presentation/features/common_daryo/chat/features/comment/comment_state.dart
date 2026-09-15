part of 'comment_cubit.dart';

@freezed
class CommentState with _$CommentState {
  const factory CommentState({
    @Default(true) bool isLoading,
    @Default(false) bool isTheme,
    @Default(true) bool isNotification,
    @Default({}) Set<String> openItems,
    @Default(LoadingState.loading) LoadingState loadingState,
    @Default("") String merchantToken,
  }) = _CommentState;
}

@freezed
class CommentEvent with _$CommentEvent {
  const factory CommentEvent() = _CommentEvent;
}
