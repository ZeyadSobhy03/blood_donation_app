import 'package:flutter/material.dart';

class OnboardingItem {
  final String text;
  final Widget? prefixWidget;
  final Color? prefixColor;

  OnboardingItem({required this.text, this.prefixWidget, this.prefixColor});
}

class OnboardingModel {
  final Color? backgroundColor;
  final Color? iconColor;
  final IconData icon;

  final String title;
  final String subTitle;
  final List<OnboardingItem> description;

  final TextStyle? titleTextStyle;
  final TextStyle? subTitleTextStyle;
  final TextStyle? descriptionStyle;

  final Widget? leading;

  const OnboardingModel({
    this.backgroundColor,
    this.iconColor,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.description,
    this.titleTextStyle,
    this.subTitleTextStyle,
    this.descriptionStyle,
    this.leading,
  });
}
