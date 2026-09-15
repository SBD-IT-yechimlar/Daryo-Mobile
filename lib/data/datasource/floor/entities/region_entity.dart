import 'package:floor/floor.dart';

@Entity(tableName: "regions")
class RegionEntity {

  @primaryKey
  @ColumnInfo(name: "region_id")
  int id;

  @ColumnInfo(name: "region_name")
  String name;

  RegionEntity({
    required this.id,
    required this.name,
  });
}
