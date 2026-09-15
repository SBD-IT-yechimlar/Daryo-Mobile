import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/data/repositories/account_repository.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import 'package:daryo/presentation/support/extensions/extension_message_exts.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'submit_application_cubit.freezed.dart';
part 'submit_application_state.dart';

@Injectable()
class SubmitApplicationCubit extends BaseCubit<SubmitApplicationState, SubmitApplicationEvent> {
  SubmitApplicationCubit(this._accountRepository) : super(const SubmitApplicationState()) {
  }

  final AccountRepository _accountRepository;

  void hideLoading() {
    updateState((state) => state.copyWith(isLoading: false));
  }

  void setEnabled(bool value) {
    updateState((state) => state.copyWith(isEnabled: value));
  }

  void setUsername(String value) {
    updateState((state) => state.copyWith(username: value));
  }

  void setEmail(String value) {
    updateState((state) => state.copyWith(email: value));
  }

  void setPhone(String value) {
    updateState((state) => state.copyWith(phone: value));
  }

  void setTheme(String value) {
    updateState((state) => state.copyWith(theme: value));
  }

  void setDescription(String value) {
    updateState((state) => state.copyWith(description: value));
  }

  Future<void> submitApplication() async {
    _accountRepository
        .getFeedback(fio: states.username, email: states.email, phone: states.phone, description: states.description)
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(isLoading: true));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(isLoading: false));
          emitEvent(SubmitApplicationEvent(SubmitApplicationEventType.onOpenBack));
        })
        .onError((error) {
          print("error register ${error.toString().contains("500")}");
          print("error register ${error.localizedMessage}");
        })
        .onFinished(() {})
        .executeFuture();
  }
}
