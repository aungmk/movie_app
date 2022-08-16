import 'package:flutter/material.dart';
import 'package:movie_app/widgets/see_more_text.dart';
import 'package:movie_app/widgets/title_text.dart';

class TitleTextWithSeeMoreView extends StatelessWidget {
  final String titletext;
  final String seemoretext;
  final bool  seeMoreButtonVisibility;

  TitleTextWithSeeMoreView(this.titletext,this.seemoretext,
  {this.seeMoreButtonVisibility=true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleText (titletext,
        ),
        Spacer(),
        Visibility(
          visible: seeMoreButtonVisibility,
          child: SeeMoreText(seemoretext,
          ),
        )
      ],
    );
  }
}
