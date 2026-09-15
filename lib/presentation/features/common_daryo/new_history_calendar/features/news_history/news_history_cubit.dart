import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../data/datasource/network/dto/news_history/news_history_response.dart';
import '../../../../../../data/repositories/news_repository.dart';

part 'news_history_cubit.freezed.dart';
part 'news_history_state.dart';

@Injectable()
class NewsHistoryCubit extends BaseCubit<NewsHistoryState, NewsHistoryEvent> {
  NewsHistoryCubit(this._newsRepository) : super(const NewsHistoryState()) {
    pagingController.addPageRequestListener((pageKey) {
      getNewsHistory(page: pageKey);
    });
  }

  final NewsRepository _newsRepository;

  final PagingController<int, NewsHistoryList> pagingController = PagingController(firstPageKey: 1);

  final int _pageSize = 10;

  Future<void> setSelectDate(String date) async {
    updateState((state) => state.copyWith(selectDate: date));
    getController(date);
  }

  Future<void> getNewsHistory({required int page}) async {
    _newsRepository
        .getCalendarNews(date: states.selectDate, limit: _pageSize, offset: page)
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(loadingState: LoadingState.loading));
        })
        .onSuccess((data) {
          final response = NewsHistoryResponse.fromJson(data.data);
          if (response.data != null) {
            final isLastPage = (response.data?.length ?? 0) < _pageSize;
            if (isLastPage) {
              pagingController.appendLastPage(response.data ?? []);
            } else {
              pagingController.appendPage(response.data ?? [], page + 1);
            }
          }
          updateState((state) => state.copyWith(newsHistoryList: response.data, loadingState: LoadingState.success));
        })
        .onError((error) {
          pagingController.error = error;
          updateState((state) => state.copyWith(loadingState: LoadingState.error));
        })
        .onFinished(() {})
        .executeFuture();
  }


  Future<void> getController(String selectDate) async {
    try {
      final controller = states.controller ?? getSearchHashTagController(selectDate);
      updateState((state) => state.copyWith(controller: controller));
    } on DioException catch (e, stackTrace) {}
    finally {
    }
  }

  PagingController<int,NewsHistoryList> getSearchHashTagController(String selectDate) {
    final controller = PagingController<int, NewsHistoryList>(firstPageKey: 0, invisibleItemsThreshold: 50);
    controller.addPageRequestListener((pageKey) async {
      try{
        final items = await _newsRepository.getCalendarNewsV2(date: states.selectDate, limit: 20, offset: pageKey);
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

  void refresh() {
    pagingController.refresh();
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
