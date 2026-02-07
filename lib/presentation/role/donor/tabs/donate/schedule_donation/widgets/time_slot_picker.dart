import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../l10n/app_localizations.dart';

class TimeSlotPicker extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? selectedValue;

  const TimeSlotPicker({
    super.key,
    required this.onChanged,
    this.selectedValue,
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

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: ColorManger.lightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(16),
            value: selectedTime,
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down, color: ColorManger.slateGrey),
            hint: Row(
              children: [
                Icon(Icons.access_time, color: ColorManger.grey600, size: 18),
                SizedBox(width: 8.w),
                CustomText(
                  text: appLocalizations.chooseTimeSlot,
                  textStyle: TextStyle(
                    color: ColorManger.grey600,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
              ],
            ),
            items: timeSlots.map((time) {
              return DropdownMenuItem<String>(
                value: time,
                child: CustomText(
                  text: time,
                  textStyle: TextStyle(
                    color: ColorManger.black,
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedTime = value;
                widget.onChanged(value!);
              });
            },
          ),
        ),
      ),
    );
  }
}

