import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/persistence/hive_constants.dart';

part 'spoken_language_vo.g.dart';
@HiveType(typeId: HIVE_TYPE_ID_SPOKEN_LANGUAGE_VO, adapterName: "SpokenLanguageVOAdapter")
@JsonSerializable()
class SpokenLanguageVO {
  @HiveField(0)
  @JsonKey(name: "english_name")
  String? englishName;
  @HiveField(1)
  @JsonKey(name: "iso_639_1")
  String? iso6391;
  @HiveField(2)
  @JsonKey(name: "name")
  String? name;


  SpokenLanguageVO(this.englishName, this.iso6391, this.name);

  factory SpokenLanguageVO.fromJson(Map<String,dynamic> json) => _$SpokenLanguageVOFromJson(json);

  Map<String,dynamic> toJson() => _$SpokenLanguageVOToJson(this);

}