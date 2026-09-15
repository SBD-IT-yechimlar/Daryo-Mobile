import 'dart:async';

import 'package:daryo/data/repositories/common_repository.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/presentation/stream_controllers/language_selection_stream_controller.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import '../../../../../core/enum/enums.dart';
import '../../../../../data/repositories/recommendation_repository.dart';
import '../../../../../domain/models_daryo/recommendation/reccommendation.dart';
import '../../../../domain/models_daryo/recommendation/recommendation.dart';
import '../../../support/connection/connectivity_provider.dart';

part 'search_hashtag_cubit.freezed.dart';
part 'search_hashtag_state.dart';

@injectable
class SearchHashTagCubit extends BaseCubit<SearchHashTagState, SearchHashTagEvent> {
  final ConnectivityService  _connectivityService;
  final CommonRepository _commonRepository;
  SearchHashTagCubit( this._connectivityService,this._commonRepository) : super(SearchHashTagState()) {
    _checkInternetConnection();

  }

  Future _checkInternetConnection() async{
    final connected= await _connectivityService.hasInternetConnection();
    if(connected==false){
      emitEvent(SearchHashTagEvent(SearchHashTagEventType.lostConnection));
    }
  }

  Future<void> refresh() async{
    _checkInternetConnection();
    states.controller?.refresh();
  }

  Future<void> refreshController() async{
    states.controller?.refresh();
  }

  Future<void> getController(String tag) async {
    try {
      final controller = states.controller ?? getSearchHashTagController(status: 1,tag: tag);
      updateState((state) => state.copyWith(controller: controller));
    } on DioException catch (e, stackTrace) {}
    finally {
    }
  }

  PagingController<int,Common> getSearchHashTagController({required int status,required String tag}) {
    final controller = PagingController<int, Common>(firstPageKey: 0, invisibleItemsThreshold: 50);
    controller.addPageRequestListener((pageKey) async {
      try{
        final items = await _commonRepository.getSearchHashTag(page: pageKey, limit: 20,tag:tag);
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

}
