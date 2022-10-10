import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data.vos/collection_vo.dart';
import 'package:movie_app/data.vos/genre_vo.dart';
import 'package:movie_app/data.vos/production_company_vo.dart';
import 'package:movie_app/data.vos/production_country_vo.dart';
import 'package:movie_app/data.vos/spoken_language_vo.dart';
import 'package:movie_app/persistence/hive_constants.dart';

part 'movie_vo.g.dart';
@HiveType(typeId: HIVE_TYPE_ID_MOVIE_VO, adapterName: "MovieVOAdapter")
@JsonSerializable()
class MovieVO {
  @HiveField(0)
  @JsonKey(name:"adult")
   bool? adult;
  @HiveField(1)
  @JsonKey(name:"backdrop_path")
   String? backDropPath;
  @HiveField(2)
  @JsonKey(name:"genre_ids")
   List<int>? genreIds;
  @HiveField(3)
  @JsonKey(name: "belongs_to_collection")
  CollectionVO? belongsToCollection;
  @HiveField(4)
  @JsonKey(name: "budget")
  double? budget;
  @HiveField(5)
  @JsonKey(name: "genres")
  List<GenreVO>? genres;
  @HiveField(6)
  @JsonKey(name: "homepage")
  String? homePage;
  @HiveField(7)
  @JsonKey(name:"id")
   int? id;
  @HiveField(8)
  @JsonKey(name: "imdb_id")
  String? imdbId;
  @HiveField(9)
  @JsonKey(name:"original_language")
   String? originalLanguage;
  @HiveField(10)
  @JsonKey(name:"original_title")
   String? originalTitle;
  @HiveField(11)
  @JsonKey(name:"overview")
   String? overview;
  @HiveField(12)
  @JsonKey(name:"popularity")
   double? popularity;
  @HiveField(13)
  @JsonKey(name:"poster_path")
   String? posterPath;
  @HiveField(14)
  @JsonKey(name: "production_companies")
  List<ProductionCompanyVO>? productionCompanies;
  @HiveField(15)
  @JsonKey(name: "production_countries")
  List<ProductionCountryVO>? productionCountries;
  @HiveField(16)
  @JsonKey(name: "revenue")
  int? revenue;
  @HiveField(17)
  @JsonKey(name: "runtime")
  int? runTime;
  @HiveField(18)
  @JsonKey(name:"release_date")
   String? releaseDate;
  @HiveField(19)
  @JsonKey(name: "spoken_languages")
  List<SpokenLanguageVO>? spokenLanguages;
  @HiveField(20)
  @JsonKey(name: "Status")
  String? status;
  @HiveField(21)
  @JsonKey(name: "tagline")
  String? tagLine;
  @HiveField(22)
  @JsonKey(name:"title")
   String? title;
  @HiveField(23)
  @JsonKey(name:"video")
   bool? video;
  @HiveField(24)
  @JsonKey(name:"vote_average")
   double? voteAverage;
  @HiveField(25)
  @JsonKey(name:"vote_count")
   int? voteCount;


  MovieVO(
      this.adult,
      this.backDropPath,
      this.genreIds,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homePage,
      this.id,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.revenue,
      this.runTime,
      this.releaseDate,
      this.spokenLanguages,
      this.status,
      this.tagLine,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount);

  factory MovieVO.fromJson(Map<String,dynamic> json) => _$MovieVOFromJson(json);

  Map<String,dynamic> toJson() => _$MovieVOToJson(this);

  @override
  String toString() {
    return 'MovieVO{adult: $adult, backDropPath: $backDropPath, genreIds: $genreIds, id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount}';
  }
}


