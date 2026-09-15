import 'package:bloc/bloc.dart';
import 'package:daryo/data/repositories/common_repository.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/models_daryo/recommendation/reccommendation.dart';
import '../../../../domain/models_daryo/recommendation/recommendation.dart';

part 'search_state.dart';

part 'search_cubit.freezed.dart';

@injectable
class SearchCubit extends BaseCubit<SearchState, SearchEvent> {
  final CommonRepository _commonRepository;
  SearchCubit(this._commonRepository) : super(const SearchState()) {
    _initController();
  }

  /// Refresh the search results
  Future<void> refresh() async {
    states.controller?.refresh();
  }

  /// Initialize or reinitialize controller when query changes
  Future<void> _initController() async {
    try {
      final controller = states.controller ?? _createController();
      updateState((state) => state.copyWith(controller: controller));
    } on DioException catch (e, stackTrace) {}
  }

  void changeQuery(String query) {
    if (query == states.searchQuery) return;
    updateState((state) => state.copyWith(searchQuery: query));
    final controller = states.controller;
    if (controller == null) return;
    controller.itemList = [];
    controller.nextPageKey = 0;
    controller.error = null;
    controller.refresh();
  }



  PagingController<int, Common> _createController(
     ) {
    final controller = PagingController<int, Common>(
      firstPageKey: 0,
      invisibleItemsThreshold: 10, // Smaller threshold for smoother UX
    );
    controller.addPageRequestListener((pageKey) async {
      try {
        final items = await _commonRepository.getSearchNews(
          page: pageKey,
          limit: 10,
          query: states.searchQuery,
        );

        final isLastPage = items.length < 10;
        if (isLastPage) {
          controller.appendLastPage(items);
        } else {
          controller.appendPage(items, pageKey + 10);
        }
      } catch (e) {
        controller.error = e;
      }
    });

    return controller;
  }

  @override
  Future<void> close() {
    states.controller?.dispose();
    return super.close();
  }
}
