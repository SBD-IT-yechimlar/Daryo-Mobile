import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/data/repositories/auth_repository.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import 'package:daryo/presentation/support/extensions/extension_message_exts.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/gen/localization/strings.dart';

part 'registration_cubit.freezed.dart';
part 'registration_state.dart';

@injectable
class RegistrationCubit extends BaseCubit<RegistrationState, RegistrationEvent> {
  RegistrationCubit(this._authRepository) : super(RegistrationState());

  final AuthRepository _authRepository;

  void setInitialParams(String phone) {
    updateState((state) => state.copyWith(
          phoneNumber: phone.replaceAll(' ', ''),
        ));
  }

  void setDocSeries(String docSeries) {
    updateState((state) => states.copyWith(docSeries: docSeries));
  }

  void setDocNumber(String docNumber) {
    updateState((state) => states.copyWith(
          docNumber: docNumber.replaceAll(" ", ""),
        ));
  }

  void setBrithDate(String brithDate) {
    updateState((state) => states.copyWith(brithDate: brithDate));
  }

  void setPassword(String password) {
    updateState((state) => state.copyWith(password: password));
  }

  void setFirstName(String fistName) {
    updateState((state) => state.copyWith(firstName: fistName));
  }

  void setLastName(String lastName) {
    updateState((state) => state.copyWith(lastName: lastName));
  }

  void setEmail(String email) {
    updateState((state) => state.copyWith(email: email));
  }

  void setConfirmPassword(String repeatPassword) {
    updateState((state) => state.copyWith(confirmPassword: repeatPassword));
  }

  Future<void> register() async {
    _authRepository
        .registration(states.email, states.password, states.phoneNumber, states.firstName + states.lastName)
        .initFuture()
        .onStart(() {
          // updateState((state) => state.copyWith(loading: true));
        })
        .onSuccess((data) {
          // updateState((state) => state.copyWith(loading: false));
          emitEvent(RegistrationEvent(RegistrationEventType.onOpenImagePage));
        })
        .onError((error) {
          print("error register ${error.toString().contains("500")}");
          print("error register ${error.localizedMessage}");
          // updateState((state) => state.copyWith(loading: false));
          if (error.toString().contains("-455")) {
            emitEvent(RegistrationEvent(RegistrationEventType.lostConnection, errorMessage: error.localizedMessage));
          }
          if (error.toString().contains("409")) {
            emitEvent(RegistrationEvent(RegistrationEventType.onRegisterFailed, errorMessage: Strings.usernameOrEmailExists));
          }
          if (error.toString().contains("500")) {
            emitEvent(RegistrationEvent(RegistrationEventType.onRegisterFailed, errorMessage: Strings.phoneNumberAlreadyRegistered));
          }
        })
        .onFinished(() {})
        .executeFuture();
  }
}
