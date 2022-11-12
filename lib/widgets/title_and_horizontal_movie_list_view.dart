import 'package:flutter/material.dart';
import 'package:movie_app/widgets/title_text.dart';

import '../data.vos/movie_vo.dart';
import '../pages/viewitems/movie_view.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';

class TitleAndHorizontalMovieListView extends StatelessWidget {
  final Function(int) onTapMovie;
  final List<MovieVO>? mNowPlayingMovieList;
  final String title;
  final Function  onListEndReached;

  TitleAndHorizontalMovieListView(
      this.onTapMovie,
      this.mNowPlayingMovieList,{
        required this.title,
        required this.onListEndReached,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: TitleText(title),
        ),
        SizedBox(height: MARGIN_MEDIUM),
        HorizontalMoviesListView(
              (movieId) {
            onTapMovie(movieId ??0);
          },
          movieList: mNowPlayingMovieList,
          onListEndReached: (){
                this.onListEndReached();
          },
        )
      ],
    );
  }
}

class HorizontalMoviesListView extends StatelessWidget {

  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;
  final Function onListEndReached;

  HorizontalMoviesListView(
      this.onTapMovie,
      {this.movieList,
      required this.onListEndReached,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: (movieList != null) ? ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
        itemCount: movieList?.length,
        itemBuilder: (BuildContext context, int index) {
          return MovieView(
                  (movieId) {
                onTapMovie(movieId);
              },
              movieList![index],
          );
        },
      ) : Center(child: CircularProgressIndicator()),
    );
  }
}