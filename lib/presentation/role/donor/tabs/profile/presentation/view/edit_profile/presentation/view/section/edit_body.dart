import 'package:flutter/material.dart';


import '../../../../../../../../../../../core/widgets/custom_drop_down_button_form_field.dart';
import '../../../../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../donate/schedule_donation/widgets/custom_text_form_field.dart';
import '../widgets/profile_row.dart';

class EditBody extends StatefulWidget {
  const EditBody({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.locationController,
    required this.bloodTypeController,
    required this.weightController,
    required this.ageController,
    required this.selectedGender,
    required this.bloodTypes,
    required this.onGenderChanged,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController locationController;
  final TextEditingController bloodTypeController;
  final TextEditingController weightController;
  final TextEditingController ageController;

  final String selectedGender;
  final List<String> bloodTypes;
  final ValueChanged<String> onGenderChanged;

  @override
  State<EditBody> createState() => _EditBodyState();
}

class _EditBodyState extends State<EditBody> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final String localizedGender =
    widget.selectedGender.toLowerCase() == 'male'
        ? appLocalizations.male
        : appLocalizations.female;

    final List<String> localizedGenders = [
      appLocalizations.male,
      appLocalizations.female,
    ];

    return SingleChildScrollView(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileRow(
              label: appLocalizations.name,
              widget: CustomTextFormField(
                hintText: appLocalizations.name,
                textEditingController: widget.nameController,
              ),
            ),
            ProfileRow(
              label: appLocalizations.email,
              widget: CustomTextFormField(
                hintText: appLocalizations.email,
                textEditingController: widget.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            ProfileRow(
              label: appLocalizations.phone,
              widget: CustomTextFormField(
                hintText: appLocalizations.phone,
                textEditingController: widget.phoneController,
                keyboardType: TextInputType.phone,
              ),
            ),
            ProfileRow(
              label: appLocalizations.location,
              widget: CustomTextFormField(
                hintText: appLocalizations.location,
                textEditingController: widget.locationController,
              ),
            ),
            ProfileRow(
              label: appLocalizations.bloodType,
              widget: CustomDropDownButtonFormField(
                hintText: appLocalizations.bloodType,
                initialValue: widget.bloodTypeController.text.isNotEmpty
                    ? widget.bloodTypeController.text
                    : null,
                items: widget.bloodTypes,
                onChanged: (value) {
                  setState(() {
                    widget.bloodTypeController.text = value ?? '';
                  });
                },
              ),
            ),
            ProfileRow(
              label: appLocalizations.weight,
              widget: CustomTextFormField(
                hintText: appLocalizations.weight,
                textEditingController: widget.weightController,
                keyboardType: TextInputType.number,
              ),
            ),
            ProfileRow(
              label: appLocalizations.age,
              widget: CustomTextFormField(
                hintText: appLocalizations.age,
                textEditingController: widget.ageController,
                keyboardType: TextInputType.number,
              ),
            ),
            ProfileRow(
              label: appLocalizations.gender,
              widget: CustomDropDownButtonFormField(
                hintText: appLocalizations.gender,
                initialValue: localizedGender,   // localized للعرض
                items: localizedGenders,          // localized للعرض
                onChanged: (value) {
                  // حول لـ English قبل ما ترجعه للـ parent
                  final englishValue =
                  value == appLocalizations.male ? 'Male' : 'Female';
                  widget.onGenderChanged(englishValue);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}