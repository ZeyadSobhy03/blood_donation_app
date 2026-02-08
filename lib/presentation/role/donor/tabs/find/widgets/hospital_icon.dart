import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';

class HospitalIcon extends StatelessWidget {
  const HospitalIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: ColorManger.lightRed,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.local_hospital,
        color: ColorManger.brightRed,
      ),
    );
  }
}
