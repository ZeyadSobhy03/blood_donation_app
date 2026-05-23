import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_drop_down_button_form_field.dart';
import 'package:flutter/material.dart';

import '../../../../../../../l10n/app_localizations.dart';

class TimeSlotPicker extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? selectedValue;
  final IconData icon;
  final List<String> slots;
  final bool isLoading;

  const TimeSlotPicker({
    super.key,
    required this.onChanged,
    required this.icon,
    required this.slots,
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

    // لما الـ slots تتغير امسح الاختيار القديم
    if (oldWidget.slots.join(',') != widget.slots.join(',')) {
      setState(() {
        selectedTime = null;
      });
    }

    // Sync مع القيمة القادمة من الـ parent
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
          child: CircularProgressIndicator(),
        ),
      );
    }

    return CustomDropDownButtonFormField(
      items: widget.slots,
      hintText: appLocalizations.chooseTimeSlot,
      prefixIcon: Icon(
        widget.icon,
        color: ColorManger.slateGrey,
      ),

      // تأكد إن القيمة موجودة داخل الـ items
      initialValue:
      widget.slots.contains(selectedTime)
          ? selectedTime
          : null,

      onChanged: (value) {
        setState(() {
          selectedTime = value;
        });

        if (value != null) {
          widget.onChanged(value);
        }
      },
    );
  }
}