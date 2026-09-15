part of 'videos_cubit.dart';

@freezed
class VideosState with _$VideosState {
  const factory VideosState({
    @Default([]) List<Video> videos,
    @Default(0) int offset,
    @Default(true) bool haveMore,
    @Default(LoadingState.loading) LoadingState videosState,
    @Default(false) bool isRegistered,
  }) = _VideosState;
}

@freezed
class VideosEvent with _$VideosEvent {
  const factory VideosEvent(VideosEventType type,{String? text}) = _VideosEvent;
}

enum VideosEventType {
  handleError,
  lostConnection,
}