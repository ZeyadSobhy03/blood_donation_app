import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../l10n/app_localizations.dart';

class DonationTypePicker extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? selectedValue;

  const DonationTypePicker({
    super.key,
    required this.onChanged,
    this.selectedValue,
  });

  @override
  State<DonationTypePicker> createState() => _DonationTypePickerState();
}

class _DonationTypePickerState extends State<DonationTypePicker> {
  String? selectTypeBlood;

  @override
  void initState() {
    super.initState();
    selectTypeBlood = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final List<String> donationSlots = [
      appLocalizations.wholeBlood,
      appLocalizations.plasma,
      appLocalizations.platelets,
      appLocalizations.doubleRedCells,
    ];

    return DropdownButtonFormField<String>(
      isDense: true,
      initialValue: selectTypeBlood,

      isExpanded: true,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: ColorManger.slateGrey,
      ),

      decoration: InputDecoration(

        filled: true,
        fillColor: ColorManger.lightGrey,

        hintText: appLocalizations.chooseBloodType,
        hintStyle: TextStyle(
          color: ColorManger.grey600,
          fontSize: FontSize.s14,
          fontWeight: FontWeightManager.regular,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),

        contentPadding: EdgeInsets.symmetric(
          horizontal: 4.w,
          vertical: 12.h,
        ),
      ),

      items: donationSlots
          .map(
            (type) => DropdownMenuItem<String>(
          value: type,
          child: CustomText(
            text: type,
            textStyle: TextStyle(
              color: ColorManger.black,
              fontSize: FontSize.s16,
              fontWeight: FontWeightManager.regular,
            ),
          ),
        ),
      )
          .toList(),

      onChanged: (value) {
        setState(() {
          selectTypeBlood = value;
        });
        widget.onChanged(value!);
      },
    );
  }
}


