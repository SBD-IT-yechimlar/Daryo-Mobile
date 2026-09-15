import 'package:injectable/injectable.dart';
import 'package:daryo/data/datasource/preference/preferences_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegionPreferences {
  final SharedPreferences _preferences;

  RegionPreferences(this._preferences);

  static const String _keyRegionId = 'selected_region_id';
  static const String _keyRegionName = 'selected_region_name';
  static const String _keyDistrictId = 'selected_district_id';
  static const String _keyDistrictName = 'selected_district_name';

  @factoryMethod
  static Future<RegionPreferences> create() async {
    final prefs = await SharedPreferences.getInstance();
    return RegionPreferences(prefs);
  }

  int? get regionId {
    try {
      return _preferences.getInt(_keyRegionId);
    } catch (e) {
      return null;
    }
  }

  String? get regionName {
    try {
      return _preferences.getString(_keyRegionName);
    } catch (e) {
      return null;
    }
  }

  int? get districtId {
    try {
      return _preferences.getInt(_keyDistrictId);
    } catch (e) {
      return null;
    }
  }

  String? get districtName {
    try {
      return _preferences.getString(_keyDistrictName);
    } catch (e) {
      return null;
    }
  }

  bool get showDefaultRegionPage => !isRegionSelected;

  bool get isRegionSelected => regionId != null && districtId != null;

  String? get selectedRegionName =>
      isRegionSelected ? "$regionName, $districtName" : null;

  Future<void> setSelectedRegion({
    required int regionId,
    required String regionName,
    required int districtId,
    required String districtName,
  }) async {
    await _preferences.setOrRemove(_keyRegionId, regionId);
    await _preferences.setOrRemove(_keyRegionName, regionName);
    await _preferences.setOrRemove(_keyDistrictId, districtId);
    await _preferences.setOrRemove(_keyDistrictName, districtName);
  }

  Future<void> updateSelectedRegionNames({
    required String regionName,
    required String districtName,
  }) async {
    await _preferences.setOrRemove(_keyRegionName, regionName);
    await _preferences.setOrRemove(_keyDistrictName, districtName);
  }

  Future<void> clear() async {
    await _preferences.remove(_keyRegionId);
    await _preferences.remove(_keyRegionName);
    await _preferences.remove(_keyDistrictId);
    await _preferences.remove(_keyDistrictName);
  }
}
