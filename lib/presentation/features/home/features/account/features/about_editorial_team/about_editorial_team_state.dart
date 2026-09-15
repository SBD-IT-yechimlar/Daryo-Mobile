part of 'about_editorial_team_cubit.dart';

@freezed
class AboutEditorialTeamState with _$AboutEditorialTeamState {
  const factory AboutEditorialTeamState({
    @Default(LoadingState.loading) LoadingState specialistsState,
    @Default([]) List<Specialist> specialists,
    Specialist? first,
    Specialist? second,
    @Default(LoadingState.loading) LoadingState faceBehindsState,
    @Default([]) List<FaceBehind> faceBehinds,
  }) = _AboutEditorialTeamState;
}

@freezed
class AboutEditorialTeamEvent with _$AboutEditorialTeamEvent {
  const factory AboutEditorialTeamEvent() = _AboutEditorialTeamEvent;
}
