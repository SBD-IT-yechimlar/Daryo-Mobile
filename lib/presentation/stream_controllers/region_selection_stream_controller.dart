import 'package:daryo/core/stream/base_stream_controller.dart';
import 'package:daryo/domain/models/region/set_region_event.dart';

class RegionSelectionStreamController
    extends BaseStreamController<SetRegionResult> {
  RegionSelectionStreamController({super.isBroadcast = true});
}
