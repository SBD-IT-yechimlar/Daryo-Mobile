import 'package:daryo/core/stream/base_stream_controller.dart';

import '../../domain/models_daryo/category/category.dart';

class CategorySelectionStreamController extends BaseStreamController<MapEntry<String, Category>> {
  CategorySelectionStreamController({super.isBroadcast = true});
}
