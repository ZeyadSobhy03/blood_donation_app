

import 'package:blood_donation_app/core/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


import '../../../../../../../../../../../core/cubits/donation_schedule.dart';
import '../../../../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../../../hospital/tabs/find_donor/widgets/note_card.dart';
import '../../../data/models/time_slots/time_slots_model.dart';
import '../../view_model/time_slots/time_slots_view_model.dart';
import '../widgets/donation_type_picker.dart';
import '../widgets/input_label.dart';
import '../widgets/navigation_button.dart';
import '../widgets/time_slot_picker.dart';
import '../widgets/title_step.dart';

class DateTimeStep extends StatefulWidget {
  const DateTimeStep({super.key, required this.next, });

  final VoidCallback next;

  @override
  State<DateTimeStep> createState() => _DateTimeStepState();
}

class _DateTimeStepState extends State<DateTimeStep> {
  DateTime? selectedDate;
  String? selectedTime;
  String? selectedDonationType;

  bool get canContinue =>
      selectedDate != null &&
          selectedTime != null &&
          selectedDonationType != null;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: selectedDate ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
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
        );
      },
    );

    if (picked != null && mounted) {
      context.read<DonationScheduleCubit>().setDate(picked);
      context.read<DonationScheduleCubit>().setTimeSlot(null);

      setState(() {
        selectedDate = picked;
        selectedTime = null;
      });
      final hospitalId = context
          .read<DonationScheduleCubit>()
          .state
          .schedule
          .hospitalId ?? '';

      final dateString = DateFormat('yyyy-MM-dd').format(picked);
      context.read<TimeSlotsCubit>().fetchTimeSlots(
        hospitalId: hospitalId,
        date: dateString,
      );
    }
  }

  String formattedDate(AppLocalizations l10n) {
    if (selectedDate == null) return l10n.datePlaceholder;
    return DateFormat.yMd(l10n.localeName).format(selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return BlocBuilder<DonationScheduleCubit, DonationScheduleState>(
      builder: (context, scheduleState) {
        selectedDate = scheduleState.schedule.date;
        selectedTime = scheduleState.schedule.timeSlot;
        selectedDonationType = scheduleState.schedule.donationType;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TitleStep(
                    title: appLocalization.selectDateTimeTitle,
                    subTitle: appLocalization.selectDateTimeSubtitle,
                  ),
                  SizedBox(height: 4.h),
                  const NoteCard(),
                  InputLabel(label: appLocalization.selectDateLabel),
                  InkWell(
                    onTap: _pickDate,
                    child: CustomDropdown(
                      icon: Icons.calendar_today,
                      text: formattedDate(appLocalization),
                    ),
                  ),
                  InputLabel(label: appLocalization.selectTimeLabel),
                  BlocBuilder<TimeSlotsCubit, TimeSlotsState>(

                    builder: (context, timeSlotsState) {
                      final slots = _resolveSlots(timeSlotsState);
                      final slotDetails = _resolveSlotDetails(timeSlotsState);

                      return TimeSlotPicker(
                        key: ValueKey(slots.isEmpty ? 'empty' : slots.join(',')),
                        icon: Icons.access_time,
                        slots: slots,
                        slotDetails: slotDetails,
                        isLoading: timeSlotsState is TimeSlotsLoadingState,
                        selectedValue: selectedTime,
                        onChanged: (value) {
                          context
                              .read<DonationScheduleCubit>()
                              .setTimeSlot(value);
                        },
                      );
                    },
                  ),
                  InputLabel(label: appLocalization.donationTypeLabel),
                  DonationTypePicker(
                    selectedValue: selectedDonationType,
                    prefixIcon: Icon(
                      Icons.favorite_border,
                      color: ColorManger.slateGrey,
                    ),
                    onChanged: (value) {
                      context
                          .read<DonationScheduleCubit>()
                          .setDonationType(value);
                    },
                  ),
                  SizedBox(height: 8.h),
                  NavigationButton(
                    foregroundColor: ColorManger.pureWhite,
                    backgroundColor: ColorManger.brightRed,
                    nextStep: canContinue ? widget.next : null,
                    text: appLocalization.continueStep,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  List<String> _resolveSlots(TimeSlotsState state) {
    if (state is TimeSlotsSuccessState) {
      return state.timeSlots.data?.timeSlots ?? [];
    }
    return [];
  }

  List<TimeSlotDetail>? _resolveSlotDetails(TimeSlotsState state) {
    if (state is TimeSlotsSuccessState) {
      return state.timeSlots.data?.timeSlotDetails;
    }
    return null;
  }
}