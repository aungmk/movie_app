import 'package:movie_app/data.vos/actor_vo.dart';
import 'package:movie_app/data.vos/credit_vo.dart';
import 'package:movie_app/data.vos/genre_vo.dart';
import 'package:movie_app/data.vos/movie_vo.dart';
import 'package:scoped_model/scoped_model.dart';

abstract class MovieModel extends Model {
  //Network

  void getNowPlayingMovies(int page);
  void getPopularMovie(int page);
  void getTopRatedMovies(int page);

  void getGenres();
  void getMoviesByGenre(int genreId);
  void getActors(int page);
  Future<MovieVO>? getMovieDetails(int movieId);
  Future<List<CreditVO>>? getCreditsByMovie(int movieId);

  //Database
  void getNowPlayingMoviesFromDatabase();
  void getPopularMovieFromDatabase();
  void getTopRatedMoviesFromDatabase();
  void getGenresFromDatabase();
  void getAllActorsFromDatabase();
  Future<MovieVO>? getMovieDetailsFromDatabase(int movieId);


}