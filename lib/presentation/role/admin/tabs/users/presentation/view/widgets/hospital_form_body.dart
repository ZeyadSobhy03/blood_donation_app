import 'package:flutter/material.dart';
import 'package:blood_donation_app/core/extension/text_ex.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';

import '../../../../../../../../core/widgets/custom_drop_down_button_form_field.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../controllers/hospital_form_controllers.dart';
import 'blood_bank_selector.dart';
import 'hospital_form_field.dart';
import 'location_picker_tile.dart';

class HospitalFormBody extends StatelessWidget {
  final HospitalFormControllers controllers;
  final String? selectedHospitalType;
  final ValueChanged<String?> onHospitalTypeChanged;
  final Set<String> selectedBloodBanks;
  final ValueChanged<Set<String>> onBloodBanksChanged;
  final VoidCallback onPickLocation;

  const HospitalFormBody({
    super.key,
    required this.controllers,
    required this.selectedHospitalType,
    required this.onHospitalTypeChanged,
    required this.selectedBloodBanks,
    required this.onBloodBanksChanged,
    required this.onPickLocation,
  });

  List<String> _hospitalTypes(AppLocalizations loc) => [
    loc.governmentHospital,
    loc.privateHospital,
    loc.specializedHospital,
    loc.communityHospital,
    loc.medicalCenter,
  ];

  String? _capacityValidator(String? value, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final requiredMessage = HospitalFormField.requiredValidator(value, context);
    if (requiredMessage != null) return requiredMessage;

    final parsed = int.tryParse(value!.trim());
    if (parsed == null || parsed <= 0) {
      return loc.capacityInvalidError;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),

      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HospitalFormField(
              label: loc.hospitalName,
              hintText: loc.enterHospitalName,
              controller: controllers.name,
            ),
            const SizedBox(height: 16),
            HospitalFormField(
              label: loc.hospital_id,
              hintText: loc.please_enter_hospital_id,
              controller: controllers.hospitalCode,
            ),
            const SizedBox(height: 16),
            CustomLabel(text: loc.type),
            CustomDropDownButtonFormField(
              items: _hospitalTypes(loc),
              hintText: loc.selectHospitalType,
              onChanged: (value) => onHospitalTypeChanged(value as String?),
              initialValue: selectedHospitalType,
            ),
            const SizedBox(height: 16),
            HospitalFormField(
              label: loc.email,
              hintText: loc.enterHospitalEmail,
              controller: controllers.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => (value ?? '').emailValidator(context),
            ),
            const SizedBox(height: 16),
            HospitalFormField(
              label: loc.phone,
              hintText: loc.enterHospitalContactNumber,
              controller: controllers.phone,
              keyboardType: TextInputType.phone,
              validator: (value) => (value ?? '').phoneValidator(context),
            ),
            const SizedBox(height: 16),
            HospitalFormField(
              label: loc.address,
              hintText: loc.enterHospitalAddress,
              controller: controllers.location,
            ),
            const SizedBox(height: 16),
            HospitalFormField(
              label: loc.city,
              hintText: loc.enterCity,
              controller: controllers.city,
            ),
            const SizedBox(height: 16),
            HospitalFormField(
              label: loc.state,
              hintText: loc.enterState,
              controller: controllers.state,
            ),
            const SizedBox(height: 16),
            HospitalFormField(
              label: loc.zipCode,
              hintText: loc.enterZipCode,
              controller: controllers.zipCode,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            HospitalFormField(
              label: loc.capacity,
              hintText: loc.enterCapacity,
              controller: controllers.capacity,
              keyboardType: TextInputType.number,
              validator: (value) => _capacityValidator(value, context),
            ),
            const SizedBox(height: 16),

            LocationPickerTile(
              hasPickedLocation: controllers.hasPickedLocation,
              onTap: onPickLocation,
            ),
            const SizedBox(height: 16),

            BloodBankSelector(
              selected: selectedBloodBanks,
              onChanged: onBloodBanksChanged,
            ),
            const SizedBox(height: 16),

            HospitalFormField(
              label: loc.licenseNumber,
              hintText: loc.enterHospitalLicenseNumber,
              controller: controllers.licenseNumber,
            ),
            const SizedBox(height: 16),
            HospitalFormField(
              label: loc.adminContactName,
              hintText: loc.enterAdminContactName,
              controller: controllers.adminContactName,
            ),
            const SizedBox(height: 16),
            HospitalFormField(
              label: loc.adminContactPhone,
              hintText: loc.enterAdminContactPhone,
              controller: controllers.adminContactPhone,
              keyboardType: TextInputType.phone,
              validator: (value) => (value ?? '').phoneValidator(context),
            ),
            const SizedBox(height: 16),
            HospitalFormField(
              label: loc.emergencyContactNumber,
              hintText: loc.enterEmergencyContactNumber,
              controller: controllers.emergencyContact,
              keyboardType: TextInputType.phone,
              validator: (value) => (value ?? '').phoneValidator(context),
            ),
            const SizedBox(height: 16),
            HospitalFormField(
              label: loc.secure_password,
              hintText: loc.please_enter_secure_password,
              controller: controllers.password,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            HospitalFormField(
              textInputAction: TextInputAction.done,
              label: loc.confirm_password,
              hintText: loc.please_confirm_password,
              controller: controllers.confirmPassword,
              obscureText: true,
              validator: (value) => (value ?? '').confirmPasswordValidator(
                context,
                controllers.password.text.trim(),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}