import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/custom_drop_down_button_form_field.dart';
import '../../../../../../core/widgets/custom_label.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../donor/tabs/donate/presentation/view/schedule_donation/widgets/custom_text_form_field.dart';
import '../../../../donor/tabs/donate/presentation/view/schedule_donation/widgets/input_label.dart';

class RequestDetailBody extends StatefulWidget {
  const RequestDetailBody({super.key});

  @override
  State<RequestDetailBody> createState() => _RequestDetailBodyState();
}

class _RequestDetailBodyState extends State<RequestDetailBody> {
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
  late TextEditingController _unitsController;
  String? _selectedUrgency;

  String? _selectedBloodType;

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
    final List<String> urgencyLevels = [
      appLocalizations.urgency_low,
      appLocalizations.urgency_medium,
      appLocalizations.urgency_high,
    ];
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(text: appLocalizations.blood_type_needed),
          SizedBox(height: 8),
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
        ],
      ),
    );
  }
}
