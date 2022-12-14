import 'package:flutter/material.dart';
import 'package:movie_app/data.vos/credit_vo.dart';
import 'package:movie_app/data.vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/widgets/Actor_And_Creator_Section_View.dart';
import 'package:movie_app/widgets/gradient_view.dart';
import 'package:movie_app/widgets/rating_view.dart';
import 'package:movie_app/widgets/title_and_horizontal_movie_list_view.dart';
import 'package:movie_app/widgets/title_text.dart';
import 'package:provider/provider.dart';

import '../bloc/home_bloc.dart';
import '../bloc/movie_details_bloc.dart';

class MovieDetailPage extends StatelessWidget {
  final int movieId;

  MovieDetailPage(this.movieId);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailsBloc(movieId),
      child: Scaffold(
        body: Selector<MovieDetailsBloc,MovieVO?>(
          selector: (context,bloc) => bloc.mMovie,
          builder: ( context, movie,  child) =>  Container(
            color: HOME_SCREEN_BACKGROUND_COLOR,
            child: (movie != null)
                ? CustomScrollView(
              slivers: [
                MovieDetailSliverAppBar(
                      ()=> Navigator.pop(context),
                  movie,
                ),
                SliverList(
                    delegate: SliverChildListDelegate(
                        [
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MARGIN_MEDIUM_2
                              ),
                              child: TrailerSection(movie)
                          ),
                          SizedBox(height: MARGIN_LARGE),
                          Selector<MovieDetailsBloc, List<CreditVO>?>(
                            selector: (context, bloc) => bloc.mActorsList,
                            builder: ( context, actorList, child) =>
                                ActorAndCreatorSectionView(MOVIE_DETAIL_SCREEN_ACTOR_TITLE,"",
                                  seeMoreButtonVisibility: false,
                                  mActorsList: actorList,
                                ),
                          ),
                          SizedBox(height: MARGIN_LARGE),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal:
                            MARGIN_MEDIUM_2),
                            child: AboutFilmSectionView(movie),
                          ),
                          SizedBox(height: MARGIN_LARGE),
                          Selector<MovieDetailsBloc, List<CreditVO>?>(
                            selector: (context, bloc) => bloc.mCreatorsList,
                            builder: ( context, creatorsList, child) {
                              return (creatorsList != null && creatorsList.isNotEmpty)
                                  ? ActorAndCreatorSectionView(
                                MOVIE_DETAIL_SCREEN_CREATOR_TITLE,
                                MOVIE_DETAIL_SCREEN_CREATOR_SEE_MORE,
                                mActorsList: creatorsList,
                              )
                                  : Container();
                            }
                          ),
                          SizedBox(height: MARGIN_LARGE),
                          Selector<MovieDetailsBloc,List<MovieVO>?>(
                            selector: (context,bloc) => bloc.mRelatedMovies,
                            builder: (context, relatedMovies,  child) =>
                            TitleAndHorizontalMovieListView(
                                  (movieId) => _navigateToMovieDetailScreen(context,movieId),
                              relatedMovies,
                              title: MOVIE_DETAIL_SCREEN_RELATED_MOVIES,
                              onListEndReached: (){
                                // var bloc = Provider.of<HomeBloc>(
                                //     context,listen: false);
                                // bloc.onNowPlayingMovieListEndReached();
                              },
                            ),
                          ),
                        ]
                    )
                )
              ],
            )
                : Center(
                child: CircularProgressIndicator()
            ),
          ),
        ),
      ),
    );
  }


}

void _navigateToMovieDetailScreen(BuildContext context, int movieId) {
  Navigator.push(context, MaterialPageRoute(
      builder: (context) => MovieDetailPage(movieId)
  ),);
}


class AboutFilmSectionView extends StatelessWidget {
  final MovieVO? mMovie;

  AboutFilmSectionView(this.mMovie);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText("ABOUT FILM"),
        SizedBox(height: MARGIN_LARGE),
        AboutFilmInfoView("Original Title:",
          mMovie?.originalTitle ??"",
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView("Type",
          mMovie?.genres?.map((genre) => genre.name ??"").join(","),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView("Production",
          mMovie?.productionCountries?.map((country) => country.name ??"").join(","),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView("Premiere",mMovie?.releaseDate??""
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView("Description",mMovie?.overview??"",
        ),
      ],
    );
  }
}

class AboutFilmInfoView extends StatelessWidget {
  final String label;
  final String? description;

