import 'package:daryo/data/datasource/floor/dao/category_entity_dao.dart';
import 'package:daryo/data/datasource/floor/dao/district_entity_dao.dart';
import 'package:daryo/data/datasource/floor/dao/region_entity_dao.dart';
import 'package:daryo/data/datasource/floor/dao/user_address_entity_dao.dart';
import 'package:daryo/data/datasource/preference/language_preferences.dart';
import 'package:daryo/domain/models/language/language.dart';

class LanguageRepository {
  final CategoryEntityDao _categoryEntityDao;
  final DistrictEntityDao _districtEntityDao;
  final LanguagePreferences _languagePreferences;
  final RegionEntityDao _regionEntityDao;
  final UserAddressEntityDao _userAddressEntityDao;

  LanguageRepository(
    this._categoryEntityDao,
    this._districtEntityDao,
    this._languagePreferences,
    this._regionEntityDao,
    this._userAddressEntityDao,
  );

  Language getLanguage() {
    return _languagePreferences.language;
  }

  bool isLanguageSelected() {
    return _languagePreferences.isLanguageSelected;
  }

  Future<void> setLanguage(Language language) async {
    await _categoryEntityDao.clear();
    await _userAddressEntityDao.clear();
    await _regionEntityDao.clear();
    await _districtEntityDao.clear();

    return _languagePreferences.setLanguage(language);
  }
}
