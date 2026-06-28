
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_note_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/presentation/view_model/appointments/appointments_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../../core/utils/error_localizer.dart';
import '../../../../../../../../../l10n/app_localizations.dart';
import '../cubit/donation_schedule.dart';
import '../widgets/navigation_button.dart';
import '../widgets/review_card.dart';
import '../widgets/title_step.dart';


class ReviewAndConfirm extends StatefulWidget {
  const ReviewAndConfirm({
    super.key,
    required this.next,
    this.isReschedule = false,
    this.appointmentId,
  });

  final VoidCallback next;
  final bool isReschedule;
  final String? appointmentId;

  @override
  State<ReviewAndConfirm> createState() => _ReviewAndConfirmState();
}

class _ReviewAndConfirmState extends State<ReviewAndConfirm> {
  @override
  Widget build(BuildContext context) {

    final appLocalization = AppLocalizations.of(context)!;

    return BlocListener<AppointmentsCubit, AppointmentsState>(
      listener: (context, state) {
        if (state is BookAppointmentSuccessState) {
          widget.next();
        } else if (state is RescheduleAppointmentSuccessState) {
          widget.next();
        } else if (state is BookAppointmentErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(localizeError(state.error, appLocalization)),
              backgroundColor: Colors.red,
            ),
          );
          Navigator.pushNamed(context, RouteManger.donorMainLayout);
        } else if (state is RescheduleAppointmentErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(localizeError(state.error, appLocalization)),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TitleStep(
                  title: appLocalization.reviewConfirmTitle,
                  subTitle: appLocalization.reviewConfirmSubtitle,
                ),
                ReviewCard(),
                SizedBox(height: 4.h),
                CustomNoteCard(
                  title: appLocalization.beforeYouDonate,
                  items: [
                    appLocalization.donationTipEat,
                    appLocalization.donationTipWater,
                    appLocalization.donationTipId,
                    appLocalization.donationTipSleep,
                  ],
                  borderColor: ColorManger.goldBorder,
                  bulletColor: ColorManger.bulletBrown,
                  cardColor: ColorManger.lightCream,
                  textColor: ColorManger.textGold,
                ),
                SizedBox(height: 4.h),
                BlocBuilder<AppointmentsCubit, AppointmentsState>(
                  builder: (context, state) {
                    final isLoading =
                        state is BookAppointmentLoadingState ||
                        state is RescheduleAppointmentLoadingState;

                    return NavigationButton(
                      foregroundColor: ColorManger.pureWhite,
                      backgroundColor: ColorManger.brightRed,
                      nextStep: isLoading
                          ? null
                          : () => _handleAppointmentAction(context),
                      text: isLoading
                          ? appLocalization.processing
                          : (widget.isReschedule
                              ? appLocalization.reschedule
                              : appLocalization.confirmAppointment),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleAppointmentAction(BuildContext context) {
    final scheduleState = context.read<DonationScheduleCubit>().state.schedule;

    if (!widget.isReschedule) {
      _bookAppointment(context, scheduleState);
    } else {
      _rescheduleAppointment(context, scheduleState);
    }
  }

  void _bookAppointment(BuildContext context, dynamic scheduleState) {
    if (scheduleState.hospitalId == null || scheduleState.hospitalId!.isEmpty) {
      return;
    }

    if (scheduleState.date == null) {
      _showError(context, 'Date is required - please select a date');
      return;
    }

    if (scheduleState.donationType == null || scheduleState.donationType!.isEmpty) {
      _showError(context, 'Donation type is required');
      return;
    }

    final date = scheduleState.date!;
    final timeSlot = scheduleState.timeSlot ?? '09:00 AM';
    final donationTypeMap = {
      'بلازما': 'Plasma',
      'دم كامل': 'Whole Blood',
      'صفائح دموية': 'Platelets',
      'خلايا حمراء': 'Red Cells',
      'Plasma': 'Plasma',
      'Whole Blood': 'Whole Blood',
      'Platelets': 'Platelets',
      'Red Cells': 'Red Cells',
    };

    final appointmentDateString = _parseTimeSlot(date, timeSlot).toIso8601String();
    final rawType = scheduleState.donationType!;

    final mappedDonationType = donationTypeMap[rawType] ?? rawType;
    context.read<AppointmentsCubit>().bookAppointment(
      hospitalId: scheduleState.hospitalId!,
      appointmentDate: appointmentDateString,
      donationType: mappedDonationType,
      notes: 'Scheduled appointment',
    );
  }

  void _rescheduleAppointment(BuildContext context, dynamic scheduleState) {
    if (scheduleState.date == null) {
      _showError(context, 'Date is required - please select a date');
      return;
    }

    if (scheduleState.donationType == null || scheduleState.donationType!.isEmpty) {
      _showError(context, 'Donation type is required');
      return;
    }

    final date = scheduleState.date!;
    final timeSlot = scheduleState.timeSlot ?? '09:00 AM';
    final donationTypeMap = {
      'بلازما': 'Plasma',
      'دم كامل': 'Whole Blood',
      'صفائح دموية': 'Platelets',
      'خلايا حمراء': 'Red Cells',
      'Plasma': 'Plasma',
      'Whole Blood': 'Whole Blood',
      'Platelets': 'Platelets',
      'Red Cells': 'Red Cells',
    };

    final appointmentDateString = _parseTimeSlot(date, timeSlot).toIso8601String();
    final rawType = scheduleState.donationType!;

    final mappedDonationType = donationTypeMap[rawType] ?? rawType;

    context.read<AppointmentsCubit>().rescheduleAppointment(
      appointmentId: widget.appointmentId ?? '',
      appointmentDate: appointmentDateString,
      donationType: mappedDonationType,
      notes: 'Rescheduled appointment',
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // ✅ Fixed: use DateTime.utc and pass timeOfDay.hour + timeOfDay.minute
  DateTime _parseTimeSlot(DateTime date, String timeSlot) {
    try {
      final formats = [
        DateFormat('hh:mm a'),
        DateFormat('HH:mm'),
        DateFormat('h:mm a'),
      ];

      DateTime? timeOfDay;

      for (var format in formats) {
        try {
          timeOfDay = format.parse(timeSlot);
          break;
        } catch (_) {
          continue;
        }
      }

      if (timeOfDay == null) {
        return DateTime.utc(date.year, date.month, date.day, 12, 0);
      }

      return DateTime.utc(
        date.year,
        date.month,
        date.day,
        timeOfDay.hour,
        timeOfDay.minute,
      );
    } catch (_) {
      return DateTime.utc(date.year, date.month, date.day, 12, 0);
    }
  }
}