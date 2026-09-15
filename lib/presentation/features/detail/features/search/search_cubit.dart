/*
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/presentation/stream_controllers/language_selection_stream_controller.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';

import '../../../../../../../core/enum/enums.dart';
import '../../../../../../../data/repositories/common_repository.dart';
import '../../../../../../../data/repositories/recommendation_repository.dart';
import '../../../../../../../domain/models_daryo/recommendation/reccommendation.dart';
import '../../../../../../../domain/models_daryo/recommendation/recommendation.dart';

part 'search_cubit.freezed.dart';
part 'search_state.dart';

@injectable
class SearchCubit extends BaseCubit<SearchState, SearchEvent> {
  final CommonRepository _commonRepository;
  final RecommendationRepository _recommendationRepository;

  SearchCubit(
    this._commonRepository,
    this._recommendationRepository,
  ) : super(SearchState()) {
    getController();
  }

  Future<void> getController() async {
    try {
      final controller = states.controller ?? getNotificationController(status: 1);
      updateState((state) => state.copyWith(controller: controller));
    } on DioException catch (e, stackTrace) {}
    finally {
    }
  }

  PagingController<int,Recommendation> getNotificationController({required int status}) {
    final controller = PagingController<int, Recommendation>(firstPageKey: 0, invisibleItemsThreshold: 50);
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

}
*/
