import 'package:blood_donation_app/core/extension/text_ex.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_auth_box.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text_field.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AdminAuthentication extends StatefulWidget {
  const AdminAuthentication({super.key});

  @override
  State<AdminAuthentication> createState() => _AdminAuthenticationState();
}

class _AdminAuthenticationState extends State<AdminAuthentication> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _accessKeyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _accessKeyController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.mintyLightGreen,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: ColorManger.black),
                        onPressed: () {Navigator.pop(context);}
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.security_outlined, color: ColorManger.green, size: 32),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLocalization.admin_portal,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ColorManger.black,
                            ),
                          ),
                          Text(
                            appLocalization.system_management_access,
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
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: ColorManger.lightYellow,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: ColorManger.yellow),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.warning_amber_rounded, color: ColorManger.darkOrange, size: 22),
                                SizedBox(width: 10),
                                Text(
                                  appLocalization.restricted_access_area,
                                  style: TextStyle(
                                    color: ColorManger.darkOrange,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          Text(
                            appLocalization.admin_authentication,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ColorManger.black,
                            ),
                          ),

                          const SizedBox(height: 24),

                          CustomLabel(text: appLocalization.admin_access_key),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _accessKeyController,
                            hint: "ADMIN-XXXXXXXX",
                            icon: Icons.vpn_key_outlined,
                            isPassword: false,
                            validator: (String? value){
                              if(value == null || value.isEmpty){
                                return appLocalization.please_enter_admin_access_key;
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          CustomLabel(text: appLocalization.admin_email),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _emailController,
                            hint: "admin@lifelink.org",
                            icon: Icons.mail_outline,
                            isPassword: false,
                            validator: (value) => value?.emailValidator(context),
                          ),

                          const SizedBox(height: 16),

                          CustomLabel(text: appLocalization.secure_password),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _passwordController,
                            hint: "••••••••",
                            icon: Icons.lock_outline,
                            isPassword: true,
                            validator: (value) => value?.passwordValidator(context),

                          ),

                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if(_formKey.currentState!.validate()){

                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManger.green,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8), // Slightly sharper corners as per image
                                ),
                              ),
                              child: Text(
                                appLocalization.secure_admin_login,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC), // Light Grey
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  appLocalization.security_notice,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorManger.black,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  appLocalization.security_notice_desc,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0FDF4), // Very light green
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: ColorManger.green),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  appLocalization.need_access,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorManger.green,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: ColorManger.green,
                                      fontSize: 13,
                                      height: 1.4,
                                    ),
                                    children: [
                                      TextSpan(text: appLocalization.contact_system_admin),
                                      TextSpan(
                                        text: "security@lifelink.org",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}