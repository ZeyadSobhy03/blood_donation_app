import 'package:flutter/material.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../donor/tabs/donate/presentation/view/schedule_donation/widgets/custom_text_form_field.dart';

class HospitalFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputAction textInputAction;

  const HospitalFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
  });

  static String? requiredValidator(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.fieldIsRequired;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(text: label),
        CustomTextFormField(
          textInputAction: textInputAction,
          textEditingController: controller,
          keyboardType: keyboardType,
          hintText: hintText,
          obscureText: obscureText,
          validator: validator ?? (value) => requiredValidator(value, context),
        ),
      ],
    );
  }
}