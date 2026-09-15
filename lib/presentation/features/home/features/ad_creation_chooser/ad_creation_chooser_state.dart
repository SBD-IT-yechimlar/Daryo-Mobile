part of 'ad_creation_chooser_cubit.dart';

@freezed
class AdCreationChooserState with _$AdCreationChooserState {
  const factory AdCreationChooserState({
    @Default(false) bool isRegistered,

    @Default(false) bool isAuthorized,
    @Default([]) List<Tag> tags,
    @Default(LoadingState.loading) LoadingState tagsState,

    @Default([]) List<Category> categories,
    @Default(LoadingState.loading) LoadingState categoriesState,
    @Default(true) bool goodNew,
  }) = _AdCreationChooserState;
}

@freezed
class AdCreationChooserEvent with _$AdCreationChooserEvent {
  const factory AdCreationChooserEvent(AdCreationChooserEventType type) = _AdCreationChooserEvent;
}

enum AdCreationChooserEventType { lostConnection}

