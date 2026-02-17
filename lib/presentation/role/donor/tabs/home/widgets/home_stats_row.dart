import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../l10n/app_localizations.dart';
import 'home_custom_card.dart';

class HomeStatsRow extends StatelessWidget {
  const HomeStatsRow({super.key, required this.donations, required this.points, required this.livesSaved, required this.textColor, required this.backgroundColor, required this.borderColor, required this.elevation});
  final int donations;
  final int points;
  final int livesSaved;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final double elevation;




  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return  Row(
      children: [
        Expanded(
          child: HomeCustomCard(
            borderColor: borderColor,
            elevation: elevation,
            textColor: textColor,
            number: donations,
            icon: Icons.favorite_border_outlined,
            text: appLocalizations.donations,
            iconColor: ColorManger.pureWhite,
            backgroundColor: backgroundColor,
          ),
        ),
        Expanded(
          child: HomeCustomCard(
            borderColor: borderColor,
            elevation: 0,
            textColor: textColor,
            number: points    ,
            icon: Icons.military_tech,
            text: appLocalizations.points,
            iconColor: ColorManger.pureWhite,
            backgroundColor: backgroundColor,
          ),
        ),
        Expanded(
          child: HomeCustomCard(
            borderColor: borderColor,
            elevation: 0,
            textColor: textColor  ,
            number: livesSaved,
            icon: Icons.trending_up,
            text: appLocalizations.livesSaved,
            iconColor: ColorManger.pureWhite,
            backgroundColor: backgroundColor,
          ),
        ),
      ],
    );
  }
}
