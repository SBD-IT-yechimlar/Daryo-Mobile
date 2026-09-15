import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../data/repositories/account_repository.dart';

part 'by_articles_cubit.freezed.dart';
part 'by_articles_state.dart';

@Injectable()
class ByArticlesCubit extends BaseCubit<ByArticlesState, ByArticlesEvent> {
  ByArticlesCubit(this._accountRepository) : super(const ByArticlesState()) {
   //  getPaymentMerchantToken();
  }

  final AccountRepository _accountRepository;

  Future<void> getBought() async {
    _accountRepository
        .getBought()
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(loadingState: LoadingState.loading));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(loadingState: LoadingState.success));
        })
        .onError((error) {
          updateState((state) => state.copyWith(loadingState: LoadingState.error));
        })
        .onFinished(() {})
        .executeFuture();
  }
}
