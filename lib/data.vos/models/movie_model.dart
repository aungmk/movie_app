import 'package:movie_app/data.vos/actor_vo.dart';
import 'package:movie_app/data.vos/credit_vo.dart';
import 'package:movie_app/data.vos/genre_vo.dart';
import 'package:movie_app/data.vos/movie_vo.dart';

abstract class MovieModel {
  //Network

  void getNowPlayingMovies(int page);
  void getPopularMovie(int page);
  void getTopRatedMovies(int page);

  Future<List<GenreVO>>? getGenres();
  Future<List<MovieVO>>? getMoviesByGenre(int genreId);
  Future<List<ActorVO>>? getActors(int page);
  Future<MovieVO>? getMovieDetails(int movieId);
  Future<List<CreditVO>>? getCreditsByMovie(int movieId);

  //Database
  Stream<List<MovieVO>>? getNowPlayingMoviesFromDatabase();
  Stream<List<MovieVO>>? getPopularMovieFromDatabase();
  Stream<List<MovieVO>>? getTopRatedMoviesFromDatabase();
  Future<List<GenreVO>>? getGenresFromDatabase();
  Future<List<ActorVO>>? getAllActorsFromDatabase();
  Future<MovieVO>? getMovieDetailsFromDatabase(int movieId);


}