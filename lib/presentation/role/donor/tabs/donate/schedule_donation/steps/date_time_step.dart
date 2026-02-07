import 'package:blood_donation_app/core/widgets/custom_dropdown.dart';

import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/donation_type_picker.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/input_label.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/navigation_button.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/note_card.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/time_slot_picker.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/title_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../l10n/app_localizations.dart';
import '../cubit/donation_schedule.dart';

class DateTimeStep extends StatefulWidget {
  const DateTimeStep({super.key, required this.next});

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

  _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: selectedDate ?? DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (picked != null && mounted) {
      context.read<DonationScheduleCubit>().setDate(picked);
      setState(() {
        selectedDate = picked;
      });
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
      builder: (context, state) {
        selectedDate = state.schedule.date;
        selectedTime = state.schedule.timeSlot;
        selectedDonationType = state.schedule.donationType;

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
                  NoteCard(),
                  InputLabel(label: appLocalization.selectDateLabel),
                  InkWell(
                    onTap: _pickDate,
                    child: CustomDropdown(
                      icon: Icons.calendar_today,
                      text: formattedDate(appLocalization),
                    ),
                  ),
                  InputLabel(label: appLocalization.selectTimeLabel),
                  TimeSlotPicker(
                    selectedValue: selectedTime,
                    onChanged: (value) {
                      context.read<DonationScheduleCubit>().setTimeSlot(value);
                    },
                  ),
                  InputLabel(label: appLocalization.donationTypeLabel),
                  DonationTypePicker(
                    selectedValue: selectedDonationType,

                    onChanged: (value) {
                      context.read<DonationScheduleCubit>().setDonationType(
                        value,
                      );
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
}
