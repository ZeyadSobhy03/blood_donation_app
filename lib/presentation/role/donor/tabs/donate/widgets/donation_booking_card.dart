import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../../core/resources/routes/route_manger.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../find/widgets/info_row.dart';
import '../schedule_donation/model/donation_booking_card.dart';

class DonationBookingCard extends StatelessWidget {
  const DonationBookingCard({super.key, required this.model});

  final DonationBookingCardModel model;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final formatter = intl.DateFormat('dd MMM yyyy');
    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: constraints.maxWidth,
          minHeight: 150,
        ),
        child: Card(
          color: ColorManger.lightRed,
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: model.donationType ?? '',
                      textStyle: TextStyle(
                        color: ColorManger.black,
                        height: 1.4,
                        fontSize: FontSize.s15,
                        fontWeight: FontWeightManager.regular,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorManger.lightGreen,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: CustomText(
                          text: model.isConfirmed ?? false
                              ? appLocalization.confirmed
                              : appLocalization.pending,
                          textStyle: TextStyle(
                            color: ColorManger.black,
                            height: 1.4,
                            fontSize: FontSize.s15,
                            fontWeight: FontWeightManager.regular,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                CustomText(
                  text: model.hospitalName ?? '',
                  textStyle: TextStyle(
                    color: ColorManger.slateGrey,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
                SizedBox(height: 10.h),

                Row(
                  children: [
                    InfoRow(
                      icon: Icons.calendar_month,
                      text: formatter.format(model.date ?? DateTime.now()),
                    ),
                    SizedBox(width: 20.w),
                    InfoRow(icon: Icons.access_time, text: model.timeSlot ?? ''),
                  ],
                ),
                SizedBox(height: 10.h),
                Divider(color: ColorManger.brightRed, thickness: 1.h),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: constraints.maxWidth,
                              minHeight: 50,
                            ),
                            child: CustomElevatedButton(
                              backgroundColor: ColorManger.pureWhite,
                              foregroundColor: ColorManger.black,
                              elevation: 4,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 10.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              onPressed: () =>
                                  _cancelAppointment(context, appLocalization),
                              child: CustomText(text: appLocalization.cancel),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: constraints.maxWidth,
                              minHeight: 50,
                            ),
                            child: CustomElevatedButton(
                              backgroundColor: ColorManger.brightRed,
                              foregroundColor: ColorManger.pureWhite,
                              elevation: 4,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 10.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              onPressed: () =>
                                  _rescheduleAppointment(context, appLocalization),
                              child: CustomText(text: appLocalization.reschedule),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },);
  }

  void _cancelAppointment(
    BuildContext context,
    AppLocalizations appLocalization,
  ) {
    //TODO: cancel appointment
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: CustomText(text: appLocalization.appointmentCancelled)),
    );
  }

  void _rescheduleAppointment(
    BuildContext context,
    AppLocalizations appLocalization,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: CustomText(
          text: appLocalization.rescheduleAppointmentTitle,
          textStyle: TextStyle(
            color: ColorManger.black,
            height: 1.4,
            fontSize: FontSize.s15,
            fontWeight: FontWeightManager.regular,
          ),
        ),
        content: CustomText(
          text: appLocalization.rescheduleAppointmentMessage,
          textStyle: TextStyle(
            color: ColorManger.slateGrey,
            height: 1.4,
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
          ),
        ),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              CustomElevatedButton(
                backgroundColor: ColorManger.brightRed,
                foregroundColor: ColorManger.pureWhite,
                elevation: 4,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, RouteManger.scheduleDonation);
                },
                child: CustomText(text: appLocalization.chooseNewDateTime),
              ),
              SizedBox(height: 10.h),
              CustomElevatedButton(
                backgroundColor: ColorManger.pureWhite,
                foregroundColor: ColorManger.black,
                elevation: 4,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                onPressed: () {
                  Navigator.of(context);
                },
                child: CustomText(text: appLocalization.cancelDonation),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
