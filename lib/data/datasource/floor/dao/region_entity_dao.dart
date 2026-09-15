import 'package:floor/floor.dart';
import 'package:daryo/data/datasource/floor/entities/region_entity.dart';

@dao
abstract class RegionEntityDao {
  @Query('SELECT * FROM regions ')
  Future<List<RegionEntity>> getRegions();

  @Query('SELECT COUNT(*) FROM regions ')
  Future<int?> getRegionCount();

  @Query('DELETE FROM regions ')
  Future<void> clear();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertRegion(RegionEntity region);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertRegions(List<RegionEntity> region);
}
