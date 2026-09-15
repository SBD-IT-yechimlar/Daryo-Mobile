import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';

import '../../../../../../../data/repositories/auth_repository.dart';

part 'quiz_history_cubit.freezed.dart';
part 'quiz_history_state.dart';

@Injectable()
class QuizHistoryCubit
    extends BaseCubit<QuizHistoryState, QuizHistoryEvent> {
  QuizHistoryCubit(this._authRepository)
      : super(const QuizHistoryState()) {
    // getPaymentMerchantToken();
  }

  final AuthRepository _authRepository;


}
