import 'package:daryo/data/repositories/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';

part 'internet_publication_cubit.freezed.dart';
part 'internet_publication_state.dart';

@Injectable()
class InternetPublicationCubit
    extends BaseCubit<InternetPublicationState, InternetPublicationEvent> {
  InternetPublicationCubit(this._authRepository)
      : super(const InternetPublicationState()) {
    // getPaymentMerchantToken();
  }

  final AuthRepository _authRepository;

  void hideLoading() {
    updateState((state) => state.copyWith(isLoading: false));
  }

}
