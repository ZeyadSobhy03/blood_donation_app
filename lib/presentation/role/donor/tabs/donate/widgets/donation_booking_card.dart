import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../find_hospital/presentation/view/widgets/info_row.dart';
import '../presentation/view_model/appointments_view_model.dart';

class DonationBookingCard extends StatelessWidget {
  const DonationBookingCard({
    super.key,
    required this.appointment,
  });

  final Appointments appointment;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: constraints.maxWidth,
            minHeight: 150,
          ),
          child: Card(
            color: ColorManger.lightRed,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Top Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomText(
                          text: appointment.donationType ?? '',
                          textStyle: TextStyle(
                            color: ColorManger.black,
                            height: 1.4,
                            fontSize: FontSize.s15,
                            fontWeight: FontWeightManager.regular,
                          ),
                        ),
                      ),

                      SizedBox(width: 10.w),

                      Container(
                        decoration: BoxDecoration(
                          color: _getStatusColor(appointment.status),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: CustomText(
                            text: _getStatusText(
                              appointment.status,
                              appLocalization,
                            ),
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

                  /// Hospital Name
                  CustomText(
                    text:
                    appointment.hospitalId?.hospitalName ??
                        "No Hospital",
                    textStyle: TextStyle(
                      color: ColorManger.slateGrey,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  /// Date
                  Row(
                    children: [
                      InfoRow(
                        icon: Icons.calendar_month,
                        text:
                        appointment.appointmentDate ??
                            'No Date',
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  Divider(
                    color: ColorManger.brightRed,
                    thickness: 1.h,
                  ),

                  SizedBox(height: 10.h),

                  /// QR Button
                  CustomElevatedButton(
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
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RouteManger.appointmentDetails,
                        arguments: appointment,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code,
                          color: ColorManger.pureWhite,
                          size: 16,
                        ),
                        SizedBox(width: 6.w),
                        CustomText(
                          text: appLocalization.showQrCode,
                          textStyle: TextStyle(
                            color: ColorManger.pureWhite,
                            fontSize: FontSize.s14,
                            fontWeight:
                            FontWeightManager.regular,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.h),

                  /// Bottom Buttons
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          backgroundColor:
                          ColorManger.pureWhite,
                          foregroundColor:
                          ColorManger.black,
                          elevation: 4,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(12.r),
                          ),
                          onPressed: () => _cancelAppointment(
                            context,
                            appLocalization,
                          ),
                          child: CustomText(
                            text: appLocalization.cancel,
                          ),
                        ),
                      ),

                      SizedBox(width: 20.w),

                      Expanded(
                        child: CustomElevatedButton(
                          backgroundColor:
                          ColorManger.brightRed,
                          foregroundColor:
                          ColorManger.pureWhite,
                          elevation: 4,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(12.r),
                          ),
                          onPressed:
                              () => _rescheduleAppointment(
                            context,
                            appLocalization,
                          ),
                          child: CustomText(
                            text:
                            appLocalization.reschedule,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return ColorManger.lightGreen;

      case 'confirmed':
        return ColorManger.green;

      case 'completed':
        return Colors.green.shade200;

      case 'cancelled':
        return Colors.red.shade200;

      case 'rescheduled':
        return Colors.orange.shade200;

      default:
        return Colors.grey.shade300;
    }
  }


  String _getStatusText(
      String? status,
      AppLocalizations appLocalization,
      ) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return appLocalization.pending;

      case 'confirmed':
        return appLocalization.confirmed;

      case 'completed':
        return appLocalization.completed;

      case 'cancelled':
        return appLocalization.cancelled;

      case 'rescheduled':
        return appLocalization.rescheduled;

      default:
        return status ?? appLocalization.unknown;
    }
  }


  void _cancelAppointment(
      BuildContext context,
      AppLocalizations appLocalization,
      ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: CustomText(
          text: appLocalization.cancelAppointmentTitle, // add this string to your l10n
          textStyle: TextStyle(
            color: ColorManger.black,
            fontSize: FontSize.s15,
            fontWeight: FontWeightManager.regular,
          ),
        ),
        content: CustomText(
          text: appLocalization.cancelAppointmentMessage, // add this string too
          textStyle: TextStyle(
            color: ColorManger.slateGrey,
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
          ),
        ),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Confirm cancel
              CustomElevatedButton(
                backgroundColor: ColorManger.brightRed,
                foregroundColor: ColorManger.pureWhite,
                elevation: 4,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                onPressed: () {
                  Navigator.pop(context); // close dialog first
                  context.read<AppointmentsCubit>().cancelAppointment(
                    appointment.id!, // make sure your model has an id field
                  );
                },
                child: CustomText(text: appLocalization.confirm),
              ),

              SizedBox(height: 10.h),

              // Keep appointment
              CustomElevatedButton(
                backgroundColor: ColorManger.pureWhite,
                foregroundColor: ColorManger.black,
                elevation: 4,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                onPressed: () => Navigator.pop(context),
                child: CustomText(text: appLocalization.keepAppointment),
              ),
            ],
          ),
        ],
      ),
    );
  }


  void _rescheduleAppointment(
      BuildContext context,
      AppLocalizations appLocalization,
      ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
        title: CustomText(
          text:
          appLocalization
              .rescheduleAppointmentTitle,
          textStyle: TextStyle(
            color: ColorManger.black,
            height: 1.4,
            fontSize: FontSize.s15,
            fontWeight:
            FontWeightManager.regular,
          ),
        ),

        content: CustomText(
          text:
          appLocalization
              .rescheduleAppointmentMessage,
          textStyle: TextStyle(
            color: ColorManger.slateGrey,
            height: 1.4,
            fontSize: FontSize.s14,
            fontWeight:
            FontWeightManager.regular,
          ),
        ),

        actions: [
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,
            children: [
              CustomElevatedButton(
                backgroundColor:
                ColorManger.brightRed,
                foregroundColor:
                ColorManger.pureWhite,
                elevation: 4,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(12.r),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RouteManger.scheduleDonation,
                  );
                },
                child: CustomText(
                  text:
                  appLocalization
                      .chooseNewDateTime,
                ),
              ),

              SizedBox(height: 10.h),

              CustomElevatedButton(
                backgroundColor:
                ColorManger.pureWhite,
                foregroundColor:
                ColorManger.black,
                elevation: 4,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(12.r),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: CustomText(
                  text:
                  appLocalization
                      .cancelDonation,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}