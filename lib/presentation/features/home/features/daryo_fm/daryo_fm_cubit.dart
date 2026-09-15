import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import '../../../../../core/enum/enums.dart';
import '../../../../../data/repositories/daryo_fm_repository.dart';
import '../../../../../domain/models_daryo/daryo_fm/darto_fm_item.dart';
import '../../../../stream_controllers/language_selection_stream_controller.dart';
import '../../../../support/connection/connectivity_provider.dart';

part 'daryo_fm_cubit.freezed.dart';
part 'daryo_fm_state.dart';

@Injectable()
class DaryoFmCubit extends BaseCubit<DaryoFmState, DaryoFmEvent> {
  final ConnectivityService  _connectivityService;
  final DaryoFmRepository _daryoFmRepository;
  final LanguageSelectionStreamController _languageSelectionStreamController;
  StreamSubscription? _languageSubs;
  DaryoFmCubit(this._daryoFmRepository,this._connectivityService, this._languageSelectionStreamController) : super(DaryoFmState()) {
    getInitialData();
    _languageSubs=_languageSelectionStreamController.listen((data){
      getInitialData();
      refresh();
    });
  }

   AudioPlayer audioPlayer = AudioPlayer();


  Future<void> getInitialData() async {
    await Future.wait([
      _checkInternetConnection(),
      getFirstFm(),
      getController()
    ]);
  }

  Future _checkInternetConnection() async{
    final connected= await _connectivityService.hasInternetConnection();
    if(connected==false){
      emitEvent(DaryoFmEvent(DaryoFmEventType.lostConnection));
    }
  }

  Future<void> refresh() async{
    _checkInternetConnection();
    states.controller?.refresh();
  }

  Future<void> getController() async {
    try {
      final controller = states.controller ?? getNotificationController(status: 1);
      updateState((state) => state.copyWith(controller: controller));
    } on DioException catch (e, stackTrace) {}
    finally {
    }
  }

  PagingController<int,DaryoFm> getNotificationController({required int status}) {
    final controller = PagingController<int, DaryoFm>(firstPageKey: 0, invisibleItemsThreshold: 50);
    controller.addPageRequestListener((pageKey) async {
      try{
        final items = await _daryoFmRepository.getRadioFmList(page: pageKey, limit: 20);
        if (items.length <= 19) {
          controller.appendLastPage(items);
          return;
        }
        controller.appendPage(items, pageKey + 20);
      }catch(e){
        controller.error=e;
      }
    },
    );
    return controller;
  }

  Future<void> getFirstFm() async{
    final items= await _daryoFmRepository.getFirstFm();
    updateState((state) => state.copyWith(runningFm: items.firstOrNull));
  }

  void setAudio(DaryoFm daryoFm) async{
    updateState((state) => state.copyWith(runningFm: daryoFm));
    final itemList = states.controller?.itemList;
    if (itemList == null) return;
    final index = itemList.indexOf(daryoFm);
    if (index < 0) return;
    final isCurrentlyPlaying = daryoFm.isPlaying;
    if (isCurrentlyPlaying) {
      logger.e("dedede");
      //itemList[index].isPlaying = false;
      for (final element in itemList) {
        element.isPlaying = false;
      }
    } else {
     // logger.e("dededeas 222");
      for (final element in itemList) {
        element.isPlaying = false;
      }
      itemList[index].isPlaying = true;
    }
    states.controller?.notifyListeners();
  }


  void onNextClicked() async{
    final currentItem=states.runningFm;
    final itemList = states.controller?.itemList??[];
    if(currentItem!=null){
      final index = itemList.indexWhere((e)=>e.id==currentItem.id);
      logger.w(index);
      if (index < 0) return;
      try{
        final nextItem=itemList[index+1];
        updateState((state) => state.copyWith(runningFm: nextItem));
        for (final element in itemList) {
          element.isPlaying = false;
        }
        itemList[index+1].isPlaying = true;
      }catch (e){}

    }
  }

  void onPreviousClicked() async{
    final currentItem=states.runningFm;
    final itemList = states.controller?.itemList??[];
    if(currentItem!=null){
      final index = itemList.indexOf(currentItem);
      if (index < 0) return;
      try{
        final nextItem=itemList[index-1];
        updateState((state) => state.copyWith(runningFm: nextItem));
        for (final element in itemList) {
          element.isPlaying = false;
        }
        itemList[index-1].isPlaying = true;
      }catch (e){}




    }
  }


  void startStop(DaryoFm daryoFm){
    final index = states.controller?.itemList?.indexOf(daryoFm) ?? 0;
    final item = states.controller?.itemList?.elementAt(index);
    if (item != null) {
      states.controller?.itemList?.insert(
        index,
        item..isPlaying = !daryoFm.isPlaying
      );
      states.controller?.itemList?.removeAt(index);
      states.controller?.notifyListeners();
  }
    }


  void setInitialFm(DaryoFm? daryoFm) async{
    if(daryoFm!=null){
      updateState((state) => state.copyWith(runningFm: daryoFm));
      final itemList = states.controller?.itemList;
      if (itemList == null) return;
      final foundDaryoFm=itemList.firstWhere((e)=>e.id==daryoFm.id);
      final index = itemList.indexOf(foundDaryoFm);
      if (index < 0) return;
      for (int i = 0; i < itemList.length; i++) {
        itemList[i].isPlaying = (i == index);
      }
      states.controller?.notifyListeners();
    }
  }

  void onPause(DaryoFm? daryoFm) async{
    if(daryoFm!=null){
      updateState((state) => state.copyWith(runningFm: daryoFm));
      final itemList = states.controller?.itemList;
      if (itemList == null) return;

      // Hammasini false qilish
      for (var item in itemList) {
        item.isPlaying = false;
      }

      states.controller?.notifyListeners();
    }
  }

  @override
  Future<void> close() {
    _languageSubs?.cancel();
    return super.close();
  }

}
