import 'package:blood_donation_app/core/cubits/map_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../core/widgets/custom_text.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../request_screen/model/urgent_request.dart';
import '../section/confirm_navigation_buttons.dart';
import '../section/next_steps_section.dart';
import '../widgets/request_card.dart';
String formatTimeAgo(DateTime dateTime, BuildContext context) {
  final difference = DateTime.now().difference(dateTime);

  if (difference.inMinutes < 60) {
    return AppLocalizations.of(context)!.minutesAgo(difference.inMinutes);
  } else if (difference.inHours < 24) {
    return AppLocalizations.of(context)!.hoursAgo(difference.inHours);
  } else if (difference.inDays < 7) {
    return AppLocalizations.of(context)!.daysAgo(difference.inDays);
  } else {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
void showConfirmResponseBottomSheet(
  BuildContext context,
  UrgentRequestModel request,
) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: ColorManger.pureWhite,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: AppLocalizations.of(context)!.confirmResponse,
                      textStyle: TextStyle(
                        height: 1.4,
                        color: ColorManger.black,
                        fontWeight: FontWeightManager.regular,
                        fontSize: FontSize.s16,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Divider(color: ColorManger.slateGrey),
                BlocBuilder<MapCubit, MapState>(
                  builder: (context, state) {
                    MapCubit mapCubit = context.read<MapCubit>();

                    double? distanceKm;
                    if (state is MapLoaded) {
                      final hospitalLat = request.locationHospital.latitude;
                      final hospitalLng = request.locationHospital.longitude;
                      final distanceInMeters = mapCubit.calculateDistance(
                        state.latitude,
                        state.longitude,
                        hospitalLat,
                        hospitalLng,
                      );

                      distanceKm = distanceInMeters / 1000;
                    }

                    return RequestCard(
                      isButtonExist: false,
                      borderColor: ColorManger.brightRed,
                      width: 1,
                      widget: Container(
                        decoration: BoxDecoration(
                          color: ColorManger.brightRed,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: ColorManger.pureWhite,
                        ),
                      ),
                      backgroundColor: ColorManger.lightRed,

                      dotColor: ColorManger.brightRed,
                      title: request.title,
                      location: distanceKm != null
                          ? AppLocalizations.of(
                              context,
                            )!.distanceAway(distanceKm.toStringAsFixed(1))
                          : AppLocalizations.of(context)!.gettingDistance,
                      time: formatTimeAgo(request.createdAt, context),
                      buttonBackgroundColor: ColorManger.brightRed,
                    );
                  },
                ),
                SizedBox(height: 12.h),
                CustomText(
                  text: AppLocalizations.of(context)!.emergencyRequestQuestion,
                  textStyle: TextStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManger.slateGrey,
                  ),
                ),
                SizedBox(height: 8.h),
                NextStepsSection(),
                SizedBox(height: 8.h),
                ConfirmNavigationButtons(
                  cancel: () {
                    Navigator.pop(context);
                  },
                  accept: () {},
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
