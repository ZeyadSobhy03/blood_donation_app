import 'dart:developer';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/data/model/appointment/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../view_model/appointments/appointments_view_model.dart';
import '../schedule_donation/widgets/donation_type_picker.dart';

class RescheduleDialog extends StatefulWidget {
  const RescheduleDialog({super.key, required this.appointment});

  final Appointments appointment;

  @override
  State<RescheduleDialog> createState() => _RescheduleDialogState();
}

class _RescheduleDialogState extends State<RescheduleDialog> {
  DateTime? selectedDate;
  String? selectedDonationType;
  bool _isLoading = false;

  bool get _canConfirm =>
      selectedDate != null && selectedDonationType != null && !_isLoading;

  Future<void> _pickDate() async {
    if (_isLoading) return;
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: selectedDate ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: ColorManger.brightRed,
            onPrimary: ColorManger.pureWhite,
            surface: ColorManger.pureWhite,
            onSurface: ColorManger.black,
          ),
          dialogTheme: DialogThemeData(
            backgroundColor: ColorManger.pureWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null && mounted) {
      setState(() => selectedDate = picked);
    }
  }

  String _formattedDate(AppLocalizations l10n) {
    if (selectedDate == null) return l10n.datePlaceholder;
    return DateFormat.yMd(l10n.localeName).format(selectedDate!);
  }

  void _confirm(BuildContext context) {
    if (!_canConfirm) return;
    final dateString = selectedDate!.toIso8601String();
    final cubit = context.read<AppointmentsCubit>();
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

    cubit.rescheduleAppointment(
      appointmentId: widget.appointment.appointmentId!,
      appointmentDate: dateString,
      donationType: donationTypeMap[selectedDonationType!]!,
      notes: widget.appointment.notes ?? '',
    );
  }

  void _showResultDialog({
    required BuildContext context,
    required bool isSuccess,
    required String message,
  }) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: ColorManger.pureWhite,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: isSuccess
                    ? ColorManger.brightRed.withValues(alpha: 0.1)
                    : Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSuccess ? Icons.check_circle_outline : Icons.error_outline,
                color: isSuccess ? ColorManger.brightRed : Colors.red.shade700,
                size: 36.sp,
              ),
            ),
            SizedBox(height: 16.h),
            CustomText(
              text: isSuccess ? l10n.rescheduleSuccess : l10n.rescheduleError,
              textStyle: TextStyle(
                color: ColorManger.black,
                fontSize: FontSize.s15,
                fontWeight: FontWeightManager.semiBold,
                height: 1.4,
              ),
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: message,
              textStyle: TextStyle(
                color: ColorManger.slateGrey,
                fontSize: FontSize.s13,
                fontWeight: FontWeightManager.regular,
                height: 1.4,
              ),
            ),
            SizedBox(height: 20.h),
            CustomElevatedButton(
              backgroundColor: ColorManger.brightRed,
              foregroundColor: ColorManger.pureWhite,
              elevation: 4,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pop();

                if (isSuccess) {
                  context.read<AppointmentsCubit>().fetchAppointments();
                }
              },
              child: CustomText(text: l10n.ok),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<AppointmentsCubit, AppointmentsState>(
      listener: (listenerContext, state) {
        if (state is RescheduleAppointmentLoadingState) {
          log("state is $state");
          if (mounted) setState(() => _isLoading = true);
        } else if (state is RescheduleAppointmentSuccessState) {
          log("state is $state");
          if (mounted) setState(() => _isLoading = false);
          _showResultDialog(
            context: context,
            isSuccess: true,
            message: l10n.rescheduleSuccessMessage,
          );
        } else if (state is RescheduleAppointmentErrorState) {
          log("state is ${state.error}");
          if (mounted) setState(() => _isLoading = false);
          _showResultDialog(
            context: context,
            isSuccess: false,
            message: localizeError(state.error, l10n),
          );
        }
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: ColorManger.pureWhite,
        title: CustomText(
          text: l10n.rescheduleAppointmentTitle,
          textStyle: TextStyle(
            color: ColorManger.black,
            height: 1.4,
            fontSize: FontSize.s15,
            fontWeight: FontWeightManager.semiBold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomText(
                text: l10n.selectDateLabel,
                textStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  fontSize: FontSize.s13,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
              SizedBox(height: 6.h),
              InkWell(
                onTap: _pickDate,
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorManger.slateGrey),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: ColorManger.slateGrey,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: CustomText(
                          text: _formattedDate(l10n),
                          textStyle: TextStyle(
                            color: selectedDate != null
                                ? ColorManger.black
                                : ColorManger.slateGrey,
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.regular,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              CustomText(
                text: l10n.donationTypeLabel,
                textStyle: TextStyle(
                  color: ColorManger.slateGrey,
                  fontSize: FontSize.s13,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
              SizedBox(height: 6.h),
              DonationTypePicker(
                selectedValue: selectedDonationType,
                prefixIcon: Icon(
                  Icons.favorite_border,
                  color: ColorManger.slateGrey,
                ),
                onChanged: _isLoading
                    ? (_) {}
                    : (value) => setState(() => selectedDonationType = value),
              ),

              if (_isLoading) ...[
                SizedBox(height: 16.h),
                const CustomLoadingWidget(),
              ],
            ],
          ),
        ),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomElevatedButton(
                backgroundColor: _canConfirm
                    ? ColorManger.brightRed
                    : ColorManger.slateGrey,
                foregroundColor: ColorManger.pureWhite,
                elevation: _canConfirm ? 4 : 0,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                onPressed: _canConfirm ? () => _confirm(context) : null,
                child: CustomText(text: l10n.confirm),
              ),

              SizedBox(height: 10.h),

              CustomElevatedButton(
                backgroundColor: ColorManger.pureWhite,
                foregroundColor: _isLoading
                    ? ColorManger.slateGrey
                    : ColorManger.black,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(color: ColorManger.slateGrey),
                ),
                onPressed: _isLoading
                    ? null
                    : () => Navigator.of(context).pop(),
                child: CustomText(text: l10n.cancel),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
