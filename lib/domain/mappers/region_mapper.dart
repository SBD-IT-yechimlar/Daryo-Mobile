import 'package:daryo/data/datasource/floor/entities/district_entity.dart';
import 'package:daryo/data/datasource/floor/entities/region_entity.dart';
import 'package:daryo/data/datasource/network/dto/region/district_response.dart';
import 'package:daryo/data/datasource/network/dto/region/region_and_district_response.dart';
import 'package:daryo/data/datasource/network/dto/region/region_response.dart';
import 'package:daryo/domain/models/district/district.dart';
import 'package:daryo/domain/models/list/expandable_list_item.dart';
import 'package:daryo/domain/models/region/region.dart';
import 'package:daryo/domain/models/region/region_and_district.dart';
import 'package:daryo/domain/models/street/street.dart';

extension RegionResponseExts on RegionResponse {
  Region toRegion() {
    return Region(id: id, name: name);
  }

  District toDistrict(int regionId) {
    return District(id: id, name: name, regionId: id);
  }

  Neighborhood toNeighborhood() {
    return Neighborhood(id: id, name: name);
  }

  RegionEntity toRegionEntity() {
    return RegionEntity(id: id, name: name);
  }
}

extension RegionEntityExts on RegionEntity {
  Region toRegion() {
    return Region(id: id, name: name);
  }
}

extension DistrictResponseExts on DistrictResponse {
  District toDistrict() {
    return District(id: id, name: name, regionId: reg_id);
  }

  DistrictEntity toDistrictEntity() {
    return DistrictEntity(id: id, name: name, regId: reg_id);
  }
}

extension DistrictEntityExts on DistrictEntity {
  District toDistrict() {
    return District(id: id, name: name, regionId: regId);
  }
}

extension RegionItemExts on ExpandableListItem {
  District toDistrict() {
    return District(
      id: id,
      regionId: parentId,
      name: name,
    );
  }
}

extension RegionAndDistrictExts on RegionAndDistrictResponse {
  RegionAndDistrict toRegionAndDistrict() {
    return RegionAndDistrict(
      regions: regions.map((e) => e.toRegion()).toList(),
      districts: districts.map((e) => e.toDistrict()).toList(),
    );
  }
}
