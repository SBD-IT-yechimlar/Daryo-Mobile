import 'dart:async';

import 'package:daryo/data/datasource/preference/auth_preferences.dart';
import 'package:daryo/data/datasource/preference/user_preferences.dart';
import 'package:daryo/presentation/stream_controllers/language_selection_stream_controller.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import 'package:logger/logger.dart';

import '../../../../../data/repositories/theme_mode_repository.dart';
import '../../../../../domain/models/language/language.dart';
import '../../../../../domain/models/theme/app_theme_mode.dart';
import '../../../../stream_controllers/app_theme_mode_stream_controller.dart';
import '../../../../stream_controllers/update_profile_stream_controller.dart';

part 'account_cubit.freezed.dart';
part 'account_state.dart';

@Injectable()
class AccountCubit
    extends BaseCubit<AccountState, AccountEvent> {
  final ThemeModeRepository _themeModeRepository;
  final AuthPreferences _authPreferences;
  final UserPreferences _userPreferences;
  final AppThemeModeStreamController _appThemeModeStreamController;
  final UpdateProfileStreamController _updateProfileStreamController;
  final LanguageSelectionStreamController _languageSelectionStreamController;

  AccountCubit(this._themeModeRepository, this._appThemeModeStreamController, this._authPreferences, this._userPreferences, this._updateProfileStreamController, this._languageSelectionStreamController) : super(const AccountState()) {
    _getThemeMode();
    setUserInfo();
    _updateProfile= _updateProfileStreamController.listen((data){
      Logger().w("acd");
      setUserInfo();
    });
  }

  StreamSubscription? _updateProfile;


  void hideLoading() {
    updateState((state) => state.copyWith(isLoading: false));
  }

  void setTheme(bool value) {
    updateState((state) => state.copyWith(isTheme: value));
  }

  void setNotification(bool value) {
    updateState((state) => state.copyWith(isNotification: value));
  }

  void _getThemeMode() async {
    final mode = _themeModeRepository.getAppThemeMode();
    updateState((state) => state.copyWith(appThemeMode: mode));
  }

  void setSelectedThemeMode(AppThemeMode mode) async {
    await _themeModeRepository.setAppThemeMode(mode);
    updateState((state) => state.copyWith(appThemeMode: mode));
    _appThemeModeStreamController.add(mode);
  }

  void setUserInfo() async{
    final fullName=_userPreferences.username;
    final email=_userPreferences.email;
    final avatar= await _userPreferences.getSavedXFile();
    updateState((state) => state.copyWith(
        fullName: fullName??"",
        email: email??"",
        avatar: avatar
    ));


  }

  void updateLanguage(Language language){
    _languageSelectionStreamController.add(language);
  }

  Future<void> logOut() async {
    await _authPreferences.clear();
    await _userPreferences.clear();
    return;
  }

  @override
  Future<void> close() async {
    _updateProfile?.cancel();
    super.close();
  }


}
