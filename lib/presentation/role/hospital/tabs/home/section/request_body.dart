import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_drop_down_button_form_field.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../donor/tabs/donate/presentation/view/schedule_donation/widgets/custom_text_form_field.dart';
import '../../../../donor/tabs/donate/presentation/view/schedule_donation/widgets/input_label.dart';

class RequestBody extends StatefulWidget {
  const RequestBody({super.key});

  @override
  State<RequestBody> createState() => _RequestBodyState();
}

class _RequestBodyState extends State<RequestBody> {
  String? _selectedBloodType;
  late TextEditingController _unitsController;
  String? _selectedUrgency;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _unitsController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _unitsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final List<String> bloodTypes = [
      'A+',
      'A-',
      'B+',
      'B-',
      'O+',
      'O-',
      'AB+',
      'AB-',
    ];
    final List<String> urgencyLevels = [
      appLocalizations.urgency_low,
      appLocalizations.urgency_medium,
      appLocalizations.urgency_high,
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,

        children: [
          InputLabel(label: appLocalizations.blood_type),
          SizedBox(height: 8.h),
          CustomDropDownButtonFormField(
            items: bloodTypes,
            hintText: appLocalizations.select_blood_type,
            onChanged: (p0) {
              setState(() {
                _selectedBloodType = p0!;
              });
            },
            initialValue: _selectedBloodType,
          ),
          SizedBox(height: 8.h),
          InputLabel(label: appLocalizations.units_needed),
          SizedBox(height: 8.h),
          CustomTextFormField(
            textEditingController: _unitsController,
            keyboardType: TextInputType.number,
            hintText: appLocalizations.enter_units_needed,
          ),
          SizedBox(height: 8.h),
          InputLabel(label: appLocalizations.urgency),
          SizedBox(height: 8.h),
          CustomDropDownButtonFormField(
            items: urgencyLevels,
            hintText: appLocalizations.select_urgency,
            onChanged: (p0) {
              setState(() {
                _selectedUrgency = p0!;
              });
            },
            initialValue: _selectedUrgency,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Spacer(),
              CustomElevatedButton(
                backgroundColor: ColorManger.brightRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                onPressed: () {

                },
                foregroundColor: ColorManger.pureWhite,
                elevation: 3,
                child: CustomText(
                  text: appLocalizations.submit_request,
                  textStyle: TextStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
