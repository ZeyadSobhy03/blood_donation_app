import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../l10n/app_localizations.dart';

class EligibilityStatusCard extends StatelessWidget {
  const EligibilityStatusCard({super.key});


  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Card(
      color: ColorManger.lightGreen,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12.r),
        side: BorderSide(
          color: ColorManger.green.withValues(alpha: 0.6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: ColorManger.green,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_outline,
                color: ColorManger.pureWhite,
              ),
            ),
            SizedBox(width: 8.w.clamp(4.w, 16.w)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomText(
                    text: appLocalization.eligibleTitle,
                    textStyle: TextStyle(
                      color: ColorManger.green,
                      height: 1.4,
                      fontSize: FontSize.s15,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ),
                  SizedBox(height: 4.h.clamp(8.h, 16.h)),
                  CustomText(
                    maxLines: 2,
                    text:
                        appLocalization.eligibleDescription,
                    textStyle: TextStyle(
                      color: ColorManger.green,
                      height: 1.4,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ),
                  SizedBox(height: 4.h.clamp(10.h, 20.h)),
                  LayoutBuilder(
                     builder: (context, constraints) {
                     return  ConstrainedBox(
                       constraints: BoxConstraints(maxWidth: constraints.maxWidth,
                       minHeight: 50,


                       ),

                       child: CustomElevatedButton(
                           backgroundColor: ColorManger.green,
                           elevation: 4,
                           foregroundColor: ColorManger.pureWhite,
                           onPressed: () {
                             Navigator.pushNamed(context, RouteManger.scheduleDonation);
                           },
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(8.r),
                           ),

                           child: CustomText(text: appLocalization.scheduleDonation),
                         ),
                     );
                     },

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
