import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MedalIcon extends StatelessWidget {
  const MedalIcon({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
  });

  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: FaIcon(
          FontAwesomeIcons.medal,
          size: 26,
          color: iconColor,
        ),
      ),
    );
  }
}
