part of 'internet_publication_cubit.dart';

@freezed
class InternetPublicationState with _$InternetPublicationState {
  const factory InternetPublicationState({
    @Default(true) bool isLoading,
    @Default(false) bool isTheme,
    @Default(true) bool isNotification,
    @Default(LoadingState.loading) LoadingState loadingState,
    @Default("") String merchantToken,
  }) = _InternetPublicationState;
}

@freezed
class InternetPublicationEvent with _$InternetPublicationEvent {
  const factory InternetPublicationEvent() = _InternetPublicationEvent;
}
