import 'package:flutter/material.dart';
import 'package:movie_app/data.vos/actor_vo.dart';
import 'package:movie_app/data.vos/base_actor_vo.dart';
import 'package:movie_app/network/api_constants.dart';

import '../../resources/colors.dart';
import '../../resources/dimens.dart';

class ActorView extends StatelessWidget {
  final BaseActorVO? mActor;
  ActorView({this.mActor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MOVIE_LIST_ITEM_WIDTH,
        child: Stack(
          children: [
            Positioned.fill(
                child: ActorImageView(
                  mActorImageUrl: mActor?.profilePath,
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(MARGIN_MEDIUM),
              child: Align(
                alignment: Alignment.topRight,
                child: FavouriteButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ActorNameAndLikeView(
                mActorName: mActor?.name,
              ),
            )
          ],
        )
        ,
      ),
    );
  }
}

class ActorImageView extends StatelessWidget {
  final String? mActorImageUrl;

  ActorImageView({this.mActorImageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$mActorImageUrl",
    fit: BoxFit.cover,
    );
  }
}

class FavouriteButtonView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_border,
      color: Colors.white,
    );
  }
}

class ActorNameAndLikeView extends StatelessWidget {
  final String? mActorName;
  ActorNameAndLikeView({this.mActorName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM,
          vertical: MARGIN_MEDIUM_2
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(mActorName ??"",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR,
            fontWeight: FontWeight.w700,
          ),
          ),
          SizedBox(height: MARGIN_MEDIUM),
          Row(
            children: [
              Icon(
                Icons.thumb_up,
                color: Colors.amber,
                size: MARGIN_CARD_MEDIUM_2,
              ),
              SizedBox(width: MARGIN_MEDIUM),
              Text(
                "YOU LIKE 13 MOVIES",
                style: TextStyle(
                  fontSize: 10,
                  color: HOME_SCREEE_LIST_TITLE_COLOR,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],

      ),
    );
  }
}
