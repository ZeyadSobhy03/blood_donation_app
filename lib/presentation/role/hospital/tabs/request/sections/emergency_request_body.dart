import 'package:flutter/material.dart';
import '../../../../../../core/widgets/custom_drop_down_button_form_field.dart';
import '../../../../../../core/widgets/custom_label.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';

class EmergencyRequestBody extends StatelessWidget {
  const EmergencyRequestBody({
    super.key,
    required this.unitsController,
    required this.patientDetailsController,
    required this.selectedBloodType,
    required this.onBloodTypeChanged,
  });

  final TextEditingController unitsController;
  final TextEditingController patientDetailsController;
  final String? selectedBloodType;
  final void Function(dynamic) onBloodTypeChanged;

  static const List<String> _bloodTypes = [
    'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-',
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(text: loc.blood_type_needed),
        const SizedBox(height: 8),
        CustomDropDownButtonFormField(
          items: _bloodTypes,
          hintText: loc.select_blood_type,
          onChanged: onBloodTypeChanged,
          initialValue: selectedBloodType,
        ),
        const SizedBox(height: 8),
        CustomLabel(text: loc.units_needed),
        const SizedBox(height: 8),
        CustomTextFormField(
          textEditingController: unitsController,
          keyboardType: TextInputType.number,
          hintText: loc.enter_units_needed,
        ),
        const SizedBox(height: 8),
        CustomLabel(text: loc.patient_details),
        const SizedBox(height: 8),
        CustomTextFormField(
          maxLines: 4,
          hintText: loc.enter_patient_details,
          keyboardType: TextInputType.multiline,
          textEditingController: patientDetailsController,
        ),
      ],
    );
  }
}