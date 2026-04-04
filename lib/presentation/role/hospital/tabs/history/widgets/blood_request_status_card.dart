import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class BloodRequestStatusCard extends StatelessWidget {
  const BloodRequestStatusCard({
    super.key,
    required this.bloodType,
    required this.requestDate,
    required this.isFulfilled,
  });

  final String bloodType;
  final String requestDate;
  final bool isFulfilled;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Card(
      color: isFulfilled ? ColorManger.lightGreen : ColorManger.lightRed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(width: 1, color: isFulfilled ? ColorManger.green : ColorManger.brightRed),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                isFulfilled
                    ? Icon(
                        Icons.check_circle_outline,
                        color: ColorManger.green,
                        size: 24,
                      )
                    : Icon(
                        Icons.cancel_outlined,
                        color: ColorManger.brightRed,
                        size: 24,
                      ),
                SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: '$bloodType ${appLocalization.bloodRequest}',
                      textStyle: TextStyle(
                        fontSize: FontSize.s16,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManger.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    CustomText(
                      text: requestDate,
                      textStyle: TextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.regular,
                        color: ColorManger.slateGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: isFulfilled
                    ? ColorManger.green.withValues(alpha: 0.9)
                    : ColorManger.brightRed.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: CustomText(
                  text: isFulfilled
                      ? appLocalization.fulfilled
                      : appLocalization.cancelled,
                  textStyle: TextStyle(
                    color: ColorManger.pureWhite,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.semiBold,
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
