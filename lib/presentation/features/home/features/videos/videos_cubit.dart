import 'dart:async';

import 'package:daryo/presentation/support/extensions/extension_message_exts.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import '../../../../../data/repositories/dashboard_repository.dart';
import '../../../../../domain/models_daryo/video/video.dart';
import '../../../../stream_controllers/language_selection_stream_controller.dart';
import '../../../../support/connection/connectivity_provider.dart';

part 'videos_cubit.freezed.dart';
part 'videos_state.dart';

@injectable
class VideosCubit extends BaseCubit<VideosState, VideosEvent> {
  final ConnectivityService  _connectivityService;
  final DaryoDashboardRepository _dashboardRepository;
  final LanguageSelectionStreamController _languageSelectionStreamController;
  StreamSubscription? _languageSubs;
  VideosCubit(this._dashboardRepository, this._connectivityService, this._languageSelectionStreamController) : super(VideosState()) {
    getInitialData();
    _languageSubs=_languageSelectionStreamController.listen((data){
      getInitialData();
    });
  }


  Future _checkInternetConnection() async{
    final connected= await _connectivityService.hasInternetConnection();
    if(connected==false){
      emitEvent(VideosEvent(VideosEventType.lostConnection));
    }
  }

  Future<void> getInitialData() async {
    await Future.wait([
      _checkInternetConnection(),
       getVideos()
    ]);
  }


  Future<void> getVideos() async {
    _dashboardRepository
        .getVideos(limit: 6, page: 0)
        .initFuture()
        .onStart(() {
      updateState((state) => state.copyWith(videosState: LoadingState.loading));
    }).onSuccess((data) {
      updateState((state) => state.copyWith(
          videos: data,
          videosState: data.isNotEmpty? LoadingState.success:LoadingState.empty,
          offset: state.offset+6
      ));
    }).onError((error) {
      updateState((state) => state.copyWith(videosState: LoadingState.error));
    }).onFinished(() {})
        .executeFuture();

  }

  Future<void> reload() async {
    updateState((state) => state.copyWith(haveMore: true, offset: 0));
    _dashboardRepository
        .getVideos(limit: 6, page: 0)
        .initFuture()
        .onStart(() {
      updateState((state) => state.copyWith(videosState: LoadingState.loading));
    }).onSuccess((data) {
      updateState((state) => state.copyWith(
          videos: data,
          videosState: LoadingState.success,
          offset: state.offset+6
      ));
    }).onError((error) {
      updateState((state) => state.copyWith(videosState: LoadingState.error));
    }).onFinished(() {})
        .executeFuture();

  }

  Future<void> getMoreLoad() async {
    _dashboardRepository
        .getVideos(limit: 6, page: states.offset)
        .initFuture()
        .onStart(() {
    }).onSuccess((data) {
      bool haveMore= data.length==6;
      List<Video> newVideos = List.from(states.videos);
      newVideos.addAll(data);
      updateState((state) => state.copyWith(
          videos: newVideos,
          offset: state.offset+6,
          haveMore: haveMore
      ));
    }).onError((error) {
      emitEvent(VideosEvent(VideosEventType.handleError,text: error.localizedMessage));
    }).onFinished(() {})
        .executeFuture();

  }

  @override
  Future<void> close() {
    _languageSubs?.cancel();
    return super.close();
  }


}
