import 'package:flutter/material.dart';
import 'package:movie_app/resources/colors.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/resources/strings.dart';
import 'package:movie_app/widgets/Actor_And_Creator_Section_View.dart';
import 'package:movie_app/widgets/gradient_view.dart';
import 'package:movie_app/widgets/rating_view.dart';
import 'package:movie_app/widgets/title_text.dart';

class MovieDetailPage extends StatelessWidget {
  final List<String> genreList=[
    "Action",
    "Adventure",
    "Thriller"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: CustomScrollView(
          slivers: [
            MovieDetailSliverAppBar(
                ()=> Navigator.pop(context),
            ),
            SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM_2
                      ),
                      child: TrailerSection(genreList)
                    ),
                    SizedBox(height: MARGIN_LARGE),
                    ActorAndCreatorSectionView(MOVIE_DETAIL_SCREEN_ACTOR_TITLE,"",
                    seeMoreButtonVisibility: false,
                    ),
                    SizedBox(height: MARGIN_LARGE),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal:
                      MARGIN_MEDIUM_2),
                      child: AboutFilmSectionView(),
                    ),
                    SizedBox(height: MARGIN_LARGE),
                    ActorAndCreatorSectionView(MOVIE_DETAIL_SCREEN_CREATOR_TITLE,
                      MOVIE_DETAIL_SCREEN_CREATOR_SEE_MORE
                    ),
              ]
                )
            )
          ],
        ),
      ),
    );
  }
}

class AboutFilmSectionView extends StatelessWidget {
  const AboutFilmSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText("ABOUT FILM"),
        SizedBox(height: MARGIN_LARGE),
        AboutFilmInfoView("Original Title","X-Men Origin Wolverine"
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView("Type","Action, Adventure, Thriller"
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView("Production","United Kingdom,USA"
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView("Premiere","8 November 2016(world)"
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        AboutFilmInfoView("Description","The film's development began in 2009 after the release of X-Men Origins: Wolverine. Christopher McQuarrie was hired to write a screenplay for The Wolverine in August 2009. In October 2010, Darren Aronofsky was hired to direct the film. The project was delayed following Aronofsky's departure and the Tōhoku earthquake and tsunami in March 2011. In June 2011, Mangold was brought on board to replace Aronofsky",
          ),
      ],
    );
  }
}

class AboutFilmInfoView extends StatelessWidget {
  final String label;
  final String description;

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
          child: Text(description,
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

  final List<String> genreList;

  TrailerSection(this.genreList);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(genreList: genreList),
        SizedBox(height: MARGIN_MEDIUM_3),
        StorylineView(),
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
  const StorylineView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAIL_STORYLINE_TITLE),
        SizedBox(height: MARGIN_MEDIUM),
        Text("The film's development began in 2009 after the release of X-Men Origins: Wolverine. Christopher McQuarrie was hired to write a screenplay for The Wolverine in August 2009. In October 2010, Darren Aronofsky was hired to direct the film. The project was delayed following Aronofsky's departure and the Tōhoku earthquake and tsunami in March 2011. In June 2011, Mangold was brought on board to replace Aronofsky",
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

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.access_time,
        color: PLAY_BUTTON_COLOR
        ),
        SizedBox(width: MARGIN_SMALL),
        Text(
            "2hr30min",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        ),
        SizedBox(width: MARGIN_MEDIUM),
        Row(
          children: genreList
              .map((genre) => GenreChipView(genre))
              .toList(),
        ),
        Spacer(),
        Icon(Icons.favorite_border,
        color: Colors.white,
        )

      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;

  GenreChipView(this.genreText);


  @override
  Widget build(BuildContext context) {
    return Row(
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
  MovieDetailSliverAppBar(this.onTapBack);
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
              child: MovieDetailAppBarImageView(),
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
                child: MovieDetailAppBarInfoView(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieDetailAppBarInfoView extends StatelessWidget {
  const MovieDetailAppBarInfoView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            MovieDetailYearView(),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingView(),
                    SizedBox(height: MARGIN_SMALL),
                    TitleText("38876 VOTES"),
                    SizedBox(height: MARGIN_MEDIUM_2)
                  ],
                ),
                SizedBox(width: MARGIN_CARD_MEDIUM_2),
                Text(
                  "9,76",
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
          "The Wolverine",
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
  const MovieDetailYearView({
    Key? key,
  }) : super(key: key);

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
          "2018",
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
  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://spotlightreport.net/wp-content/uploads/2013/05/the-wolverine-banner-4.jpg",
      fit: BoxFit.cover,
    );
  }
}
