import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/persistence/hive_constants.dart';
part 'production_country_vo.g.dart';
@HiveType(typeId: HIVE_TYPE_ID_PRODUCTION_COUNTRY_VO, adapterName: "ProductionCountryVOAdapter")
@JsonSerializable()
class ProductionCountryVO {
  @HiveField(0)
  @JsonKey(name: "iso_3166_1")
  String? iso31661;
  @HiveField(1)
  @JsonKey(name: "name")
  String? name;

  ProductionCountryVO(this.iso31661, this.name);

  factory ProductionCountryVO.fromJson(Map<String,dynamic> json) => _$ProductionCountryVOFromJson(json);

  Map<String,dynamic> toJson() => _$ProductionCountryVOToJson(this);

}