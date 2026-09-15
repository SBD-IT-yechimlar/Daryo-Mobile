import 'dart:async';

import 'package:daryo/data/repositories/language_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';

part 'splash_cubit.freezed.dart';
part 'splash_state.dart';

@injectable
class SplashCubit extends BaseCubit<SplashState, SplashEvent> {
  SplashCubit(this._languageRepository) : super(const SplashState()){
    startTimer();
  }

  final LanguageRepository _languageRepository;


  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 400), (timer) {
      if (states.timerTime > 0) {
        updateState((state) => state.copyWith(
          timerTime: state.timerTime - 1,
        ));
      } else {
        stopTimer();
        final selectedLanguage=_languageRepository.isLanguageSelected();
        if(selectedLanguage){
          emitEvent(SplashEvent(
            SplashEventType.onOpenHome,
          ));
        }else{
          emitEvent(SplashEvent(
            SplashEventType.navigateSetLanguage,
          ));
        }
      }
    });
  }

  void stopTimer() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
  }


}
