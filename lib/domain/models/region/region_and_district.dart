import 'package:daryo/domain/models/district/district.dart';
import 'package:daryo/domain/models/region/region.dart';

class RegionAndDistrict {
  RegionAndDistrict({
    required this.regions,
    required this.districts,
  });

  List<Region> regions;
  List<District> districts;
}
