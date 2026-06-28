import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/extension/data_ex.dart';
import '../../../../../../../../core/utils/appointment_status_utils.dart';
import '../../../../find_hospital/presentation/view/widgets/info_row.dart';
import '../../view_model/appointments/appointments_view_model.dart';
import '../section/reschedule_appointment.dart';

class DonationBookingCard extends StatelessWidget {
  const DonationBookingCard({super.key, required this.appointment});

  final Appointments appointment;

  bool _isAppointmentCancelled() {
    return appointment.status?.toLowerCase() == 'cancelled';
  }

  // Helper method to localize the donation type
  String _localizeDonationType(String? type, AppLocalizations appLocalization) {
    if (type == null) return '';

    // Normalize the string to lowercase and remove spaces/underscores for easier matching
    final normalizedType = type.toLowerCase().replaceAll(' ', '').replaceAll('_', '');

    switch (normalizedType) {
      case 'wholeblood':
        return appLocalization.wholeBlood;
      case 'plasma':
        return appLocalization.plasma;
      case 'platelets':
        return appLocalization.platelets;
      case 'doubleredcells':
        return appLocalization.doubleRedCells;
      default:
      // Fallback to the raw string if it doesn't match known types
        return type;
    }
  }

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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomText(
                          // UPDATED: Using the new localization helper
                          text: _localizeDonationType(appointment.donationType, appLocalization),
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
                          color: AppointmentStatusUtils.statusBackgroundColor(
                            appointment.status,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: CustomText(
                            text: AppointmentStatusUtils.localizeStatus(
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

                  CustomText(
                    text:
                    appointment.hospitalId?.hospitalName ??
                        appLocalization.hospitalName,
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
                        text:
                        appointment.appointmentDate
                            .toFormattedDate()
                            .isNotEmpty
                            ? appointment.appointmentDate.toFormattedDate()
                            : appLocalization.noDataFound,
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  Divider(color: ColorManger.brightRed, thickness: 1.h),

                  SizedBox(height: 10.h),

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
                            fontWeight: FontWeightManager.regular,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.h),

                  if (!_isAppointmentCancelled())
                    Row(
                      children: [
                        Expanded(
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
                        ),

                        SizedBox(width: 20.w),

                        Expanded(
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
                            onPressed: () => _rescheduleAppointment(
                              context,
                              appLocalization,
                            ),
                            child: CustomText(text: appLocalization.reschedule),
                          ),
                        ),
                      ],
                    ),

                  if (_isAppointmentCancelled())
                    Center(
                      child: CustomText(
                        text: appLocalization.appointmentCancelled,
                        textStyle: TextStyle(
                          color: ColorManger.brightRed,
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.regular,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _cancelAppointment(
      BuildContext context,
      AppLocalizations appLocalization,
      ) {
    if (appointment.status?.toLowerCase() == 'cancelled') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          title: CustomText(
            text: appLocalization.alreadyCancelled,
            textStyle: TextStyle(
              color: ColorManger.black,
              fontSize: FontSize.s15,
              fontWeight: FontWeightManager.regular,
            ),
          ),
          content: CustomText(
            text: appLocalization.alreadyCancelledMessage,
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
                  onPressed: () => Navigator.pop(context),
                  child: CustomText(text: appLocalization.ok),
                ),
              ],
            ),
          ],
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: CustomText(
          text: appLocalization.cancelAppointmentTitle,
          textStyle: TextStyle(
            color: ColorManger.black,
            fontSize: FontSize.s15,
            fontWeight: FontWeightManager.regular,
          ),
        ),
        content: CustomText(
          text: appLocalization.cancelAppointmentMessage,
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
              CustomElevatedButton(
                backgroundColor: ColorManger.brightRed,
                foregroundColor: ColorManger.pureWhite,
                elevation: 4,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  context.read<AppointmentsCubit>().cancelAppointment(
                    appointment.appointmentId!,
                  );
                },
                child: CustomText(text: appLocalization.confirm),
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
      builder: (_) => BlocProvider.value(
        value: context.read<AppointmentsCubit>(),
        child: RescheduleDialog(appointment: appointment),
      ),
    );
  }
}