import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/data/repositories/daryo_subscription_repository.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:daryo/core/enum/enums.dart';

import '../../../../../../../domain/models_daryo/tariff/tariff.dart';

part 'tariffs_cubit.freezed.dart';

part 'tariffs_state.dart';

class TariffsCubit extends BaseCubit<TariffsState, TariffsEvent> {
  final DaryoSubscriptionRepository _daryoSubscriptionRepository;

  TariffsCubit(this._daryoSubscriptionRepository)
      : super(const TariffsState()) {
    getTariffs();
  }

  Future<void> getTariffs() async {
    final tariffs = _daryoSubscriptionRepository
        .getTariffs()
        .initFuture()
        .onStart(() {
          updateState(
              (state) => state.copyWith(loadingState: LoadingState.loading));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(
              tariffs: data, loadingState: LoadingState.success));
        })
        .onError((error) {
          updateState(
              (state) => state.copyWith(loadingState: LoadingState.error));
        })
        .onFinished(() {})
        .executeFuture();
  }
}
