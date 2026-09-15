import 'dart:async';

import 'package:daryo/core/handler/future_handler.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';

import '../../../../../core/enum/enums.dart';
import '../../../../../data/datasource/preference/auth_preferences.dart';
import '../../../../../data/repositories/dashboard_repository.dart';
import '../../../../../domain/models_daryo/category/category.dart';
import '../../../../../domain/models_daryo/tags/tag.dart';
import '../../../../stream_controllers/language_selection_stream_controller.dart';
import '../../../../support/connection/connectivity_provider.dart';

part 'ad_creation_chooser_cubit.freezed.dart';

part 'ad_creation_chooser_state.dart';

@Injectable()
class AdCreationChooserCubit extends BaseCubit<AdCreationChooserState, AdCreationChooserEvent> {
  final DaryoDashboardRepository _dashboardRepository;
  final ConnectivityService _connectivityService;
  final AuthPreferences _authPreferences;
  final LanguageSelectionStreamController _languageSelectionStreamController;
  StreamSubscription? _languageSubs;

  AdCreationChooserCubit(
    this._dashboardRepository,
    this._connectivityService,
    this._authPreferences,
    this._languageSelectionStreamController,
  ) : super(AdCreationChooserState()) {
    getInitialData();
    _languageSubs=_languageSelectionStreamController.listen((data){
      getInitialData();
    });

  }

  Future<void> getInitialData() async {
    await Future.wait([ _checkInternetConnection(), getCategories(), getTags(),isAuthorized()]);
  }

  Future<void> isAuthorized() async{
    final isAuthorized =_authPreferences.isAuthorized;
    updateState((state) => state.copyWith(isAuthorized: isAuthorized));

  }

  Future<void> _checkInternetConnection() async {
    final connected = await _connectivityService.hasInternetConnection();
    if (connected == false) {
      emitEvent(
          AdCreationChooserEvent(AdCreationChooserEventType.lostConnection));
    }
  }

  Future<void> getCategories() async {
    _dashboardRepository
        .getCategories()
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(categoriesState: LoadingState.loading));})
        .onSuccess((data) {
          updateState((state) => state.copyWith(
              categories: data,
              categoriesState: LoadingState.success));
        })
        .onError((error) {
          updateState(
              (state) => state.copyWith(categoriesState: LoadingState.error));
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getTags() async {
    _dashboardRepository
        .getTags(limit: 20, page: 0)
        .initFuture()
        .onStart(() {
          updateState(
              (state) => state.copyWith(tagsState: LoadingState.loading));
        })
        .onSuccess((data) {
          updateState((state) =>
              state.copyWith(tags: data, tagsState: LoadingState.success));
        })
        .onError((error) {
          updateState((state) => state.copyWith(tagsState: LoadingState.error));
        })
        .onFinished(() {})
        .executeFuture();
  }

  void setGoodNews(){
    updateState((state) => state.copyWith(goodNew: !states.goodNew));
  }

  @override
  Future<void> close() {
    _languageSubs?.cancel();
    return super.close();
  }

}
