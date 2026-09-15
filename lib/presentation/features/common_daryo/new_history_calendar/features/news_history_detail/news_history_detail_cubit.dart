import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../data/datasource/network/dto/news_history/news_history_response.dart';
import '../../../../../../data/repositories/news_repository.dart';

part 'news_history_detail_cubit.freezed.dart';
part 'news_history_detail_state.dart';

@Injectable()
class NewsHistoryDetailCubit extends BaseCubit<NewsHistoryDetailState, NewsHistoryDetailEvent> {
  NewsHistoryDetailCubit(this._newsRepository) : super(const NewsHistoryDetailState()) {
    pagingController.addPageRequestListener((pageKey) {
      getNewsHistory(page: pageKey);
    });
  }

  final NewsRepository _newsRepository;

  final PagingController<int, NewsHistoryList> pagingController = PagingController(firstPageKey: 1);

  final int _pageSize = 10;

  Future<void> setSelectDate(String date) async {
    updateState((state) => state.copyWith(selectDate: date));
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

  void refresh() {
    pagingController.refresh();
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
