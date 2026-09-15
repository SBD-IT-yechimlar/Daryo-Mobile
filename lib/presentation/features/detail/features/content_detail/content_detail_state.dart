part of 'content_detail_cubit.dart';

@freezed
class ContentDetailState with _$ContentDetailState {
  const ContentDetailState._();

  @freezed
  const factory ContentDetailState({
    @Default(0) int id,
    @Default(0) int like,
    @Default(0) int dislike,
    @Default("") String slug,
    @Default(LoadingState.loading) LoadingState contentLoadingState,
    @Default(ContentDetail()) ContentDetail detail,

    PagingController<int, Common>? controller,

    @Default([]) List<Common> relatedNewsList,
    @Default(LoadingState.loading) LoadingState relatedNewsState,
    @Default(1) int offset,
    @Default("") String tag,
    @Default(true) bool haveMore,

    @Default([]) List<Common> latestNews,
    @Default(LoadingState.loading) LoadingState latestNewsState,

    @Default([]) List<Common> recommendations,
    @Default(LoadingState.loading) LoadingState recommendationsState,
  }) = _ContentDetailState;
}
@freezed
class ContentDetailEvent with _$ContentDetailEvent {
  const factory ContentDetailEvent(ContentDetailEventType type,{String? text}) = _ContentDetailEvent;
}

enum ContentDetailEventType {
  handleError,
  lostConnection,
  likedSuc,
  likedUnSec

}


