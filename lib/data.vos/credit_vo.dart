
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data.vos/base_actor_vo.dart';
import 'package:movie_app/persistence/hive_constants.dart';
part 'credit_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CREDIT_VO, adapterName: "CreditVOAdapter")
class CreditVO extends BaseActorVO{

  @HiveField(0)
  @JsonKey(name: "adult")
  bool? adult;

  @HiveField(1)
  @JsonKey(name: "gender")
  int? gender;

  @HiveField(2)
  @JsonKey(name: "id")
  int? id;

  @HiveField(3)
  @JsonKey(name: "known_for_department")
  String? knowForDepartment;
  //@JsonKey(name: "name")
  //String? name;

  @HiveField(4)
  @JsonKey(name: "original_name")
  String? originalName;

  @HiveField(5)
  @JsonKey(name: "popularity")
  double? popularity;
  //@JsonKey(name: "profile_path")
  //String? profilePath;

  @HiveField(6)
  @JsonKey(name: "cast_id")
  int? castId;

  @HiveField(7)
  @JsonKey(name: "character")
  String? character;

  @HiveField(8)
  @JsonKey(name: "credit_id")
  String? creditId;

  @HiveField(9)
  @JsonKey(name: "order")
  int? order;

  CreditVO(
      this.adult,
      this.gender,
      this.id,
      this.knowForDepartment,
      this.originalName,
      this.popularity,
      this.castId,
      this.character,
      this.creditId,
      this.order,
      String name,
      String profilePath,
      ) :super (name,profilePath);

  factory CreditVO.fromJson(Map<String,dynamic> json) =>
      _$CreditVOFromJson(json);

  Map<String,dynamic> toJson() => _$CreditVOToJson(this);

  bool isActor(){
    return knowForDepartment == KNOW_FOR_DEPARTMENT_ACTING;
  }

  bool isCreator(){
    return knowForDepartment != KNOW_FOR_DEPARTMENT_ACTING;
  }

}

const String KNOW_FOR_DEPARTMENT_ACTING="Acting";