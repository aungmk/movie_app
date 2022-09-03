import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
  void getNowPlayingMovies(int page) {
    mApi?.getNowPlayingMovie(API_KEY, LANGUAGE_EN_US, page.toString())
        .then((response){

      response.results?.forEach((movie) => debugPrint(movie.toString()));

    }).catchError((error){
      debugPrint("error ...... ${error.toString()}");
    });
  }
}
