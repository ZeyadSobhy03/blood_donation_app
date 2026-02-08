import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_drop_down_button_form_field.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/find/widgets/custom_hospital_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BloodFilter extends StatefulWidget {
  const BloodFilter({
    super.key,
    required this.onBloodTypeChanged,
    required this.onClear,
  });

  final void Function(String?) onBloodTypeChanged;
  final VoidCallback onClear;

  @override
  State<BloodFilter> createState() => _BloodFilterState();
}

class _BloodFilterState extends State<BloodFilter> {
  String? selectDonationType;

  @override
  Widget build(BuildContext context) {
    List<String> donationTypes = [
      'A+',
      'A-',
      'B+',
      'B-',
      'AB+',
      'AB-',
      'O+',
      'O-',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomText(
          text: 'Blood Type',
          textStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManger.slateGrey,
          ),
        ),
        SizedBox(height: 4.h),
        CustomDropDownButtonFormField(
          items: donationTypes,
          hintText: 'All Blood Type',
          initialValue: selectDonationType,
          onChanged: (value) {
            setState(() {
              selectDonationType = value;
            });
            widget.onBloodTypeChanged(value);
          },
        ),
        SizedBox(height: 4.h),
        CustomHospitalButton(
          onPressed: () {
            setState(() {
              selectDonationType = null;
            });
            widget.onClear();
          },
          widget: CustomText(
            text: 'Clear Filter',
            textStyle: TextStyle(
              color: ColorManger.black,
              fontWeight: FontWeightManager.regular,
              fontSize: FontSize.s16,
            ),
          ),
        ),
        SizedBox(height: 4.h),
      ],
    );
  }
}
