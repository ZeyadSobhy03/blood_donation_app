import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/nearby_donor/section/change_location_dialog.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/nearby_donor/widgets/donor_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';

class NearbyDonorCard extends StatelessWidget {
  const NearbyDonorCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      color: ColorManger.pureWhite,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomText(
                    text: appLocalizations.nearby_donor,
                    textStyle: TextStyle(
                      color: ColorManger.black,
                      fontWeight: FontWeightManager.semiBold,
                      fontSize: FontSize.s15,
                    ),
                  ),
                ),

                Expanded(
                  child: CustomElevatedButton(
                    backgroundColor: ColorManger.pureWhite,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ChangeLocationDialog(),
                      );
                    },
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    foregroundColor: ColorManger.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: BorderSide(color: ColorManger.lightGrey, width: 1),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        SizedBox(width: 4.w),
                        CustomText(
                          text: appLocalizations.change_location,
                          textStyle: TextStyle(
                            color: ColorManger.black,
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.regular,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 3 / 2,

              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) =>
                  DonorTile(bloodType: 'A+', numberOfDonor: 5),
            ),
          ],
        ),
      ),
    );
  }
}
