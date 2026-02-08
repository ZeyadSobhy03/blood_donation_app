import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_auth_box.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text_field.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HospitalAuthentication extends StatefulWidget {
  const HospitalAuthentication({super.key});

  @override
  State<HospitalAuthentication> createState() => _HospitalAuthenticationState();
}

class _HospitalAuthenticationState extends State<HospitalAuthentication> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _hospitalIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _hospitalIdController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorManger.veryLightBlue,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: ColorManger.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.local_hospital,
                          color: ColorManger.royalBlue,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLocalization.hospital_portal,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ColorManger.black,
                            ),
                          ),
                          Text(
                            appLocalization.authorized_access_only,
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorManger.grey600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  CustomAuthBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: ColorManger.accentBlue,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: ColorManger.skyBlue),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.shield_outlined,
                                color: ColorManger.royalBlue,
                                size: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                appLocalization.secure_login,
                                style: TextStyle(
                                  color: ColorManger.royalBlue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        Text(
                          appLocalization.hospital_patient_authentication,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorManger.black,
                          ),
                        ),

                        const SizedBox(height: 24),

                        CustomLabel(text: appLocalization.hospital_id),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: _hospitalIdController,
                          hint: "HOSP-12345",
                          icon: Icons.domain,
                          isPassword: false,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return appLocalization.please_enter_hospital_id;
                            }
                            return null;
                          }, // Building icon
                        ),

                        const SizedBox(height: 16),

                        CustomLabel(text: appLocalization.official_email),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: _emailController,
                          hint: "admin@hospital.org",
                          icon: Icons.email_outlined,
                          isPassword: false,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return appLocalization
                                  .please_enter_official_email;
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        CustomLabel(text: appLocalization.secure_password),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: _passwordController,
                          hint: "••••••••",
                          icon: Icons.lock_outline,
                          isPassword: true,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return appLocalization
                                  .please_enter_secure_password;
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {}
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManger.royalBlue,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              appLocalization.secure_login,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appLocalization.new_hospital_patient,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorManger.black,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 8),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                    height: 1.5,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          appLocalization.hospital_contact_text_1,
                                    ),
                                    TextSpan(
                                      text: "support@lifelink.org",
                                      style: TextStyle(
                                        color: ColorManger.skyBlue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          appLocalization.hospital_contact_text_2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
