
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data.vos/base_actor_vo.dart';
import 'package:movie_app/data.vos/movie_vo.dart';

import '../persistence/hive_constants.dart';

part 'actor_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_ACTOR_VO, adapterName: "ActorVOAdapter")
class ActorVO extends BaseActorVO{
  //@JsonKey(name: "profile_path")
  //String? profilePath;
  @HiveField(0)
  @JsonKey(name: "adult")
  bool? adult;

  @HiveField(1)
  @JsonKey(name: "id")
  int? id;

  @HiveField(2)
  @JsonKey(name: "known_for")
  List<MovieVO>? knownFor;
  //@JsonKey(name: "name")
  //String? name;

  @HiveField(3)
  @JsonKey(name: "popularity")
  double? popularity;

  ActorVO({
      this.adult,
      this.id,
      this.knownFor,
      this.popularity,
    String? name,
    String? profilePath})
  : super(name ??'',profilePath ??'');

  factory ActorVO.fromJson(Map<String,dynamic> json) => _$ActorVOFromJson(json);

  Map<String,dynamic> toJson() => _$ActorVOToJson(this);
}