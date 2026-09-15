part of 'recommendations_cubit.dart';

@freezed
class RecommendationsState with _$RecommendationsState {
  const factory RecommendationsState({
    String? searchQuery,
    @Default(LoadingState.loading) LoadingState notificationsState,
    PagingController<int, RecommendationModel>? controller,
    @Default(false) bool isRegistered,
    @Default(0) int selectedIndex,
    PagingController<int, Common>? lastNewsController,
  }) = _RecommendationsState;
}

@freezed
class RecommendationsEvent with _$RecommendationsEvent {
  const factory RecommendationsEvent(RecommendationsEventType type) = _RecommendationsEvent;
}

enum RecommendationsEventType { lostConnection}
