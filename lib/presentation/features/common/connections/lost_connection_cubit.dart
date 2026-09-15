import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:daryo/core/enum/enums.dart';
import 'package:daryo/presentation/support/cubit/base_cubit.dart';
import '../../../support/connection/connectivity_provider.dart';

part 'lost_connection_cubit.freezed.dart';

part 'lost_connection_state.dart';

@Injectable()
class LostConnectionCubit
    extends BaseCubit<LostConnectionState, LostConnectionEvent> {
  LostConnectionCubit(this._connectivityService)
      : super(const LostConnectionState()) {}

  final ConnectivityService _connectivityService;

  Future checkInternetConnection() async {
    final connected = await _connectivityService.hasInternetConnection();
    if (connected == false) {
      emitEvent(LostConnectionEvent(LostConnectionEventType.lostConnection));
    } else {
      emitEvent(LostConnectionEvent(LostConnectionEventType.connected));
    }
  }
}
