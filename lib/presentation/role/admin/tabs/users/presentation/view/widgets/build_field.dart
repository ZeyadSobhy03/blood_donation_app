import 'package:flutter/material.dart';

import '../../../../../../../../core/widgets/custom_label.dart';
import '../../../../../../donor/tabs/donate/presentation/view/schedule_donation/widgets/custom_text_form_field.dart';


class BuildField extends StatelessWidget {
  const BuildField({
    super.key,
    required this.label,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.obscureText,
    this.validator, this.textInputAction = TextInputAction.next,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction ;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(text: label),
        CustomTextFormField(
          textInputAction: textInputAction ,
          textEditingController: controller,
          keyboardType: keyboardType,
          hintText: hintText,
          obscureText: obscureText,
          validator: validator,
        ),
      ],
    );
  }
}
