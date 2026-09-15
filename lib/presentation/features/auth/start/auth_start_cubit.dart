import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/data/repositories/auth_repository.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import 'package:daryo/presentation/support/extensions/extension_message_exts.dart';

import '../../../../domain/models/language/language.dart';
import '../../../stream_controllers/language_selection_stream_controller.dart';

part 'auth_start_cubit.freezed.dart';

part 'auth_start_state.dart';

@injectable
class AuthStartCubit extends BaseCubit<AuthStartState, AuthStartEvent> {
  final AuthRepository _authRepository;
  final LanguageSelectionStreamController _languageSelectionStreamController;

  AuthStartCubit(this._authRepository, this._languageSelectionStreamController) : super(AuthStartState());

  void setEmail(String email) {
    updateState((state) => states.copyWith(email: email));
  }

  void setPassword(String password) {
    updateState((state) => states.copyWith(password: password));
  }

  Future<void> login() async {
    _authRepository
        .login(states.email, states.password)
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(loading: true));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(loading: false));
          emitEvent(AuthStartEvent(AuthStartEventType.onOpenHome));
        })
        .onError((error) {
          updateState((state) => state.copyWith(loading: false));
          if (error.toString().contains("-455")) {
            emitEvent(AuthStartEvent(AuthStartEventType.lostConnection,
                errorMessage: error.localizedMessage));
          } else {
            emitEvent(AuthStartEvent(AuthStartEventType.onEdsLoginFailed));
          }
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> loginWithGoogle() async {
    final token= await getIdTokenFromSelectedAccount()??"";
    if(token=="") {
      return;
    }
    _authRepository
        .loginWithGoogle(token)
        .initFuture()
        .onStart(() {
    })
        .onSuccess((data) {
      emitEvent(AuthStartEvent(AuthStartEventType.onOpenHome));
    }).onError((error) {
      emitEvent(AuthStartEvent(AuthStartEventType.googleFailed,
          errorMessage: error.localizedMessage));
    })
        .onFinished(() {})
        .executeFuture();
  }

  Future<String?> getIdTokenFromSelectedAccount() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );

      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account == null) {
        return null;
      }

      final GoogleSignInAuthentication auth = await account.authentication;
      logger.w("token ${auth.idToken}");
      return auth.idToken;
    } catch (e) {

      return null;
    }
  }

  void updateLanguage(Language language){
    _languageSelectionStreamController.add(language);
  }

}
