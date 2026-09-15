part of 'tariffs_cubit.dart';


@freezed
class TariffsState with _$TariffsState {
  const factory TariffsState({
    @Default([]) List<Tariff> tariffs,
    @Default(LoadingState.loading) LoadingState loadingState,

  }) = _TariffsState;
}

@freezed
class TariffsEvent with _$TariffsEvent {
  const factory TariffsEvent() = _TariffsEvent;
}
