import 'package:movie_app/data.vos/movie_vo.dart';
import 'package:movie_app/network/movie_data_agent.dart';
import 'package:movie_app/network/retrofit_data_agent_impl.dart';

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

  @override
  Future<List<MovieVO>>? getNowPlayingMovies(int page){
    return mDataAgent.getNowPlayingMovies(page);

  }
}