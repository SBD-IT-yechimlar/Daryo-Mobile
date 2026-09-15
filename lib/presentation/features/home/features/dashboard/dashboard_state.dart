part of 'dashboard_cubit.dart';

@freezed
class DashboardState with _$DashboardState {
  const DashboardState._();

  @freezed
  const factory DashboardState({
    @Default(false) bool isRegistered,

    @Default([]) List<SliderModel> sliders,
    @Default(LoadingState.loading) LoadingState sliderState,

    @Default([]) List<Common> recommendations,
    @Default(true) bool isGrid,
    @Default(LoadingState.loading) LoadingState recommendationsState,

    @Default([]) List<Common> dunyoNews,
    @Default(LoadingState.loading) LoadingState dunyoNewsState,

    @Default([]) List<Common> latestNews,
    @Default(LoadingState.loading) LoadingState latestNewsState,

    @Default([]) List<Common> autoNews,
    @Default(LoadingState.loading) LoadingState autoNewsState,

    @Default([]) List<Tag> tags,
    @Default(LoadingState.loading) LoadingState tagsState,

    @Default([]) List<Short> shorts,
    @Default(LoadingState.loading) LoadingState shortsState,

    @Default([]) List<Video> videos,
    @Default(LoadingState.loading) LoadingState videosState,

    @Default([]) List<Common> hotNews,
    @Default(LoadingState.loading) LoadingState hotNewsState,

    @Default([]) List<CategoryModel> category,
    @Default(0) int categoryId,
    @Default("") String categoryName,
    @Default("") String categorySlug,
    @Default(0) int byCategoryId,
    @Default([]) List<Common> categoryList,
    @Default(LoadingState.loading) LoadingState categoryListState,
   // @Default({}) Map<int, List<Common>> categoryMap,
    @Default({}) Map<String, List<Common>> categoryMap,
    @Default('oz') String language,
    @Default(LoadingState.loading) LoadingState state,

    @Default(0) int uzbekistanId,
    @Default(0) int qirgizistonId,
    @Default(0) int qozogistonId,
    @Default(0) int turkmanistonId,
    @Default(0) int tojikistonId,
    @Default(0) int afghanistanId,

  }) = _DashboardState;

}

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent(DashboardEventType type) = _DashboardEvent;
}

enum DashboardEventType { lostConnection}
