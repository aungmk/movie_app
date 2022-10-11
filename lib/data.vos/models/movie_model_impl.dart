import 'package:flutter/material.dart';
import 'package:movie_app/data.vos/actor_vo.dart';
import 'package:movie_app/data.vos/credit_vo.dart';
import 'package:movie_app/data.vos/genre_vo.dart';
import 'package:movie_app/data.vos/movie_vo.dart';
import 'package:movie_app/network/movie_data_agent.dart';
import 'package:movie_app/network/retrofit_data_agent_impl.dart';
import 'package:movie_app/persistence/daos/actor_daos.dart';
import 'package:movie_app/persistence/daos/genre_daos.dart';
import 'package:movie_app/persistence/daos/movie_daos.dart';

import 'movie_model.dart';

class MovieModelImpl extends MovieModel{

  MovieDataAgent mDataAgent= RetrofitDataAgentImpl();

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  /// third create factory constructor mean only remain object is return everytime.
  factory MovieModelImpl(){
    return _singleton;
  }
  /// fist private constructor create using _name init process put in
  MovieModelImpl._internal();

  ///daos
  MovieDao mMovieDao=MovieDao();
  GenreDao mGenreDao=GenreDao();
  ActorDao mActorDao=ActorDao();


  //Network
  @override
  Future<List<MovieVO>>? getNowPlayingMovies(int page){
    return mDataAgent.getNowPlayingMovies(page)?.then((movies) async {
      List<MovieVO> nowPlayingMovies = movies.map((movie){
        movie.isNowPlaying=true;
        movie.isPopular=false;
        movie.isTopRated=false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(nowPlayingMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<MovieVO>>? getPopularMovie(int page){
    return mDataAgent.getPopularMovie(page)?.then((movies) async {
      List<MovieVO> popularMovies = movies.map((movie){
        movie.isNowPlaying=false;
        movie.isPopular=true;
        movie.isTopRated=false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(popularMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<MovieVO>>? getTopRatedMovies(int page){
    return mDataAgent.getTopRatedMovies(page)?.then((movies) async {
      List<MovieVO> topRatedMovies = movies.map((movie){
        movie.isNowPlaying=false;
        movie.isPopular=false;
        movie.isTopRated=true;
        return movie;
      }).toList();
      mMovieDao.saveMovies(topRatedMovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<GenreVO>>? getGenres(){
    return mDataAgent.getGenres()?.then((genres) async {
      mGenreDao.saveAllGenre(genres);
      return Future.value(genres);
    });
  }

  @override
  Future<List<MovieVO>>? getMoviesByGenre(int genreId){
    return mDataAgent.getMoviesByGenre(genreId);
  }

  @override
  Future<List<ActorVO>>? getActors(int page){
    return mDataAgent.getActors(page)?.then((actor) async {
      mActorDao.saveAllActors(actor);
      return Future.value(actor);
    });
  }

  @override
  Future<List<CreditVO>>? getCreditsByMovie(int movieId) {
    return mDataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<MovieVO>? getMovieDetails(int movieId) {
    return mDataAgent.getMovieDetails(movieId)?.then((movie) async {
      mMovieDao.saveSingleMovie(movie);
      return Future.value(movie);
    });
  }

  //Database

  @override
  Future<List<ActorVO>>? getAllActorsFromDatabase() {
    return Future.value(mActorDao.getAllActors());

  }

  @override
  Future<List<GenreVO>>? getGenresFromDatabase() {
    return Future<List<GenreVO>>.value(mGenreDao.getAllGenres());
  }

  @override
  Future<MovieVO>? getMovieDetailsFromDatabase(int movieId) {
    return Future.value(mMovieDao.getMovieById(movieId));
  }

  @override
  Future<List<MovieVO>>? getNowPlayingMoviesFromDatabase() {
    return Future.value(mMovieDao
        .getAllMovies()
        .where((movie) => movie.isNowPlaying ?? true)
        .toList());
  }

  @override
  Future<List<MovieVO>>? getPopularMovieFromDatabase() {
    return Future.value(mMovieDao
        .getAllMovies()
        .where((movie) => movie.isPopular ?? true)
        .toList());
  }

  @override
  Future<List<MovieVO>>? getTopRatedMoviesFromDatabase() {
    return Future.value(mMovieDao
        .getAllMovies()
        .where((movie) => movie.isTopRated ?? true)
        .toList());
  }

}