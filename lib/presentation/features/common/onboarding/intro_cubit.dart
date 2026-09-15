import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/data/repositories/auth_repository.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';

import '../../../../core/enum/enums.dart';
import '../../../../data/datasource/network/dto_daryo/banners/banners_response.dart';

part 'intro_cubit.freezed.dart';
part 'intro_state.dart';

@injectable
class IntroCubit extends BaseCubit<IntroState, IntroEvent> {
  final AuthRepository _authRepository;

  IntroCubit(this._authRepository) : super(IntroState()){
    banners();
  }

  Future<void> banners() async {
    _authRepository
        .banners()
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(introState: LoadingState.loading));
        })
        .onSuccess((data) {

        updateState((state) => state.copyWith(introData: data, introState: LoadingState.success));
        if(data.length>1);
        updateState((state) => state.copyWith(length: data.length));
        })

        .onError((error) {
       updateState((state) => state.copyWith(introState: LoadingState.error));

        })
        .onFinished(() {})
        .executeFuture();
  }

  void setIndex(int index){
    updateState((state) => state.copyWith(index: index));
  }


}
