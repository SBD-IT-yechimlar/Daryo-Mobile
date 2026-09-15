part of 'team_member_info_cubit.dart';

@freezed
class TeamMemberInfoState with _$TeamMemberInfoState {
  const factory TeamMemberInfoState({
    @Default(true) bool isLoading,
    @Default(false) bool isTheme,
    @Default(true) bool isNotification,
    @Default(LoadingState.loading) LoadingState loadingState,
    @Default("") String merchantToken,
  }) = _TeamMemberInfoState;
}

@freezed
class TeamMemberInfoEvent with _$TeamMemberInfoEvent {
  const factory TeamMemberInfoEvent() = _TeamMemberInfoEvent;
}
