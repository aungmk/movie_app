// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActorVO _$ActorVOFromJson(Map<String, dynamic> json) => ActorVO(
      adult: json['adult'] as bool?,
      id: json['id'] as int?,
      knownFor: (json['known_for'] as List<dynamic>?)
          ?.map((e) => MovieVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      popularity: (json['popularity'] as num?)?.toDouble(),
      name: json['name'] as String?,
      profilePath: json['profile_path'] as String?,
    );

Map<String, dynamic> _$ActorVOToJson(ActorVO instance) => <String, dynamic>{
      'name': instance.name,
      'profile_path': instance.profilePath,
      'adult': instance.adult,
      'id': instance.id,
      'known_for': instance.knownFor,
      'popularity': instance.popularity,
    };
