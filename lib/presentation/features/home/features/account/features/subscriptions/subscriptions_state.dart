part of 'subscriptions_cubit.dart';

@freezed
class SubscriptionsState with _$SubscriptionsState {
  const factory SubscriptionsState({
    @Default(true) bool isLoading,
    @Default(false) bool isTheme,
    @Default(true) bool isNotification,
    @Default({}) Set<String> openItems,
    @Default([]) List<SubscriptionsListResponse> subscriptionsList,
    @Default(LoadingState.loading) LoadingState loadingState,
    @Default("") String merchantToken,
  }) = _SubscriptionsState;
}

@freezed
class SubscriptionsEvent with _$SubscriptionsEvent {
  const factory SubscriptionsEvent() = _SubscriptionsEvent;
}
