import 'package:flutter/material.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';

enum BanRole { admin, donor, hospital }

class CustomBanScreen extends StatelessWidget {
  final BanRole role;
  final VoidCallback? onContactAdmin;
  final VoidCallback? onLogout;

  const CustomBanScreen({
    super.key,
    required this.role,
    this.onContactAdmin,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    Color primaryColor;
    String roleName;
    IconData icon;

    switch (role) {
      case BanRole.admin:
        primaryColor = ColorManger.darkSlate;
        roleName = 'Administrator';
        icon = Icons.admin_panel_settings;
        break;
      case BanRole.donor:
        primaryColor = ColorManger.bloodRed;
        roleName = 'Donor';
        icon = Icons.person_off;
        break;
      case BanRole.hospital:
        primaryColor = ColorManger.royalBlue;
        roleName = 'Hospital';
        icon = Icons.local_hospital;
        break;
    }

    return Scaffold(
      backgroundColor: ColorManger.pureWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 70,
                      color: primaryColor,
                    ),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: Icon(
                        Icons.cancel,
                        color: ColorManger.brightRed,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),


              CustomText(
                text: 'Access Restricted',
                textStyle: TextStyle(
                  fontSize: FontSize.s24,
                  fontWeight: FontWeightManager.bold,
                  color: ColorManger.darkSlate,
                ),
              ),
              const SizedBox(height: 16),

              CustomText(
                text:
                'Your $roleName account has been suspended. You can no longer access the system features until the restriction is lifted.',
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.regular,
                  color: ColorManger.slateGrey,
                ),
              ),
              const SizedBox(height: 8),

              CustomText(
                text: 'Please contact the system administrator to resolve this issue.',
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.medium,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 48),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: CustomElevatedButton(
                  backgroundColor: primaryColor,
                  onPressed: onContactAdmin,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const CustomText(
                    text: 'Contact Admin',
                    textStyle: TextStyle(
                      color: ColorManger.pureWhite,
                      fontSize: FontSize.s16,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Logout Button
              TextButton(
                onPressed: onLogout,
                child: CustomText(
                  text: 'Back to Login',
                  textStyle: TextStyle(
                    color: ColorManger.slateGrey,
                    fontSize: FontSize.s15,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}