  AboutFilmInfoView(this.label,this.description);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width/4,
          child: Text(label,
            style: TextStyle(
              color: MOVIE_DETAIL_INFO_TEXT_COlOR,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: MARGIN_CARD_MEDIUM_2),
        Expanded(
          child: Text(description ??"",
            style: TextStyle(
              color: Colors.white,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class TrailerSection extends StatelessWidget {

  final MovieVO? mMovie;

  TrailerSection(this.mMovie);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(
            genreList:mMovie?.genres?.map((genre) => genre.name ?? "").toList()
        ),
        SizedBox(height: MARGIN_MEDIUM_3),
        StorylineView(mMovie?.overview ??""),
        SizedBox(height: MARGIN_MEDIUM_2),
        Row(
          children: [
            MovieDetailScreenButtonView(
              "PLAY TRAILER",
              PLAY_BUTTON_COLOR,
              Icon(
                Icons.play_circle_fill,
                color: Colors.black54,
              ),
            ),
            SizedBox(width: MARGIN_CARD_MEDIUM_2),
            MovieDetailScreenButtonView(
              "RATE MORE",
              HOME_SCREEN_BACKGROUND_COLOR,
              Icon(
                Icons.star,
                color: PLAY_BUTTON_COLOR,
              ),
              isGhostButton: true,
            ),
          ],
        )
      ],
    );
  }
}

class MovieDetailScreenButtonView extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Icon buttonIcon;
  final bool isGhostButton;

  MovieDetailScreenButtonView(
      this.title,
      this.backgroundColor,
      this.buttonIcon,
      {this.isGhostButton=false
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
        border: (isGhostButton)
            ? Border.all(
          color: Colors.white,
          width: 2,
        )
            :null,
      ),
      child: Center(
        child: Row(
          children: [
            buttonIcon,
            SizedBox(width: MARGIN_MEDIUM),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StorylineView extends StatelessWidget {
  final String overview;

  StorylineView(this.overview);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAIL_STORYLINE_TITLE),
        SizedBox(height: MARGIN_MEDIUM),
        Text(overview,
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        )
      ],
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  const MovieTimeAndGenreView({
    Key? key,
    required this.genreList,
  }) : super(key: key);

  final List<String>? genreList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      children: _createMovieTimeAndGenreWidget(),
    );
  }

  List<Widget> _createMovieTimeAndGenreWidget(){

    List<Widget> widgets=[
      Icon(Icons.access_time,
          color: PLAY_BUTTON_COLOR
      ),
      SizedBox(width: MARGIN_SMALL),
      Container(
        child: Text(
          "2hr30min",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(width: MARGIN_MEDIUM),
    ];

    widgets.addAll(genreList?.map((genre) => GenreChipView(genre)) .toList() ??[]);

    widgets.add(
      Icon(Icons.favorite_border,
        color: Colors.white,
      ),
    );
    return widgets;
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;

  GenreChipView(this.genreText);


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
            backgroundColor: MOVIE_DETAIL_SCREEN_CHIP_BACKGROUND_COLOR,
            label: Text(
              genreText,
              style:TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
        ),
        SizedBox(width: MARGIN_SMALL)
      ],
    );
  }
}

class MovieDetailSliverAppBar extends StatelessWidget {
  final Function onTapBack;
  final MovieVO mMovie;
  MovieDetailSliverAppBar(this.onTapBack,this.mMovie);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: PRIMARY_COLOR,
      expandedHeight: MOVIE_DETAIL_SCREEN_SLIVER_APP_BAR_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: MovieDetailAppBarImageView(mMovie.posterPath ??""),
            ),
            Positioned(
              child: GradientView(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MARGIN_XLARGE,
                  left: MARGIN_MEDIUM_2,
                ),
                child: BackButtonView(
                      ()=>onTapBack(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MARGIN_XLARGE + MARGIN_MEDIUM,
                  right: MARGIN_MEDIUM,
                ),
                child: SearchButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: MARGIN_MEDIUM_2,
                    right: MARGIN_MEDIUM_2,
                    bottom: MARGIN_LARGE),
                child: MovieDetailAppBarInfoView(mMovie),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieDetailAppBarInfoView extends StatelessWidget {
  final MovieVO? mMovie;
  MovieDetailAppBarInfoView(this.mMovie);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            MovieDetailYearView(mMovie?.releaseDate?.substring(0,4) ??""),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingView(),
                    SizedBox(height: MARGIN_SMALL),
                    TitleText("${mMovie?.voteCount} VOTES"),
                    SizedBox(height: MARGIN_MEDIUM_2)
                  ],
                ),
                SizedBox(width: MARGIN_CARD_MEDIUM_2),
                Text(
                  "${mMovie?.voteAverage}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MOVIE_DETAIL_RATING_TEXT_HEIGHT,
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          mMovie?.title ??"",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: TEXT_HEADING_2X,
          ),
        )
      ],
    );
  }
}

class MovieDetailYearView extends StatelessWidget {
  final String year;

  MovieDetailYearView(this.year);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_XLARGE),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: PLAY_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(
          MARGIN_XLARGE,
        ),
      ),
      child: Center(
        child: Text(
          year,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SearchButtonView extends StatelessWidget {
  const SearchButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.search,
      size: MARGIN_XLARGE,
      color: Colors.white,
    );
  }
}

class BackButtonView extends StatelessWidget {
  final Function onTapBack;

  BackButtonView(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        this.onTapBack();
      },
      child: Container(
        width: MARGIN_XXLARGE,
        height: MARGIN_XXLARGE,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
        ),
        child: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: MARGIN_XLARGE,
        ),
      ),
    );
  }
}

class MovieDetailAppBarImageView extends StatelessWidget {
  final String movieImage;
  MovieDetailAppBarImageView(this.movieImage);
  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$movieImage",
      fit: BoxFit.cover,
    );
  }
}



