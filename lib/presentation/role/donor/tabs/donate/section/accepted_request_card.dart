import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';

class AcceptedRequestCard extends StatelessWidget {
  const AcceptedRequestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      elevation: 6,
      child: Column(
        children: [

        ],
      ),

    );
  }
}
