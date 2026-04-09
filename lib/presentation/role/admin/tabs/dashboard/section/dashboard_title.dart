import 'package:flutter/material.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';

class DashboardTitle extends StatelessWidget {
  const DashboardTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: appLocalization.adminDashboard,
              textStyle: TextStyle(
                color: ColorManger.brightPurple,
                fontWeight: FontWeightManager.bold,
                fontSize: FontSize.s22,
              ),
            ),
            SizedBox(height: 4),
            CustomText(
              text: appLocalization.dashboardSubtitle,
              textStyle: TextStyle(
                color: ColorManger.slateGrey,
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.regular,
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorManger.green,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: ColorManger.pureWhite,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4),
                CustomText(
                  text: appLocalization.systemOnline,
                  textStyle: TextStyle(
                    color: ColorManger.pureWhite,
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                ),
                SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
