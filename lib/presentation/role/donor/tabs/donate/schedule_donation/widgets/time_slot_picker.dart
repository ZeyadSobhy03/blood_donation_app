import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

    return DropdownButtonFormField<String>(
      style: TextStyle(
        color: ColorManger.black
      ),
      initialValue: selectedTime,
      isExpanded: true,
      icon: Icon(Icons.keyboard_arrow_down, color: ColorManger.slateGrey,size: 20,),

      decoration: InputDecoration(

        filled: true,
        fillColor: ColorManger.lightGrey,

        prefixIcon: Icon(widget.icon, color: ColorManger.slateGrey),

        hintText: appLocalizations.chooseTimeSlot,

        hintStyle: TextStyle(
          color: ColorManger.grey600,
          fontSize: FontSize.s14,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 14.h,horizontal: 12),
      ),

      items: timeSlots
          .map(
            (time) => DropdownMenuItem<String>(
          value: time,
          child: CustomText(text: time),
        ),
      )
          .toList(),

      onChanged: (value) {
        setState(() {
          selectedTime = value;
        });
        widget.onChanged(value!);
      },
    );
  }
}


