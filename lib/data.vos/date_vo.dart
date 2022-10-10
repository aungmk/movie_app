
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/persistence/hive_constants.dart';

part 'date_vo.g.dart';
@HiveType(typeId: HIVE_TYPE_ID_DATE_VO, adapterName: "DateVOAdapter")
@JsonSerializable()
class DateVO{
  @HiveField(0)
  @JsonKey(name: "maximum")
  String? maximum;
  @HiveField(1)
  @JsonKey(name: "minimum")
  String? minimum;

  DateVO({this.maximum,this.minimum});

  factory DateVO.fromJson(Map<String,dynamic> json) =>
      _$DateVOFromJson(json);

  Map<String,dynamic> toJson() => _$DateVOToJson(this);

}