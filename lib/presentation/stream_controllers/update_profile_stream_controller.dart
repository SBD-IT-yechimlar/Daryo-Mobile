import 'dart:ffi';

import 'package:daryo/core/stream/base_stream_controller.dart';

class UpdateProfileStreamController extends BaseStreamController<bool> {
  UpdateProfileStreamController({super.isBroadcast = true});
}
