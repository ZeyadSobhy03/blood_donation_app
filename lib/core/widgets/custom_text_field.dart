import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/fonts/font_manger.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;

  const CustomTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    required this.isPassword,
    this.validator,
    super.key,
    this.keyboardType,
    this.suffixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      cursorColor: ColorManger.black,
      style: TextStyle(color: ColorManger.black, fontSize: FontSize.s14),
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword,
      decoration: InputDecoration(
        iconColor: ColorManger.slateGrey,
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: ColorManger.grey600,
          fontSize: FontSize.s13,
        ),

        filled: true,
        fillColor: ColorManger.textFormFieldGrey,
        prefixIcon: Icon(widget.icon),
        suffixIcon: widget.suffixIcon,
        prefixIconColor: ColorManger.slateGrey,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorManger.mutedGrey, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorManger.brightRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorManger.brightRed, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 6.w,
          vertical: 8.h,
        ),
      ),
    );
  }
}
