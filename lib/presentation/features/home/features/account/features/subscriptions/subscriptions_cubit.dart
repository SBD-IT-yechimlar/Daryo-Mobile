import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import 'package:daryo/presentation/support/extensions/extension_message_exts.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../data/datasource/network/dto/account/subscriptions/subscriptions_response.dart';
import '../../../../../../../data/repositories/account_repository.dart';

part 'subscriptions_cubit.freezed.dart';
part 'subscriptions_state.dart';

@Injectable()
class SubscriptionsCubit extends BaseCubit<SubscriptionsState, SubscriptionsEvent> {
  SubscriptionsCubit(this._accountRepository) : super(const SubscriptionsState()) {
    getSubscriptions();
  }

  final AccountRepository _accountRepository;

  void hideLoading() {
    updateState((state) => state.copyWith(isLoading: false));
  }

  void setTheme(bool value) {
    updateState((state) => state.copyWith(isTheme: value));
  }

  void toggleItem(String id) {
    final updatedOpenItems = {...?state.state?.openItems};

    if (updatedOpenItems.contains(id)) {
      updatedOpenItems.remove(id);
    } else {
      updatedOpenItems.add(id);
    }
    updateState((state) => state.copyWith(openItems: updatedOpenItems));
  }



  Future<void> getSubscriptions() async {
    _accountRepository
        .getSubscriptions()
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(loadingState: LoadingState.loading));
        })
        .onSuccess((data) {
          if (data.isNotEmpty) {
            updateState((state) => state.copyWith(subscriptionsList: data, loadingState: LoadingState.success));
          } else {
            updateState((state) => state.copyWith(loadingState: LoadingState.empty));
          }
        })
        .onError((error) {
          updateState((state) => state.copyWith(loadingState: LoadingState.error));
        })
        .onFinished(() {})
        .executeFuture();
  }
}
