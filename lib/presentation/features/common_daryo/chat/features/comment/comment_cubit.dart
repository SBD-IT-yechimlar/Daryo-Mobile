import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../data/repositories/auth_repository.dart';

part 'comment_cubit.freezed.dart';
part 'comment_state.dart';

@Injectable()
class CommentCubit extends BaseCubit<CommentState, CommentEvent> {
  CommentCubit(this._authRepository) : super(const CommentState()) {
    // getPaymentMerchantToken();
  }

  final AuthRepository _authRepository;

  void hideLoading() {
    updateState((state) => state.copyWith(isLoading: false));
  }

  void setTheme(bool value) {
    updateState((state) => state.copyWith(isTheme: value));
  }

  void toggleItem(String id) {
    // Eski setni yangi nusxasiga o‘tkazamiz
    final updatedOpenItems = {...?state.state?.openItems};

    if (updatedOpenItems.contains(id)) {
      updatedOpenItems.remove(id);
    } else {
      updatedOpenItems.add(id);
    }

    // Yangilangan holatni qayta o‘rnatamiz
    updateState((state) => state.copyWith(openItems: updatedOpenItems));
  }

}
