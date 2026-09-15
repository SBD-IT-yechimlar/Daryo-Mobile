import 'package:floor/floor.dart';
import 'package:daryo/data/datasource/floor/entities/district_entity.dart';

@dao
abstract class DistrictEntityDao {
  @Query('SELECT * FROM districts ')
  Future<List<DistrictEntity>> getDistricts();

  @Query('SELECT COUNT(*) FROM districts ')
  Future<int?> getDistrictCount();

  @Query('DELETE FROM districts ')
  Future<void> clear();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertDistrict(DistrictEntity district);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDistricts(List<DistrictEntity> district);
}
