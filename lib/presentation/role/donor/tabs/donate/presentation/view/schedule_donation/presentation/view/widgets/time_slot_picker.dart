import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_drop_down_button_form_field.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../../l10n/app_localizations.dart';
import '../../../data/models/time_slots/time_slots_model.dart';




class TimeSlotPicker extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? selectedValue;
  final IconData icon;
  final List<String> slots;
  final List<TimeSlotDetail>? slotDetails;
  final bool isLoading;

  const TimeSlotPicker({
    super.key,
    required this.onChanged,
    required this.icon,
    required this.slots,
    this.slotDetails,
    this.selectedValue,
    this.isLoading = false,
  });

  @override
  State<TimeSlotPicker> createState() => _TimeSlotPickerState();
}

class _TimeSlotPickerState extends State<TimeSlotPicker> {
  String? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.selectedValue;
  }

  @override
  void didUpdateWidget(covariant TimeSlotPicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.slots.join(',') != widget.slots.join(',')) {
      setState(() {
        selectedTime = null;
      });
    }

    if (widget.selectedValue != oldWidget.selectedValue) {
      setState(() {
        selectedTime = widget.selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    if (widget.isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: CircularProgressIndicator(
            color: ColorManger.brightRed,
          ),
        ),
      );
    }

    // Build display items with capacity information
    final displayItems = <String>[];
    for (int i = 0; i < widget.slots.length; i++) {
      final slot = widget.slots[i];
      final detail = widget.slotDetails != null && i < widget.slotDetails!.length
          ? widget.slotDetails![i]
          : null;

      if (detail != null && detail.maxCapacity != null && detail.remainingCapacity != null) {
        displayItems.add(
          '$slot - ${detail.remainingCapacity}/${detail.maxCapacity} ${appLocalizations.timeSlotSlots}',
        );
      } else {
        displayItems.add(slot);
      }
    }

    return CustomDropDownButtonFormField(
      items: displayItems,
      hintText: appLocalizations.chooseTimeSlot,
      prefixIcon: Icon(
        widget.icon,
        color: ColorManger.slateGrey,
      ),

      // تأكد إن القيمة موجودة داخل الـ items
      initialValue:
      widget.slots.contains(selectedTime)
          ? (widget.slotDetails != null
              ? _getDisplayValue(selectedTime, appLocalizations, context)
              : selectedTime)
          : null,

      onChanged: (value) {
        setState(() {
          // Extract time from display value if needed
          String timeValue = value ?? '';
          if (widget.slotDetails != null && value != null && value.contains(' - ')) {
            // Extract time from formatted string (e.g., "09:00 AM - 3/5 slots")
            timeValue = value.split(' - ')[0].trim();
          }
          selectedTime = timeValue;
        });

        if (value != null) {
          // Get the actual time slot
          String timeValue = value;
          if (widget.slotDetails != null && value.contains(' - ')) {
            timeValue = value.split(' - ')[0].trim();
          }
          widget.onChanged(timeValue);
        }
      },
    );
  }

  String _getDisplayValue(String? selectedTime, AppLocalizations appLocalizations, BuildContext context) {
    if (selectedTime == null) return '';

    final index = widget.slots.indexOf(selectedTime);
    if (index == -1 || widget.slotDetails == null || index >= widget.slotDetails!.length) {
      return selectedTime;
    }

    final detail = widget.slotDetails![index];
    if (detail.maxCapacity != null && detail.remainingCapacity != null) {
      return '${detail.time} - ${detail.remainingCapacity}/${detail.maxCapacity} ${appLocalizations.timeSlotSlots}';
    }
    return detail.time;
  }
}