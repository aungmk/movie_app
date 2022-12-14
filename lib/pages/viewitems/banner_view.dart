import 'package:flutter/material.dart';
import 'package:movie_app/data.vos/movie_vo.dart';
import 'package:movie_app/network/api_constants.dart';
import 'package:movie_app/pages/viewitems/movie_view.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widgets/gradient_view.dart';
import 'package:movie_app/widgets/play_button_view.dart';

class BannerView extends StatelessWidget {

  final MovieVO? mMovie;
  BannerView({this.mMovie});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned.fill(
            child: BannerImageView(
              mImageUrl: mMovie?.posterPath,
            ),
          ),
          Positioned.fill(
            child: GradientView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: BannerTitleView(
              mMovieName: mMovie?.title,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: PlayButtonView(),
          )
        ],
      ),
    );
  }
}





class BannerTitleView extends StatelessWidget {
  final String? mMovieName;
  BannerTitleView({this.mMovieName});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mMovieName ??"",
            style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_HEADING_1X,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Official Review",
            style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_HEADING_1X,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class BannerImageView extends StatelessWidget {
  final String? mImageUrl;
  BannerImageView({this.mImageUrl});
  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$mImageUrl",
      fit: BoxFit.cover,
    );
  }
}
