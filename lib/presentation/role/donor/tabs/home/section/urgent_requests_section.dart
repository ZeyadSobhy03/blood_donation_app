import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/bottom_sheet/confirm_response_bottom_sheet.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/home/widgets/request_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/request_screen/model/urgent_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../l10n/app_localizations.dart';


class UrgentRequestsSection extends StatelessWidget {
  const UrgentRequestsSection({super.key, required this.requests});

  final List<UrgentRequestModel> requests;

  @override
  Widget build(BuildContext context) {


    return Card(
      color: ColorManger.pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
        side: BorderSide(color: ColorManger.brightRed.withValues(alpha: 0.1)),
      ),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 8.h,
                  width: 8.h,
                  decoration: BoxDecoration(
                    color: ColorManger.brightRed,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4.w),
                CustomText(
                  text:  AppLocalizations.of(context)!.urgentRequests,
                  textStyle: TextStyle(
                    color: ColorManger.brightRed,
                    fontSize: FontSize.s16,
                    height: 1.4,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: ColorManger.brightRed,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 6,
                      ),
                      child: CustomText(
                        text:'${requests.length} ${AppLocalizations.of(context)!.active}',
                        textStyle: TextStyle(
                          color: ColorManger.pureWhite,
                          fontWeight: FontWeightManager.regular,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                return RequestCard(
                  isButtonExist: true,
                  width: 1,
                  borderColor: ColorManger.transparent,
                  widget: Container(
                    height: 6.h,
                    width: 6.h,
                    decoration: BoxDecoration(
                      color: request.isEmergency
                          ? ColorManger.brightRed
                          : ColorManger.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteManger.requestScreen,
                      arguments: request,
                    );
                  },
                  backgroundColor: request.isEmergency
                      ? ColorManger.lightRed
                      : ColorManger.lightOrange,
                  dotColor: request.isEmergency
                      ? ColorManger.brightRed
                      : ColorManger.orange,
                  title: requests[index].title,
                  location: requests[index].location,
                  time: requests[index].time,
                  buttonBackgroundColor: requests[index].isEmergency
                      ? ColorManger.brightRed
                      : ColorManger.orange,
                  onPressed: () => showConfirmResponseBottomSheet(context, requests[index]),
                );
              },
            ),

          ],
        ),
      ),
    );
  }


}
