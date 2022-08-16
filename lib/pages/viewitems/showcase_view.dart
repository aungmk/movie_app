import 'package:flutter/material.dart';
import 'package:movie_app/resources/dimens.dart';
import 'package:movie_app/widgets/play_button_view.dart';
import 'package:movie_app/widgets/title_text.dart';

class ShowCaseView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM_2),
      width: 300,
      child: Stack(
        children:[
          Positioned.fill(
              child: Image.network(
                "https://spotlightreport.net/wp-content/uploads/2013/05/the-wolverine-banner-4.jpg",
              fit: BoxFit.cover,
              ),
          ),
          Align(
            alignment: Alignment.center,
            child: PlayButtonView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Passengers",
                  style: TextStyle(color: Colors.white,
                    fontSize: TEXT_REGULAR_3X,
                    fontWeight: FontWeight.w600,
                  ),
                  ),
                  SizedBox(height: MARGIN_MEDIUM),
                  TitleText("15 December 2016")


                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
