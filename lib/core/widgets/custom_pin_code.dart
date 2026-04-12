import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

enum AuthPinRole { admin, donor, hospital }

class CustomPinCode extends StatelessWidget {
  const CustomPinCode({
    required this.controller,
    super.key,
    this.focusNode,
    this.length = 6,
    this.role = AuthPinRole.donor,
    this.onChanged,
    this.onCompleted,
    this.validator,
    this.enabled = true,
    this.autofocus = false,
    this.showCursor = true,
    this.obscureText = false,
    this.obscuringCharacter = '*',
    this.errorText,
    this.keyboardType = TextInputType.number,
    this.boxSize = 54,
    this.autoValidateMode = PinputAutovalidateMode.onSubmit,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final int length;
  final AuthPinRole role;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool autofocus;
  final bool showCursor;
  final bool obscureText;
  final String obscuringCharacter;
  final String? errorText;
  final TextInputType keyboardType;
  final double boxSize;
  final PinputAutovalidateMode autoValidateMode;

  @override
  Widget build(BuildContext context) {
    final roleStyle = _resolveRoleStyle(role);

    final defaultPinTheme = PinTheme(
      width: boxSize,
      height: boxSize,
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: ColorManger.darkSlate,
      ),
      decoration: BoxDecoration(
        color: ColorManger.pureWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorManger.lightGreyBorder),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: roleStyle.primaryColor, width: 1.6),
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      color: roleStyle.backgroundColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: roleStyle.primaryColor),
    );

    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      color: ColorManger.softRed,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: ColorManger.brightRed),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Pinput(
          controller: controller,
          focusNode: focusNode,
          length: length,
          enabled: enabled,
          autofocus: autofocus,
          showCursor: showCursor,
          obscureText: obscureText,
          obscuringCharacter: obscuringCharacter,
          keyboardType: keyboardType,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          errorPinTheme: errorPinTheme,
          validator: validator,
          onChanged: onChanged,
          onCompleted: onCompleted,
          pinputAutovalidateMode: autoValidateMode,
        ),
        if (errorText != null && errorText!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            errorText!,
            style: const TextStyle(
              color: ColorManger.brightRed,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  _PinRoleStyle _resolveRoleStyle(AuthPinRole role) {
    switch (role) {
      case AuthPinRole.admin:
        return const _PinRoleStyle(
          primaryColor: ColorManger.brightPurple,
          backgroundColor: ColorManger.lightPurple,
        );
      case AuthPinRole.hospital:
        return const _PinRoleStyle(
          primaryColor: ColorManger.royalBlue,
          backgroundColor: ColorManger.veryLightBlue,
        );
      case AuthPinRole.donor:
        return const _PinRoleStyle(
          primaryColor: ColorManger.brightRed,
          backgroundColor: ColorManger.softRed,
        );
    }
  }
}

class _PinRoleStyle {
  const _PinRoleStyle({
    required this.primaryColor,
    required this.backgroundColor,
  });

  final Color primaryColor;
  final Color backgroundColor;
}
