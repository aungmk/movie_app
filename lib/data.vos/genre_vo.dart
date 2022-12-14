
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/persistence/hive_constants.dart';
part 'genre_vo.g.dart';
@HiveType(typeId: HIVE_TYPE_ID_GENRE_VO, adapterName: "GenreVOAdapter")
@JsonSerializable()
class GenreVO {
  @HiveField(0)
  @JsonKey(name: "id")
  int? id;
  @HiveField(1)
  @JsonKey(name: "name")
  String? name;

  GenreVO({this.id,this.name});

  factory GenreVO.fromJson(Map<String,dynamic> json) => _$GenreVOFromJson(json);

  Map<String,dynamic> toJson() => _$GenreVOToJson(this);

}