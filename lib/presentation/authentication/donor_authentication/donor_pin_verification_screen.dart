import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/colors/color_manger.dart';
import '../../../core/resources/models/pin_verification_args.dart';
import '../../../core/widgets/custom_auth_box.dart';
import '../../../core/widgets/custom_pin_code.dart';

class DonorPinVerificationScreen extends StatefulWidget {
  const DonorPinVerificationScreen({
    super.key, required this.args,

  });

  final PinVerificationArgs args;

   String get title => args.title;
   String get subtitle => args.subtitle;
   String get submitText => args.submitText;
   String get cancelText => args.cancelText;
   String get invalidPinText => args.invalidPinText;



  @override
  State<DonorPinVerificationScreen> createState() =>
      _DonorPinVerificationScreenState();
}

class _DonorPinVerificationScreenState
    extends State<DonorPinVerificationScreen> {
  final TextEditingController _pinController = TextEditingController();
  String? _pinError;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_pinController.text.length != 6) {
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
      backgroundColor: ColorManger.softPinkishWhite,
      appBar: AppBar(
        backgroundColor: ColorManger.softPinkishWhite,
        foregroundColor: ColorManger.black,
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
                    color: ColorManger.grey600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                CustomPinCode(
                  controller: _pinController,
                  role: AuthPinRole.donor,
                  length: 6,
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
                    backgroundColor: ColorManger.brightRed,
                    foregroundColor: ColorManger.pureWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomText(text: widget.submitText),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: CustomText(text: widget.cancelText,
                    textStyle: TextStyle(
                      color: ColorManger.black,
                      fontSize: 14,
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
}
