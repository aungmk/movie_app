import 'dart:async';

import 'package:movie_app/data.vos/actor_vo.dart';
import 'package:movie_app/data.vos/genre_vo.dart';
import 'package:movie_app/data.vos/models/movie_model.dart';
import 'package:movie_app/data.vos/models/movie_model_impl.dart';
import 'package:movie_app/data.vos/movie_vo.dart';

class HomeBloc{
  ///Reactive Streams
  StreamController<List<MovieVO>>? mNowPlayingStreamController=
    StreamController();
  StreamController<List<MovieVO>>? mPopularMoviesListStreamController=
    StreamController();
  StreamController<List<GenreVO>>? mGenreListStreamController=
    StreamController();
  StreamController<List<ActorVO>>? mActorsStreamController=
    StreamController();
  StreamController<List<MovieVO>>? mShowCaseMovieListStreamController=
    StreamController();
  StreamController<List<MovieVO>>? mMoviesByGenreListStreamController=
    StreamController();

  ///Models
  MovieModel mMovieModel = MovieModelImpl();

  HomeBloc() {
    /// Now Playing Movies Database
    mMovieModel.getNowPlayingMoviesFromDatabase()?.then((movieList){
      mNowPlayingStreamController?.sink.add(movieList);
    }).catchError((error) {});

    /// Popular Movies Database
    mMovieModel.getPopularMovieFromDatabase()?.then((movieList){
      mPopularMoviesListStreamController?.sink.add(movieList);
    }).catchError((error) {});

    /// Genres
    mMovieModel.getGenres()?.then((genreList){
      mGenreListStreamController?.sink.add(genreList);

      ///Movies by Genre
      getMoviesByGenreAndRefresh(genreList.first.id ?? 0);
    }).catchError((error) {});

    ///Genres Database
    mMovieModel.getGenresFromDatabase()?.then((genreList){
      mGenreListStreamController?.sink.add(genreList);

      ///Movies by Genre
      getMoviesByGenreAndRefresh(genreList.first.id ?? 0);
    }).catchError((error) {});

    /// showcase database
    mMovieModel.getTopRatedMoviesFromDatabase()?.then((movieList){
      mShowCaseMovieListStreamController?.sink.add(movieList);
    }).catchError((error) {});

    ///Actors
    mMovieModel.getActors(1)?.then((actorList){
      mActorsStreamController?.sink.add(actorList);
    }).catchError((error) {});

    ///Actors database
    mMovieModel.getAllActorsFromDatabase()?.then((actorList){
      mActorsStreamController?.sink.add(actorList);
    }).catchError((error) {});
  }

  void onTapGenre(int genreId){
    getMoviesByGenreAndRefresh(genreId);
  }

  void getMoviesByGenreAndRefresh (int genreId){
    mMovieModel.getMoviesByGenre(genreId)?.then((moviesByGenre){
      mMoviesByGenreListStreamController?.sink.add(moviesByGenre);
    }).catchError((error) {});
  }

  void dispose(){
    mNowPlayingStreamController?.close();
    mPopularMoviesListStreamController?.close();
    mGenreListStreamController?.close();
    mActorsStreamController?.close();
    mShowCaseMovieListStreamController?.close();
    mMoviesByGenreListStreamController?.close();
  }
}