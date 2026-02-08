import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_drop_down_button_form_field.dart';
import 'package:flutter/material.dart';

import '../../../../../../../l10n/app_localizations.dart';

class TimeSlotPicker extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? selectedValue;
  final IconData icon;

  const TimeSlotPicker({
    super.key,
    required this.onChanged,
    this.selectedValue,
    required this.icon,
  });

  @override
  State<TimeSlotPicker> createState() => _TimeSlotPickerState();
}

class _TimeSlotPickerState extends State<TimeSlotPicker> {
  String? selectedTime;

  final List<String> timeSlots = [
    "9:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "2:00 PM",
    "3:00 PM",
    "4:00 PM",
  ];

  @override
  void initState() {
    super.initState();
    selectedTime = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return CustomDropDownButtonFormField(items: timeSlots, hintText:  appLocalizations.chooseTimeSlot,

    prefixIcon:Icon(widget.icon, color: ColorManger.slateGrey),
      initialValue: selectedTime,
      onChanged: (value) {
        setState(() {
          selectedTime = value;
        });
        widget.onChanged(value!);
      },
    );
  }
}



