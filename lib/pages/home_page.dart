import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data.vos/actor_vo.dart';
import 'package:movie_app/data.vos/genre_vo.dart';
import 'package:movie_app/data.vos/movie_vo.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:movie_app/pages/viewitems/movie_view.dart';
import 'package:movie_app/pages/viewitems/showcase_view.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widgets/actor_and_creator_section_view.dart';
import 'package:movie_app/widgets/see_more_text.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/change_notifier_provider.dart';
import '../bloc/home_bloc.dart';
import '../resources/strings.dart';
import '../widgets/title_and_horizontal_movie_list_view.dart';
import '../widgets/title_text.dart';
import 'viewitems/banner_view.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: PRIMARY_COLOR,
          title: Text(
            MAIN_SCREEN_APP_BAR_TITLE,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          leading: Icon(Icons.menu),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 0,
                left: 0,
                right: MARGIN_MEDIUM_2,
              ),
              child: Icon(
                Icons.search,
              ),
            )
          ],
        ),
        body: Container(
          color: HOME_SCREEN_BACKGROUND_COLOR,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Selector<HomeBloc, List<MovieVO>?>(
                  selector: (context, bloc) => bloc.mPopularMovieList,
                  builder: ( context, popularMovieList, child) =>
                      BannerSectionView(mPopularMovies: popularMovieList?.take(8).toList(),
                  ),
                ),
                SizedBox(height: MARGIN_LARGE),
                Selector<HomeBloc, List<MovieVO>?>(
                  selector: (context, bloc) => bloc.mNowPlayingMovieList,
                  builder: ( context, nowPlayingMovieList, child) =>
                      TitleAndHorizontalMovieListView(
                              (movieId) => _navigateToMovieDetailScreen(context,movieId),
                          nowPlayingMovieList,
                      title: BEST_POPULAR_MOVIES_AND_SERIALS,
                      onListEndReached: (){
                        // var bloc = Provider.of<HomeBloc>(
                        // context,listen: false);
                        // bloc.onNowPlayingMovieListEndReached();
                        },
                        ),
                    ),
                SizedBox(height: MARGIN_LARGE),
                CheckMovieShowTimeSectionView(),
                SizedBox(height: MARGIN_LARGE),
                Selector<HomeBloc, List<GenreVO>?>(
                  selector: (context, bloc) => bloc.mGenreList,
                  builder: ( context, genreList, child) =>
                      Selector<HomeBloc, List<MovieVO>?>(
                        selector: (context, bloc) => bloc.mMoviesByGenreList,
                        builder: ( context, moviesByGenreList, child) =>
                            GenreSectionView(
                              genreList: genreList,
                              onTapMovie: (movieId) => _navigateToMovieDetailScreen(context,movieId),
                              onTapGenre: (genreId) {
                                HomeBloc bloc=
                                  Provider.of<HomeBloc>(context, listen: false);
                                    bloc.onTapGenre(genreId);
                              },
                              mMoviesByGenreList: moviesByGenreList,
                            ),
                      ),
                ),
                SizedBox(height: MARGIN_LARGE),
                Selector<HomeBloc, List<MovieVO>?>(
                  selector: (context, bloc) => bloc.mShowCaseMovieList,
                  builder: ( context, showCaseMovieList, child) =>
                      ShowCasesSection(showCaseMovieList),
                ),
                SizedBox(height: MARGIN_LARGE),
                Selector<HomeBloc, List<ActorVO>?>(
                  selector: (context, bloc) => bloc.mActors,
                  builder: ( context, actors, child) =>
                      ActorAndCreatorSectionView(
                        BEST_ACTOR_TITLE,
                        BEST_ACTOR_SEE_MORE,
                        mActorsList: actors,
                      ),
                ),
                SizedBox(height: MARGIN_LARGE)
              ],
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


class GenreSectionView extends StatelessWidget {

  final List<GenreVO>? genreList;
  final List<MovieVO>? mMoviesByGenreList;
  final Function(int) onTapMovie;
  final Function(int) onTapGenre;

  GenreSectionView(
  {this.genreList,
    this.mMoviesByGenreList,
    required this.onTapMovie,
    required this.onTapGenre});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: DefaultTabController(
            length: genreList?.length ??0,
            child: TabBar(
              onTap: (index) {
                onTapGenre(genreList?[index].id ??0);
              },
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEE_LIST_TITLE_COLOR,
              tabs: genreList
                  ?.map(
                    (genre) =>
                    Tab(
                      child: Text(genre.name ??""),
                    ),
              ).toList() ??[],
            ),
          ),
        ),
        Container(
            color: PRIMARY_COLOR,
            padding: EdgeInsets.only(
              top: MARGIN_MEDIUM_2,
              bottom: MARGIN_LARGE,
            ),
            child: HorizontalMoviesListView(
                  (movieId) {
                onTapMovie(movieId ??0);
              },
              movieList: mMoviesByGenreList,
              onListEndReached: (){},
            )
        ),
      ],
    );
  }
}

class CheckMovieShowTimeSectionView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      margin: EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
      ),
      padding: EdgeInsets.all(MARGIN_LARGE),
      height: SHOWTIME_SECTION_HEIGHT,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MAIN_SCREEN_CHECK_MOVIE_SHOW_TIME,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_HEADING_1X,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              SeeMoreText(
                MAIN_SCREEN_SEE_MORE,
                textColor: PLAY_BUTTON_COLOR,
              )
            ],
          ),
          Spacer(),
          Icon(
            Icons.location_on_rounded,
            color: Colors.white,
            size: BANNER_PLAY_BUTTON_SIZE,
          )
        ],
      ),
    );
  }
}


class ShowCasesSection extends StatelessWidget {
  final List<MovieVO>? mShowCaseMovieList;

  ShowCasesSection(this.mShowCaseMovieList);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: TitleTextWithSeeMoreView(
            SHOW_CASES_TITLE,
            SHOW_CASES_SEE_MORE,
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        Container(
          height: SHOW_CASES_HEIGHT,
          child: (mShowCaseMovieList !=null)
          ? ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
            children: mShowCaseMovieList
                ?.map((showCaseMovie) => ShowCaseView(showCaseMovie))
              .toList() ??[],
          )
              : Center(child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}



class BannerSectionView extends StatefulWidget {

  final  List<MovieVO>? mPopularMovies;

  BannerSectionView({this.mPopularMovies});


  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height / 4,
          child: PageView(
            onPageChanged: (page) {
              setState(() {
                _position = page.toDouble();
              });
            },
            children: widget.mPopularMovies?.map((popularMovie)  => BannerView(
              mMovie: popularMovie,
            )).toList() ??[]),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        DotsIndicator(
          dotsCount: widget.mPopularMovies?.length ??0,
          position: _position,
          decorator: DotsDecorator(
            color: HOME_SCREE_BANNER_DOTS_INACTIVE_COLOR,
            activeColor: PLAY_BUTTON_COLOR,
          ),
        )
      ],
    );
  }
}

