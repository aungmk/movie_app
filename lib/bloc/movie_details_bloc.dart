
import 'package:flutter/foundation.dart';

import '../data.vos/credit_vo.dart';
import '../data.vos/models/movie_model.dart';
import '../data.vos/models/movie_model_impl.dart';
import '../data.vos/movie_vo.dart';

class MovieDetailsBloc extends ChangeNotifier{
  ///State
    MovieVO? mMovie;
    List<CreditVO>? mActorsList;
    List<CreditVO>? mCreatorsList;
    List<MovieVO>? mRelatedMovies;

    ///Model
    MovieModel mMovieModel =MovieModelImpl();

    MovieDetailsBloc(int movieId){
      ///movie details
      mMovieModel.getMovieDetails(movieId)?.then((movie){
        this.mMovie =movie;
        this.getRelatedMovies(movie.genres?.first.id ??0);
        notifyListeners();
      });
      ///movie details database
      mMovieModel.getMovieDetailsFromDatabase(movieId)?.then((movie){
        this.mMovie =movie;
        notifyListeners();
      });
      ///credits
      mMovieModel.getCreditsByMovie(movieId)?.then((creditsList){
        this.mActorsList =
            creditsList.where((credit)=> credit.isActor()).toList();
        this.mCreatorsList =
            creditsList.where((credit)=> credit.isCreator()).toList();
        notifyListeners();
      });
    }
    void getRelatedMovies(int genreId){
      mMovieModel.getMoviesByGenre(genreId)?.then((relatedMovies){
        mRelatedMovies=relatedMovies;
        notifyListeners();
      });
    }
}