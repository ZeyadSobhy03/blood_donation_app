import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class SecuritySettingsDialog extends StatefulWidget {
  final void Function({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) onSave;

  const SecuritySettingsDialog({super.key, required this.onSave});

  @override
  State<SecuritySettingsDialog> createState() => _SecuritySettingsDialogState();
}

class _SecuritySettingsDialogState extends State<SecuritySettingsDialog> {
  final TextEditingController currentPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  void dispose() {
    currentPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      loc.securitySettings,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFBFDBFE)),
                ),
                child: Text(
                  loc.securityInfo,
                  style: const TextStyle(
                    color: Color(0xFF1E40AF),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                loc.currentPassword,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: currentPassword,
                isPassword: true,
                hint: loc.enterCurrentPassword,
              ),
              const SizedBox(height: 16),
              Text(
                loc.newPassword,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: newPassword,
                isPassword: true,
                hint: loc.enterNewPassword,
              ),
              const SizedBox(height: 16),
              Text(
                loc.confirmNewPassword,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: confirmPassword,
                isPassword: true,
                hint: loc.confirmNewPasswordHint,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      foregroundColor: ColorManger.black,
                      backgroundColor: ColorManger.pureWhite,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: ColorManger.slateGrey.withValues(alpha: 0.4),
                        ),
                        borderRadius: BorderRadiusGeometry.circular(12),
                      ),
                      onPressed: ()=> Navigator.pop(context),
                      child: CustomText(text: loc.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomElevatedButton(
                      backgroundColor: ColorManger.royalBlue,
                      foregroundColor: ColorManger.pureWhite,
                      onPressed: () {
                        widget.onSave(
                          currentPassword: currentPassword.text.trim(),
                          newPassword: newPassword.text.trim(),
                          confirmPassword: confirmPassword.text.trim(),
                        );
                        Navigator.pop(context);
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: ColorManger.royalBlue.withValues(alpha: 0.2),
                        ),
                        borderRadius: BorderRadiusGeometry.circular(12),
                      ),
                      child: CustomText(text: loc.updatePassword),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
