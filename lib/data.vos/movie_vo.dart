import 'package:json_annotation/json_annotation.dart';

part 'movie_vo.g.dart';

@JsonSerializable()
class MovieVO {
  @JsonKey(name:"adult")
  late bool adult;

  @JsonKey(name:"backdrop_path")
  late String backDropPath;

  @JsonKey(name:"genre_ids")
  late List<int> genreIds;

  @JsonKey(name:"id")
  late int id;

  @JsonKey(name:"original_language")
  late String originalLanguage;

  @JsonKey(name:"original_title")
  late String originalTitle;

  @JsonKey(name:"overview")
  late String overview;

  @JsonKey(name:"popularity")
  late double popularity;

  @JsonKey(name:"poster_path")
  late String posterPath;

  @JsonKey(name:"release_date")
  late String releaseDate;

  @JsonKey(name:"title")
  late String title;

  @JsonKey(name:"video")
  late bool video;

  @JsonKey(name:"vote_average")
  late double voteAverage;

  @JsonKey(name:"vote_count")
  late int voteCount;

  MovieVO(
      this.adult,
      this.backDropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount);

  factory MovieVO.fromJson(Map<String,dynamic> json) => _$MovieVOFromJson(json);

  Map<String,dynamic> toJson() => _$MovieVOToJson(this);
}

