import 'package:daryo/core/stream/base_stream_controller.dart';
import 'package:daryo/domain/models/logout_event/logout_event_type.dart';

class LogoutEventStreamController extends BaseStreamController<LogoutEvent> {
  LogoutEventStreamController({super.isBroadcast = true});
}
