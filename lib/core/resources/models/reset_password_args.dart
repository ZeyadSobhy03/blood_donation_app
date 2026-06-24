import 'dart:ui';

class ResetPasswordArgs {
  final String email;
  final String otp;
  final Color primaryColor;
  final Color backgroundColor;
  final String successRoute;
  final String title;
  final String subtitle;

  const ResetPasswordArgs({
    required this.email,
    required this.otp,
    required this.primaryColor,
    required this.backgroundColor,
    required this.successRoute,
    required this.title,
    required this.subtitle,
  });
}
