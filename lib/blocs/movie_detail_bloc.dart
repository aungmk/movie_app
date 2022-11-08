

import 'dart:async';

import 'package:movie_app/data.vos/credit_vo.dart';
import 'package:movie_app/data.vos/models/movie_model.dart';
import 'package:movie_app/data.vos/models/movie_model_impl.dart';

import '../data.vos/movie_vo.dart';

class MovieDetailsbloc{
  /// Stream Controllers
  StreamController<MovieVO>? movieStreamController=
  StreamController();
  StreamController<List<CreditVO>>? creatorsStreamController=
  StreamController();
  StreamController<List<CreditVO>>? actorsStreamController=
  StreamController();

  ///Models
  MovieModel mMovieModel= MovieModelImpl();

  MovieDetailsbloc(int movieId){
    /// Movie Details
    mMovieModel.getMovieDetails(movieId)?.then((movie){
      movieStreamController?.sink.add(movie);
    });
    /// Movie Details Database
    mMovieModel.getMovieDetailsFromDatabase(movieId)?.then((movie){
      movieStreamController?.sink.add(movie);
    });
    /// Now Playing Movies Database
    mMovieModel.getCreditsByMovie(movieId)?.then((creditsList){
      actorsStreamController?.sink
          .add(creditsList.where((credit) => credit.isActor()).toList());
      creatorsStreamController?.sink
      .add(creditsList.where((credit) => credit.isCreator()).toList());
    });
  }

  void disposeStreams(){
    movieStreamController?.close();
    creatorsStreamController?.close();
    actorsStreamController?.close();
  }

}