import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data.vos/models/movie_model.dart';
import 'package:movie_app/data.vos/models/movie_model_impl.dart';
import 'package:movie_app/data.vos/movie_vo.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:movie_app/pages/viewitems/actor_view.dart';
import 'package:movie_app/pages/viewitems/movie_view.dart';
import 'package:movie_app/pages/viewitems/showcase_view.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widgets/actor_and_creator_section_view.dart';
import 'package:movie_app/widgets/see_more_text.dart';
import 'package:movie_app/widgets/title_text_with_see_more_view.dart';
import '../resources/strings.dart';
import '../widgets/title_text.dart';
import 'viewitems/banner_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  MovieModel mMovieModel = MovieModelImpl();

  List<String> genreList = [
    "Action",
    "Adventure",
    "Horror",
    "Comedy",
    "Thriller",
    "Drama"
  ];

  List<MovieVO>? mNowPlayingMovieList;

  @override
  void initState(){
    super.initState();

    mMovieModel.getNowPlayingMovies(1)
    ?.then((movieList){
      setState(() {
        mNowPlayingMovieList = movieList;
      });
    }).catchError((error){
      debugPrint(error.toString());
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              BannerSectionView(),
              SizedBox(height: MARGIN_LARGE),
              BestPopularMoviesAndSerialsSectionView(
                  () => _navigateToMovieDetailScreen(context),
                  mNowPlayingMovieList),
              SizedBox(height: MARGIN_LARGE),
              CheckMovieShowTimeSectionView(),
              SizedBox(height: MARGIN_LARGE),
              GenreSectionView(
                      () => _navigateToMovieDetailScreen(context),
                  genreList: genreList),
              SizedBox(height: MARGIN_LARGE),
              ShowCasesSection(),
              SizedBox(height: MARGIN_LARGE),
              ActorAndCreatorSectionView(
                  BEST_ACTOR_TITLE,
                  BEST_ACTOR_SEE_MORE
              ),
              SizedBox(height: MARGIN_LARGE)
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMovieDetailScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => MovieDetailPage()
    ),);
  }
}

class GenreSectionView extends StatelessWidget {

  const GenreSectionView(this.onTapMovie,{
    required this.genreList,
  });

  final List<String> genreList;
  final Function onTapMovie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: DefaultTabController(
            length: genreList.length,
            child: TabBar(
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEE_LIST_TITLE_COLOR,
              tabs: genreList
                  .map(
                    (genre) =>
                    Tab(
                      child: Text(genre),
                    ),
              ).toList(),
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
                  () {
                onTapMovie();
              },
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
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
            children: [
              ShowCaseView(),
              ShowCaseView(),
              ShowCaseView(),
            ],
          ),
        ),
      ],
    );
  }
}

class BestPopularMoviesAndSerialsSectionView extends StatelessWidget {
  final Function onTapMovie;
  final List<MovieVO>? mNowPlayingMovieList;

  BestPopularMoviesAndSerialsSectionView(this.onTapMovie,this.mNowPlayingMovieList);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: TitleText(
            BEST_POPULAR_MOVIES_AND_SERIALS,
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM),
        HorizontalMoviesListView(
                () {
              onTapMovie();
            }, movieList: mNowPlayingMovieList,
        )
      ]
      ,
    );
  }
}

class HorizontalMoviesListView extends StatelessWidget {

  final Function onTapMovie;
  final List<MovieVO>? movieList;

  HorizontalMoviesListView(this.onTapMovie, {this.movieList});

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
                  () {
                this.onTapMovie();
              },
            movieList![index]
          );
        },
      ) : Center(child: CircularProgressIndicator()),
    );
  }
}

class BannerSectionView extends StatefulWidget {


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
            children: [
              BannerView(),
              BannerView(),
            ],
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        DotsIndicator(
          dotsCount: 2,
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

