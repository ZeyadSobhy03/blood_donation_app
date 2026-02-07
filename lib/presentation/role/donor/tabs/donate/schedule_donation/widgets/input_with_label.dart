import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../core/widgets/custom_text.dart';
import 'custom_text_form_field.dart';

class InputWithLabel extends StatelessWidget {
  const InputWithLabel({
    super.key,
    required this.label,
    this.icon,
    this.textEditingController,
    this.validator,
    this.hintText, this.keyboardType,
  });

  final String label;
  final IconData? icon;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final String? hintText;
 final  TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          textStyle: TextStyle(
            color: ColorManger.black,
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.semiBold,
          ),
        ),
        SizedBox(height: 6.h),
        CustomTextFormField(
          keyboardType:keyboardType ,
          validator: validator,
          hintText: hintText,
          textEditingController: textEditingController,
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
      ],
    );
  }
}
