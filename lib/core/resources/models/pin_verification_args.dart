class PinVerificationArgs {
  final String title;
  final String subtitle;
  final String submitText;
  final String cancelText;
  final String invalidPinText;

  PinVerificationArgs({
    required this.title,
    required this.subtitle,
    required this.submitText,
    required this.cancelText,
    required this.invalidPinText,
  });
}