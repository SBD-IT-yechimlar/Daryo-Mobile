import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../data/repositories/auth_repository.dart';

part 'news_history_calendar_cubit.freezed.dart';
part 'news_history_calendar_state.dart';

@Injectable()
class NewsHistoryCalendarCubit extends BaseCubit<NewsHistoryCalendarState, NewsHistoryCalendarEvent> {
  NewsHistoryCalendarCubit(this._authRepository) : super(const NewsHistoryCalendarState()) {
    setSelectDate(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  }

  final AuthRepository _authRepository;

  void setSelectDate(String selectDate) {
    updateState((state) => state.copyWith(selectedDate: selectDate));
  }
}
