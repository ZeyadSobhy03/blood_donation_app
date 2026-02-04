import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.textAlign,
    this.maxLines,
    this.textStyle,
    this.textDirection,
  });

  final String text;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextStyle? textStyle;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: textStyle,
      textDirection: textDirection,

    );
  }
}
