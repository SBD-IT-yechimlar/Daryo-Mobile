import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/core/handler/future_handler.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';

import '../../../../../../../../../data/repositories/auth_repository.dart';

part 'team_member_info_cubit.freezed.dart';
part 'team_member_info_state.dart';

@Injectable()
class TeamMemberInfoCubit
    extends BaseCubit<TeamMemberInfoState, TeamMemberInfoEvent> {TeamMemberInfoCubit(this._authRepository)
      : super(const TeamMemberInfoState()) {}

  final AuthRepository _authRepository;


}
