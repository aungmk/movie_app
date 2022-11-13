import 'package:flutter/foundation.dart';
import 'package:movie_app/data.vos/actor_vo.dart';
import 'package:movie_app/data.vos/genre_vo.dart';
import 'package:movie_app/data.vos/models/movie_model.dart';
import 'package:movie_app/data.vos/models/movie_model_impl.dart';
import 'package:movie_app/data.vos/movie_vo.dart';

class HomeBloc extends ChangeNotifier{
  ///State
  List<MovieVO>? mNowPlayingMovieList;
  List<MovieVO>? mPopularMovieList;
  List<GenreVO>? mGenreList;
  List<ActorVO>? mActors;
  List<MovieVO>? mShowCaseMovieList;
  List<MovieVO>? mMoviesByGenreList;

  ///Page
  int pageForNowPlayingMovie=1;


  ///Models
  MovieModel mMovieModel = MovieModelImpl();

  HomeBloc() {
    /// Now Playing Movies Database
    mMovieModel.getNowPlayingMoviesFromDatabase()?.listen((movieList){
      mNowPlayingMovieList=movieList;
      mNowPlayingMovieList?.sort((a, b) => a.id!- (b.id ??0));
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString()) ;
    });

    /// Popular Movies Database
    mMovieModel.getPopularMovieFromDatabase()?.listen((movieList){
      mPopularMovieList=movieList;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString()) ;
    });

    /// Genres
    mMovieModel.getGenres()?.then((genreList){
      mGenreList=genreList;

      ///Movies by Genre
      _getMoviesByGenreAndRefresh(genreList.first.id ?? 0);
    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Genres Database
    mMovieModel.getGenresFromDatabase()?.then((genreList){
      mGenreList=genreList;

      ///Movies by Genre
      _getMoviesByGenreAndRefresh(genreList.first.id ?? 0);
    }).catchError((error) {
      debugPrint(error.toString());
    });

    /// showcase database
    mMovieModel.getTopRatedMoviesFromDatabase()?.listen((movieList){
      mShowCaseMovieList=movieList;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    ///Actors
    mMovieModel.getActors(1)?.then((actorList){
      mActors=actorList;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

    ///Actors database
    mMovieModel.getAllActorsFromDatabase()?.then((actorList){
      mActors=actorList;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void onTapGenre(int genreId){
    _getMoviesByGenreAndRefresh(genreId);
  }

  void _getMoviesByGenreAndRefresh (int genreId){
    mMovieModel.getMoviesByGenre(genreId)?.then((moviesByGenre){
      mMoviesByGenreList=moviesByGenre;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void onNowPlayingMovieListEndReached(){
    this.pageForNowPlayingMovie +=1;
    mMovieModel.getNowPlayingMovies(pageForNowPlayingMovie);
  }
// void dispose(){
//   mNowPlayingStreamController?.close();
//   mPopularMoviesListStreamController?.close();
//   mGenreListStreamController?.close();
//   mActorsStreamController?.close();
//   mShowCaseMovieListStreamController?.close();
//   mMoviesByGenreListStreamController?.close();
// }

}