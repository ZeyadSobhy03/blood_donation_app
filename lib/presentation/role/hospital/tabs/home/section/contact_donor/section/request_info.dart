import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class RequestInfo extends StatelessWidget {
  const RequestInfo({
    super.key,
    required this.bloodType,
    required this.unitsNeeded,
    required this.urgency,
  });

  final String bloodType;
  final int unitsNeeded;
  final String urgency;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.lightOrange),
      ),
      elevation: 4,
      color: ColorManger.lightOrange,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: appLocalizations.request_for,
                  textStyle: TextStyle(
                    color: ColorManger.slateGrey,
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: '$bloodType • $unitsNeeded ${appLocalizations.units}',
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: ColorManger.orange,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: CustomText(
                  text: urgency,
                  textStyle: TextStyle(
                    color: ColorManger.pureWhite,
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
