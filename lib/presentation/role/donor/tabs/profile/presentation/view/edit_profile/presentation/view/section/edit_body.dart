import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../../../../core/widgets/custom_drop_down_button_form_field.dart';
import '../../../../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../donate/presentation/view/schedule_donation/presentation/view/widgets/custom_text_form_field.dart';
import '../widgets/profile_row.dart';

class EditBody extends StatefulWidget {
  const EditBody({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.cityController,
    required this.governorateController,
    required this.bloodTypeController,
    required this.weightController,
    required this.ageController,
    required this.birthDateController,
    required this.selectedGender,
    required this.bloodTypes,
    required this.onGenderChanged,
    required this.onBirthDateTap,
    required this.nameError,
    required this.emailError,
    required this.phoneError,
    required this.weightError,
    required this.birthDateError,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController cityController;
  final TextEditingController governorateController;
  final TextEditingController bloodTypeController;
  final TextEditingController weightController;
  final TextEditingController ageController;
  final TextEditingController birthDateController;

  final String selectedGender;
  final List<String> bloodTypes;
  final ValueChanged<String> onGenderChanged;
  final VoidCallback onBirthDateTap;

  final String? nameError;
  final String? emailError;
  final String? phoneError;
  final String? weightError;
  final String? birthDateError;

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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileRow(
              label: appLocalizations.name,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    hintText: appLocalizations.name,
                    textEditingController: widget.nameController,
                  ),
                  if (widget.nameError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: CustomText(
                        text:
                        widget.nameError!,
                        textStyle:  TextStyle(color: ColorManger.brightRed, fontSize: FontSize.s12),
                      ),
                    ),
                ],
              ),
            ),

            ProfileRow(
              label: appLocalizations.email,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    hintText: appLocalizations.email,
                    textEditingController: widget.emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  if (widget.emailError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: CustomText(text:
                        widget.emailError!,
                        textStyle:  TextStyle(color: ColorManger.brightRed, fontSize: FontSize.s12),
                      ),
                    ),
                ],
              ),
            ),

            ProfileRow(
              label: appLocalizations.phone,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    hintText: appLocalizations.phone,
                    textEditingController: widget.phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  if (widget.phoneError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: CustomText(
                        text:
                        widget.phoneError!,
                        textStyle:  TextStyle(color: ColorManger.brightRed, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),

            ProfileRow(
              label: appLocalizations.location,
              widget: CustomTextFormField(
                hintText: appLocalizations.city,
                textEditingController: widget.cityController,
              ),
            ),
            ProfileRow(
              label: appLocalizations.governorate,
              widget: CustomTextFormField(
                hintText: appLocalizations.governorate,
                textEditingController: widget.governorateController,
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
                  widget.bloodTypeController.text = value ?? '';
                },
              ),
            ),

            ProfileRow(
              label: appLocalizations.weight,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    hintText: appLocalizations.weight,
                    textEditingController: widget.weightController,
                    keyboardType: TextInputType.number,
                  ),
                  if (widget.weightError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: CustomText(
                        text:
                        widget.weightError!,
                        textStyle:  TextStyle(color: ColorManger.brightRed, fontSize: FontSize.s12),
                      ),
                    ),
                ],
              ),
            ),

            ProfileRow(
              label: appLocalizations.birthDate,
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: widget.onBirthDateTap,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorManger.textFormFieldGrey,
                        border: Border.all(color: ColorManger.grey300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text:
                            widget.birthDateController.text.isEmpty
                                ? 'YYYY-MM-DD'
                                : widget.birthDateController.text,
                            textStyle: TextStyle(
                              color: widget.birthDateController.text.isEmpty
                                  ? ColorManger.grey600
                                  : ColorManger.black,
                            ),
                          ),
                           Icon(Icons.calendar_today, color: ColorManger.grey600, size: 20)
                        ],
                      ),
                    ),
                  ),
                  if (widget.birthDateError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: CustomText(
                        text:
                        widget.birthDateError!,
                        textStyle:  TextStyle(color: ColorManger.brightRed, fontSize: FontSize.s12),
                      ),
                    ),
                ],
              ),
            ),

            ProfileRow(
              label: appLocalizations.age,
              widget: CustomTextFormField(
                hintText: appLocalizations.age,
                textEditingController: widget.ageController,
                keyboardType: TextInputType.number,
                suffixIcon: const Icon(Icons.info_outline),
              ),
            ),

            ProfileRow(
              label: appLocalizations.gender,
              widget: CustomDropDownButtonFormField(
                hintText: appLocalizations.gender,
                initialValue: localizedGender,
                items: localizedGenders,
                onChanged: (value) {
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