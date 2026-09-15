import 'package:floor/floor.dart';

@Entity(tableName: "districts")
class DistrictEntity {

  @primaryKey
  @ColumnInfo(name: "district_id")
  int id;

  @ColumnInfo(name: "district_name")
  String name;

  @ColumnInfo(name: "district_region_id")
  int regId;

  DistrictEntity({
    required this.id,
    required this.name,
    required this.regId,
  });
}
