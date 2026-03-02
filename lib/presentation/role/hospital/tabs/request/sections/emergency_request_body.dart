import 'package:flutter/material.dart';

import '../../../../../../core/widgets/custom_drop_down_button_form_field.dart';
import '../../../../../../core/widgets/custom_label.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';

class EmergencyRequestBody extends StatefulWidget {
  const EmergencyRequestBody({super.key});

  @override
  State<EmergencyRequestBody> createState() => _EmergencyRequestBodyState();
}

class _EmergencyRequestBodyState extends State<EmergencyRequestBody> {
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
  late TextEditingController _patientDetailsController;
  String? _selectedBloodType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _unitsController = TextEditingController();
    _patientDetailsController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _unitsController.dispose();
    _patientDetailsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
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
        SizedBox(height: 8),
        CustomLabel(text: appLocalizations.units_needed),
        SizedBox(height: 8),
        CustomTextFormField(
          textEditingController: _unitsController,
          keyboardType: TextInputType.number,
          hintText: appLocalizations.enter_units_needed,
        ),
        SizedBox(height: 8),
        CustomLabel(text: appLocalizations.patient_details),
        SizedBox(height: 8),
        CustomTextFormField(
          maxLines: 4,
          hintText: appLocalizations.enter_patient_details,
          keyboardType: TextInputType.multiline,
          textEditingController: _patientDetailsController,
        ),
      ],
    );
  }
}
