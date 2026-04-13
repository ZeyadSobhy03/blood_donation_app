import 'package:flutter/material.dart';

import '../../widgets/custom_pin_code.dart';

class PinVerificationArgs {
  final String title;
  final String subtitle;
  final String submitText;
  final String cancelText;
  final String invalidPinText;
  final AuthPinRole role;
  final int pinLength;
  final PinVerificationStyle? style;

  PinVerificationArgs({
    required this.title,
    required this.subtitle,
    required this.submitText,
    required this.cancelText,
    required this.invalidPinText,
    this.role = AuthPinRole.donor,
    this.pinLength = 6,
    this.style,
  });
}

class PinVerificationStyle {
  const PinVerificationStyle({
    this.screenBackgroundColor,
    this.appBarBackgroundColor,
    this.appBarForegroundColor,
    this.subtitleColor,
    this.submitBackgroundColor,
    this.submitForegroundColor,
    this.cancelBackgroundColor,
    this.cancelForegroundColor,
    this.cancelBorderColor,
    this.buttonBorderRadius,
  });

  final Color? screenBackgroundColor;
  final Color? appBarBackgroundColor;
  final Color? appBarForegroundColor;
  final Color? subtitleColor;
  final Color? submitBackgroundColor;
  final Color? submitForegroundColor;
  final Color? cancelBackgroundColor;
  final Color? cancelForegroundColor;
  final Color? cancelBorderColor;
  final double? buttonBorderRadius;
}
