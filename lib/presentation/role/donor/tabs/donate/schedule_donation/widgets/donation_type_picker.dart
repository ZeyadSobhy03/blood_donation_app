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
    selectTypeBlood = widget.selectedValue; }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final List<String> donationSlots = [
      appLocalizations.wholeBlood,
      appLocalizations.plasma,
      appLocalizations.platelets,
      appLocalizations.doubleRedCells,
    ];
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
            value: selectTypeBlood,
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down, color: ColorManger.slateGrey),
            hint: Row(
              children: [
                CustomText(
                  text: appLocalizations.chooseBloodType,
                  textStyle: TextStyle(
                    color: ColorManger.grey600,
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
              ],
            ),
            items: donationSlots.map((type) {
              return DropdownMenuItem<String>(
                value: type,
                child: CustomText(
                  text: type,
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
                selectTypeBlood = value;
                widget.onChanged(value!);
              });
            },
          ),
        ),
      ),
    );
  }
}

