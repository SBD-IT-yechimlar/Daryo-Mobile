part of 'lost_connection_cubit.dart';

@freezed
class LostConnectionState with _$LostConnectionState {
  const factory LostConnectionState({
    @Default(true) bool isLoading,
    @Default(false) bool isTheme,
    @Default(true) bool isNotification,
    @Default(LoadingState.loading) LoadingState loadingState,
    @Default("") String merchantToken,
  }) = _LostConnectionState;
}

@freezed
class LostConnectionEvent with _$LostConnectionEvent {
  const factory LostConnectionEvent(LostConnectionEventType type) = _LostConnectionEvent;
}

enum LostConnectionEventType { lostConnection, connected}
