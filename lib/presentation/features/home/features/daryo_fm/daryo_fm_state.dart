part of 'daryo_fm_cubit.dart';

@freezed
class DaryoFmState with _$DaryoFmState {
  const factory DaryoFmState({
    @Default(false) bool isRegistered,

    @Default(LoadingState.loading) LoadingState notificationsState,
    PagingController<int, DaryoFm>? controller,
    DaryoFm? runningFm,
    int? playingItemId,

    @Default(Duration.zero) Duration duration,
    @Default(Duration.zero) Duration position,

  }) = _DaryoFmState;
}

@freezed
class DaryoFmEvent with _$DaryoFmEvent {
  const factory DaryoFmEvent(DaryoFmEventType type) = _DaryoFmEvent;
}

enum DaryoFmEventType { lostConnection}
