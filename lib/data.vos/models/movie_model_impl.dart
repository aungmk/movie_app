import 'package:movie_app/data.vos/actor_vo.dart';
import 'package:movie_app/data.vos/credit_vo.dart';
import 'package:movie_app/data.vos/genre_vo.dart';
import 'package:movie_app/data.vos/movie_vo.dart';
import 'package:movie_app/network/movie_data_agent.dart';
import 'package:movie_app/network/retrofit_data_agent_impl.dart';
import 'package:movie_app/persistence/daos/actor_daos.dart';
import 'package:movie_app/persistence/daos/genre_daos.dart';
import 'package:movie_app/persistence/daos/movie_daos.dart';
import 'package:stream_transform/stream_transform.dart';

import 'movie_model.dart';

class MovieModelImpl extends MovieModel{

  MovieDataAgent mDataAgent= RetrofitDataAgentImpl();

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  /// third create factory constructor mean only remain object is return everytime.
  factory MovieModelImpl(){
    return _singleton;
  }
  /// fist private constructor create using _name init process put in
  MovieModelImpl._internal(){
    getNowPlayingMoviesFromDatabase();
    getTopRatedMoviesFromDatabase();
    getPopularMovieFromDatabase();
    getAllActorsFromDatabase();
    getActors(1);
    getGenresFromDatabase();
    getGenres();
  }

  ///daos
  MovieDao mMovieDao=MovieDao();
  GenreDao mGenreDao=GenreDao();
  ActorDao mActorDao=ActorDao();

  ///state
  List<MovieVO>? mNowPlayingMovieList;
  List<MovieVO>? mPopularMoviesList;
  List<GenreVO>? mGenreList;
  List<ActorVO>? mActors;
  List<MovieVO>? mShowCaseMovieList;
  List<MovieVO>? mMoviesByGenreList;

  ///Movie detail page state
  MovieVO? mMovie;
  List<CreditVO>? mActorsList;
  List<CreditVO>? mCreatorsList;


  //Network
  @override
  void getNowPlayingMovies(int page){
    mDataAgent.getNowPlayingMovies(page)?.then((movies) async {
      List<MovieVO> nowPlayingMovies = movies.map((movie){
        movie.isNowPlaying=true;
        movie.isPopular=false;
        movie.isTopRated=false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(nowPlayingMovies);
      mNowPlayingMovieList=nowPlayingMovies;
      notifyListeners();
      //return Future.value(movies);
    });
  }

  @override
  void getPopularMovie(int page){
    mDataAgent.getPopularMovie(page)?.then((movies) async {
      List<MovieVO> popularMovies = movies.map((movie){
        movie.isNowPlaying=false;
        movie.isPopular=true;
        movie.isTopRated=false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(popularMovies);
      mPopularMoviesList=popularMovies;
      notifyListeners();
      //return Future.value(movies);
    });
  }

  @override
  void getTopRatedMovies(int page){
    mDataAgent.getTopRatedMovies(page)?.then((movies) async {
      List<MovieVO> topRatedMovies = movies.map((movie){
        movie.isNowPlaying=false;
        movie.isPopular=false;
        movie.isTopRated=true;
        return movie;
      }).toList();
      mMovieDao.saveMovies(topRatedMovies);
      mShowCaseMovieList=topRatedMovies;
      notifyListeners();
      //return Future.value(movies);
    });
  }

  @override
  void getGenres(){
    mDataAgent.getGenres()?.then((genres) async {
      mGenreDao.saveAllGenre(genres);
      mGenreList=genres;
      getMoviesByGenre(genres.first.id ?? 0);
      notifyListeners();
      return Future.value(genres);
    });
  }

  @override
  void getMoviesByGenre(int genreId){
    mDataAgent.getMoviesByGenre(genreId)
    ?.then((moviesList) {
      mMoviesByGenreList=moviesList;
      notifyListeners();
    });
  }

  @override
  void getActors(int page){
    mDataAgent.getActors(page)?.then((actor) async {
      mActorDao.saveAllActors(actor);
      mActors=actor;
      notifyListeners();
      return Future.value(actor);
    });
  }

  @override
  void getCreditsByMovie(int movieId) {
    mDataAgent.getCreditsByMovie(movieId)
        ?.then((creditsList) {
      this.mActorsList =
          creditsList.where((credit) => credit.isActor()).toList();
      this.mCreatorsList =
          creditsList.where((credit) => credit.isCreator()).toList();
      notifyListeners();
    });
  }

  @override
  void getMovieDetails(int movieId) {
    mDataAgent.getMovieDetails(movieId)?.then((movie) async {
      mMovieDao.saveSingleMovie(movie);
      mMovie=movie;
      notifyListeners();
      return Future.value(movie);
    });
  }

  //Database

  @override
  void getAllActorsFromDatabase() {
    mActors=mActorDao.getAllActors();
    notifyListeners();
  }

  @override
  void getGenresFromDatabase() {
   mGenreList=mGenreDao.getAllGenres();
   notifyListeners();
  }

  @override
  void getMovieDetailsFromDatabase(int movieId) {
    mMovie=mMovieDao.getMovieById(movieId);
    notifyListeners();
  }

  @override
  void getNowPlayingMoviesFromDatabase() {
    this.getNowPlayingMovies(1);
    mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getNowPlayingMoviesStream())
        .combineLatest(mMovieDao.getNowPlayingMoviesStream(),
            (event, movieList) => movieList as List<MovieVO>)
        .first
        .then((nowPlayingMovies) {
      mNowPlayingMovieList = nowPlayingMovies;
      notifyListeners();
    });
  }

  @override
  void getPopularMovieFromDatabase() {
    this.getPopularMovie(1);
    mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getPopularMoviesStream())
        .combineLatest(mMovieDao.getPopularMoviesStream(),
            (event, movieList) => movieList as List<MovieVO>)
        .first
        .then((popularMovies) {
      mPopularMoviesList=popularMovies;
      notifyListeners();
    });
  }

  @override
  void getTopRatedMoviesFromDatabase() {
    this.getTopRatedMovies(1);
    mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getTopRatedMoviesStream())
        .combineLatest(mMovieDao.getTopRatedMoviesStream(),
            (event, movieList) => movieList as List<MovieVO>)
            .first
            .then((topRatedMovies) {
              mShowCaseMovieList=topRatedMovies;
              notifyListeners();
    });
  }
}