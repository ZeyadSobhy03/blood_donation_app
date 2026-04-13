import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/colors/color_manger.dart';
import '../../../core/resources/models/pin_verification_args.dart';
import '../../../core/widgets/custom_auth_box.dart';
import '../../../core/widgets/custom_pin_code.dart';

class CustomPinVerificationScreen extends StatefulWidget {
  const CustomPinVerificationScreen({
    super.key,
    required this.args,
  });

  final PinVerificationArgs args;

  String get title => args.title;
  String get subtitle => args.subtitle;
  String get submitText => args.submitText;
  String get cancelText => args.cancelText;
  String get invalidPinText => args.invalidPinText;
  AuthPinRole get role => args.role;
  int get pinLength => args.pinLength;
  PinVerificationStyle? get style => args.style;

  @override
  State<CustomPinVerificationScreen> createState() =>
      _CustomPinVerificationScreenState();
}

class _CustomPinVerificationScreenState
    extends State<CustomPinVerificationScreen> {
  final TextEditingController _pinController = TextEditingController();
  String? _pinError;

  _PinActionColors get _colors => _resolveActionColors(widget.role);
  Color get _screenBackground =>
      widget.style?.screenBackgroundColor ?? ColorManger.softPinkishWhite;
  Color get _appBarBackground =>
      widget.style?.appBarBackgroundColor ?? _screenBackground;
  Color get _appBarForeground =>
      widget.style?.appBarForegroundColor ?? ColorManger.black;
  Color get _subtitleColor => widget.style?.subtitleColor ?? ColorManger.grey600;
  Color get _submitBackground =>
      widget.style?.submitBackgroundColor ?? _colors.primary;
  Color get _submitForeground =>
      widget.style?.submitForegroundColor ?? ColorManger.pureWhite;
  Color get _cancelBackground =>
      widget.style?.cancelBackgroundColor ?? _colors.secondaryBackground;
  Color get _cancelForeground =>
      widget.style?.cancelForegroundColor ?? _colors.primary;
  Color get _cancelBorder => widget.style?.cancelBorderColor ?? _cancelForeground;
  double get _buttonRadius => widget.style?.buttonBorderRadius ?? 12;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_pinController.text.length != widget.pinLength) {
      setState(() {
        _pinError = widget.invalidPinText;
      });
      return;
    }
    Navigator.pop(context, _pinController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _screenBackground,
      appBar: AppBar(
        backgroundColor: _appBarBackground,
        foregroundColor: _appBarForeground,
        elevation: 0,
        title: CustomText(text: widget.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: CustomAuthBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: widget.subtitle,
                  textStyle: TextStyle(
                    color: _subtitleColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                CustomPinCode(
                  controller: _pinController,
                  role: widget.role,
                  length: widget.pinLength,
                  errorText: _pinError,
                  onChanged: (_) {
                    if (_pinError != null) {
                      setState(() {
                        _pinError = null;
                      });
                    }
                  },
                  onCompleted: (_) => _submit(),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    onPressed: _submit,
                    backgroundColor: _submitBackground,
                    foregroundColor: _submitForeground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_buttonRadius),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: CustomText(text: widget.submitText),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    backgroundColor: _cancelBackground,
                    foregroundColor: _cancelForeground,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_buttonRadius),
                      side: BorderSide(color: _cancelBorder),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: CustomText(
                      text: widget.cancelText,
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _PinActionColors _resolveActionColors(AuthPinRole role) {
    switch (role) {
      case AuthPinRole.admin:
        return const _PinActionColors(
          primary: ColorManger.brightPurple,
          secondaryBackground: ColorManger.lightPurple,
        );
      case AuthPinRole.hospital:
        return const _PinActionColors(
          primary: ColorManger.royalBlue,
          secondaryBackground: ColorManger.veryLightBlue,
        );
      case AuthPinRole.donor:
        return const _PinActionColors(
          primary: ColorManger.brightRed,
          secondaryBackground: ColorManger.softRed,
        );
    }
  }
}

class _PinActionColors {
  const _PinActionColors({
    required this.primary,
    required this.secondaryBackground,
  });

  final Color primary;
  final Color secondaryBackground;
}
