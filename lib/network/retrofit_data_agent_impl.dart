import 'package:dio/dio.dart';
import 'package:movie_app/data.vos/actor_vo.dart';
import 'package:movie_app/data.vos/credit_vo.dart';
import 'package:movie_app/data.vos/genre_vo.dart';
import 'package:movie_app/data.vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/network/movie_data_agent.dart';
import 'package:movie_app/network/the_movie_api.dart';

class RetrofitDataAgentImpl extends MovieDataAgent {
    TheMovieApi? mApi;
  /// second class level singleton create
  static final RetrofitDataAgentImpl _singleton = RetrofitDataAgentImpl._internal();

  /// third create factory constructor mean only remain object is return everytime.
  factory RetrofitDataAgentImpl(){
    return _singleton;
  }
  /// fist private constructor create using _name init process put in
  RetrofitDataAgentImpl._internal(){
    final dio= Dio();
    mApi = TheMovieApi(dio);
  }

  @override
  Future<List<MovieVO>>? getNowPlayingMovies(int page) {
    return mApi?.getNowPlayingMovie(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results??[])
        .first;
  }

  @override
  Future<List<MovieVO>>? getPopularMovie(int page) {
    return mApi?.getPopularMovie(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results??[])
        .first;
  }

  @override
  Future<List<MovieVO>>? getTopRatedMovies(int page){
    return mApi?.getTopRatedMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results??[])
        .first;
  }

  @override
  Future<List<GenreVO>>? getGenres(){
    return mApi?.getGenres(API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.genres??[])
        .first;
  }

  @override
  Future<List<MovieVO>>? getMoviesByGenre(int genreId){
    return mApi?.getMoviesByGenre(genreId.toString(),API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.results??[])
        .first;
  }

  @override
  Future<List<ActorVO>>? getActors(int page){
    return mApi?.getActors(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results??[])
        .first;
  }
  @override
  Future<MovieVO>? getMovieDetails(int movieId){
    return mApi?.getMovieDetails(movieId.toString(),API_KEY, LANGUAGE_EN_US, 1.toString());

  }
  @override
  Future<List<CreditVO>>? getCreditsByMovie(int movieId){
    return mApi?.getCreditsByMovieResponse(movieId.toString(),API_KEY, LANGUAGE_EN_US, 1.toString())
        .asStream()
        .map((response) => response.cast??[])
        .first;
  }

}
