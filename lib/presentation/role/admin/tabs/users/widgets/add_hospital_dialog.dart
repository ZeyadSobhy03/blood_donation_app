import 'package:blood_donation_app/core/extension/text_ex.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/custom_drop_down_button_form_field.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';

class AddHospitalDialog extends StatefulWidget {
  const AddHospitalDialog({super.key});

  @override
  State<AddHospitalDialog> createState() => _AddHospitalDialogState();
}

class _AddHospitalDialogState extends State<AddHospitalDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _locationController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _latitudeController;
  late final TextEditingController _longitudeController;
  late final TextEditingController _licenseNumberController;
  late final TextEditingController _adminContactNameController;
  late final TextEditingController _adminContactPhoneController;
  late final TextEditingController _emergencyContactController;

  String? _selectedHospitalType;

  List<String> _hospitalTypes(AppLocalizations loc) => [
    loc.governmentHospital,
    loc.privateHospital,
    loc.specializedHospital,
    loc.communityHospital,
    loc.medicalCenter,
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _locationController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _latitudeController = TextEditingController();
    _longitudeController = TextEditingController();
    _licenseNumberController = TextEditingController();
    _adminContactNameController = TextEditingController();
    _adminContactPhoneController = TextEditingController();
    _emergencyContactController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _licenseNumberController.dispose();
    _adminContactNameController.dispose();
    _adminContactPhoneController.dispose();
    _emergencyContactController.dispose();
    super.dispose();
  }

  String? _requiredValidator(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.fieldIsRequired;
    }
    return null;
  }

  String? _latitudeValidator(String? value, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final requiredMessage = _requiredValidator(value, context);
    if (requiredMessage != null) {
      return requiredMessage;
    }
    final parsed = double.tryParse(value!.trim());
    if (parsed == null || parsed < -90 || parsed > 90) {
      return loc.latitudeRangeError;
    }
    return null;
  }

  String? _longitudeValidator(String? value, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final requiredMessage = _requiredValidator(value, context);
    if (requiredMessage != null) {
      return requiredMessage;
    }
    final parsed = double.tryParse(value!.trim());
    if (parsed == null || parsed < -180 || parsed > 180) {
      return loc.longitudeRangeError;
    }
    return null;
  }

  SnackBar _buildSnackBar({required String message, required bool isSuccess}) {
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: isSuccess ? ColorManger.successColor : ColorManger.brightRed,
          fontWeight: FontWeight.w600,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      backgroundColor: isSuccess
          ? ColorManger.successBackground
          : ColorManger.errorLightBackground,
    );
  }

  void _onSave() {
    final loc = AppLocalizations.of(context)!;
    final isFormValid = _formKey.currentState?.validate() ?? false;

    if (_selectedHospitalType == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          _buildSnackBar(message: loc.selectHospitalType, isSuccess: false),
        );
      return;
    }

    if (!isFormValid) {
      return;
    }

    final hospitalData = <String, dynamic>{
      'name': _nameController.text.trim(),
      'type': _selectedHospitalType,
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim(),
      'address': _locationController.text.trim(),
      'latitude': double.parse(_latitudeController.text.trim()),
      'longitude': double.parse(_longitudeController.text.trim()),
      'licenseNumber': _licenseNumberController.text.trim(),
      'adminContactName': _adminContactNameController.text.trim(),
      'adminContactPhone': _adminContactPhoneController.text.trim(),
      'emergencyContactNumber': _emergencyContactController.text.trim(),
    };

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        _buildSnackBar(message: loc.hospitalAddedSuccessfully, isSuccess: true),
      );

    Navigator.of(context).pop(hospitalData);
  }

  Widget _buildField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required BuildContext context,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(text: label),
        CustomTextFormField(
          textEditingController: controller,
          keyboardType: keyboardType,
          hintText: hintText,
          validator: validator ?? (value) => _requiredValidator(value, context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.lightGrey),
      ),
      backgroundColor: ColorManger.pureWhite,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.86,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  RequestHeader(
                    title: loc.addHospital,
                    subtitle: loc.addHospitalSubtitle,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildField(
                            label: loc.hospitalName,
                            hintText: loc.enterHospitalName,
                            controller: _nameController,
                            context: context,
                          ),
                          const SizedBox(height: 16),
                          CustomLabel(text: loc.type),
                          CustomDropDownButtonFormField(
                            items: _hospitalTypes(loc),
                            hintText: loc.selectHospitalType,
                            onChanged: (value) {
                              setState(() {
                                _selectedHospitalType = value as String?;
                              });
                            },
                            initialValue: _selectedHospitalType,
                          ),
                          const SizedBox(height: 16),
                          _buildField(
                            label: loc.email,
                            hintText: loc.enterHospitalEmail,
                            controller: _emailController,
                            context: context,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                (value ?? '').emailValidator(context),
                          ),
                          const SizedBox(height: 16),
                          _buildField(
                            label: loc.phone,
                            hintText: loc.enterHospitalContactNumber,
                            controller: _phoneController,
                            context: context,
                            keyboardType: TextInputType.phone,
                            validator: (value) =>
                                (value ?? '').phoneValidator(context),
                          ),
                          const SizedBox(height: 16),
                          _buildField(
                            label: loc.address,
                            hintText: loc.enterHospitalAddress,
                            controller: _locationController,
                            context: context,
                          ),
                          const SizedBox(height: 16),
                          _buildField(
                            label: loc.latitude,
                            hintText: loc.enterHospitalLatitude,
                            controller: _latitudeController,
                            context: context,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                              signed: true,
                            ),
                            validator: (value) =>
                                _latitudeValidator(value, context),
                          ),
                          const SizedBox(height: 16),
                          _buildField(
                            label: loc.longitude,
                            hintText: loc.enterHospitalLongitude,
                            controller: _longitudeController,
                            context: context,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                              signed: true,
                            ),
                            validator: (value) =>
                                _longitudeValidator(value, context),
                          ),
                          const SizedBox(height: 16),
                          _buildField(
                            label: loc.licenseNumber,
                            hintText: loc.enterHospitalLicenseNumber,
                            controller: _licenseNumberController,
                            context: context,
                          ),
                          const SizedBox(height: 16),
                          _buildField(
                            label: loc.adminContactName,
                            hintText: loc.enterAdminContactName,
                            controller: _adminContactNameController,
                            context: context,
                          ),
                          const SizedBox(height: 16),
                          _buildField(
                            label: loc.adminContactPhone,
                            hintText: loc.enterAdminContactPhone,
                            controller: _adminContactPhoneController,
                            context: context,
                            keyboardType: TextInputType.phone,
                            validator: (value) =>
                                (value ?? '').phoneValidator(context),
                          ),
                          const SizedBox(height: 16),
                          _buildField(
                            label: loc.emergencyContactNumber,
                            hintText: loc.enterEmergencyContactNumber,
                            controller: _emergencyContactController,
                            context: context,
                            keyboardType: TextInputType.phone,
                            validator: (value) =>
                                (value ?? '').phoneValidator(context),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          backgroundColor: ColorManger.pureWhite,
                          foregroundColor: ColorManger.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: ColorManger.slateGrey.withValues(alpha: 0.3),
                              width: 1.2,
                            ),
                          ),

                          onPressed: () => Navigator.of(context).pop(),
                          child: CustomText(text: loc.cancel),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomElevatedButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: ColorManger.royalBlue.withValues(alpha: 0.45),
                              width: 1,
                            ),
                          ),
                          backgroundColor: ColorManger.royalBlue,
                          foregroundColor: ColorManger.pureWhite,

                          onPressed: _onSave,
                          child : CustomText(text: loc.save),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
