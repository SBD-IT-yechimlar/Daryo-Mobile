import 'dart:async';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/presentation/stream_controllers/language_selection_stream_controller.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';

import '../../../../../core/enum/enums.dart';
import '../../../../../data/repositories/recommendation_repository.dart';
import '../../../../../domain/models_daryo/recommendation/reccommendation.dart';
import '../../../../../domain/models_daryo/recommendation/recommendation.dart';
import '../../../../support/connection/connectivity_provider.dart';

part 'recommendations_cubit.freezed.dart';
part 'recommendations_state.dart';

@injectable
class RecommendationsCubit extends BaseCubit<RecommendationsState, RecommendationsEvent> {
  final ConnectivityService  _connectivityService;
  final RecommendationRepository _recommendationRepository;
  final LanguageSelectionStreamController _languageSelectionStreamController;
  StreamSubscription? _languageSubs;
  RecommendationsCubit(this._recommendationRepository, this._connectivityService,this._languageSelectionStreamController) : super(RecommendationsState()) {
    _checkInternetConnection();
    getController();
    getLastNews();
    _languageSubs=_languageSelectionStreamController.listen((data){
     refresh();
    });
  }

  Future _checkInternetConnection() async{
    logger.w("xax 111");
    final connected= await _connectivityService.hasInternetConnection();
    logger.w("xax 22");

    if(connected==false){
      logger.w("xax");
      emitEvent(RecommendationsEvent(RecommendationsEventType.lostConnection));
    }
  }


  void selectedIndex(int selectedIndex){
    updateState((state) => state.copyWith(selectedIndex: selectedIndex));
  }

  Future<void> refresh() async{
    _checkInternetConnection();
    states.controller?.refresh();
    states.lastNewsController?.refresh();
  }

  Future<void> refreshController() async{
    states.controller?.refresh();
  }

  Future<void> getController() async {
    try {
      final controller = states.controller ?? getRecommendationsController(status: 1);
      updateState((state) => state.copyWith(controller: controller));
    } on DioException catch (e, stackTrace) {}
    finally {
    }
  }

  PagingController<int,RecommendationModel> getRecommendationsController({required int status}) {
    final controller = PagingController<int, RecommendationModel>(firstPageKey: 0, invisibleItemsThreshold: 50);
    controller.addPageRequestListener((pageKey) async {
      try{
        final items = await _recommendationRepository.getRecommendations(page: pageKey, limit: 20);
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


  Future<void> getLastNews() async {
    try {
      final lastNewsController = states.lastNewsController ?? getLastNewsController(status: 1);
      updateState((state) => state.copyWith(lastNewsController: lastNewsController));
    } on DioException catch (e, stackTrace) {}
    finally {
    }
  }

  PagingController<int,Common> getLastNewsController({required int status}) {
    final controller = PagingController<int, Common>(firstPageKey: 0, invisibleItemsThreshold: 50);
    controller.addPageRequestListener((pageKey) async {
      try{
        final items = await _recommendationRepository.getLastNews(page: pageKey, limit: 20);
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

  @override
  Future<void> close() {
    _languageSubs?.cancel();
    return super.close();
  }


}
