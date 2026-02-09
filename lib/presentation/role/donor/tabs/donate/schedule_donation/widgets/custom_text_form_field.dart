import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.prefixIcon,
    this.textEditingController,
    this.validator,
    this.hintText, this.keyboardType, this.suffixIcon,
  });

  final Widget? prefixIcon;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final String? hintText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      keyboardType:keyboardType ,
      controller: textEditingController,
      validator: validator,
      cursorColor: ColorManger.black,
      style: TextStyle(
        color: ColorManger.black,
        fontSize: FontSize.s14
      ),
      decoration: InputDecoration(

        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(
          color: ColorManger.grey600,
          fontSize:FontSize.s13,
        ),

        filled: true,
        fillColor: ColorManger.textFormFieldGrey,

        contentPadding: EdgeInsets.symmetric(
          horizontal: 6.w,
          vertical: 8.h,
        ),

        prefixIcon: prefixIcon,
        iconColor: ColorManger.grey600,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: ColorManger.grey300,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: ColorManger.black54,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: ColorManger.brightRed,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: ColorManger.brightRed,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}

