import 'package:daryo/domain/models_daryo/specialist/specialist.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';

import '../../../../../../../data/repositories/daryo_information_repository.dart';
import '../../../../../../../domain/models_daryo/face_behind/face_behind.dart';
import '../../../../../../../data/repositories/auth_repository.dart';

part 'about_editorial_team_cubit.freezed.dart';

part 'about_editorial_team_state.dart';

@Injectable()
class AboutEditorialTeamCubit
    extends BaseCubit<AboutEditorialTeamState, AboutEditorialTeamEvent> {
  final DaryoInformationRepository _daryoInformationRepository;

  AboutEditorialTeamCubit(
      this._daryoInformationRepository, this._authRepository)
      : super(const AboutEditorialTeamState()) {
    _getInitialData();
  }

  Future<void> getSpecialists() async {
    final specialists = _daryoInformationRepository
        .getSpecialists(limit: 10, page: 0)
        .initFuture()
        .onStart(() {
          updateState((state) =>
              state.copyWith(specialistsState: LoadingState.loading));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(
              specialists: data,
              specialistsState: LoadingState.success,
              first: data.first,
              second: data[1],
          ));
        })
        .onError((error) {
          updateState(
              (state) => state.copyWith(specialistsState: LoadingState.error));
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getFaceBehinds() async {
    final faceBehinds = _daryoInformationRepository
        .getFaceBehinds(limit: 10, page: 0)
        .initFuture()
        .onStart(() {
          updateState((state) =>
              state.copyWith(faceBehindsState: LoadingState.loading));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(
              faceBehinds: data, faceBehindsState: LoadingState.success));
        })
        .onError((error) {
          updateState(
              (state) => state.copyWith(faceBehindsState: LoadingState.error));
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> _getInitialData() async {
    await Future.wait([
      getSpecialists(),
      getFaceBehinds(),
    ]);
  }

  Future<void> reload() async {
    await Future.wait([
      getSpecialists(),
      getFaceBehinds(),
    ]);
  }

  final AuthRepository _authRepository;
}
