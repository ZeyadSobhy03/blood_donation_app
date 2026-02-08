import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_auth_box.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text_field.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DonorLogin extends StatefulWidget {
  const DonorLogin({super.key});

  @override
  State<DonorLogin> createState() => _DonorLoginState();
}

class _DonorLoginState extends State<DonorLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorManger.softPinkishWhite,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: ColorManger.grey600),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.favorite_border, color: ColorManger.brightRed, size: 32),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLocalization.donor_login_title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorManger.black,
                            ),
                          ),
                          Text(
                            appLocalization.donor_login_subtitle,
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
                          Text(
                            appLocalization.donor_login_card_title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: ColorManger.black,
                            ),
                          ),
                          const SizedBox(height: 24),
                    
                          CustomLabel(text: appLocalization.donor_email),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _emailController,
                            validator: (String? value){
                              if(value == null || value.isEmpty){
                                return appLocalization.please_enter_email;
                              }
                              return null;
                            },
                            hint: "someone@example.com",
                            icon: Icons.email_outlined,
                            isPassword: false,
                          ),
                    
                          const SizedBox(height: 20),
                    
                          CustomLabel(text:appLocalization.donor_password),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _passwordController,
                            validator: (String? value){
                              if(value == null || value.isEmpty){
                                return appLocalization.please_enter_password;
                              }
                              return null;
                            },
                            hint: ".........",
                            icon: Icons.lock_outline,
                            isPassword: true,
                          ),
                    
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RouteManger.donorForgetPassword);
                              },
                              child: Text(
                                appLocalization.donor_forget_password,
                                style: TextStyle(
                                  color: ColorManger.brightRed,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                    
                          const SizedBox(height: 10),
                    
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if(_formKey.currentState!.validate()){

                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManger.brightRed,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                appLocalization.donor_login_button,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                    
                          const SizedBox(height: 24),
                    
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                appLocalization.donor_dont_have_account,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, RouteManger.donorRegister);
                                },
                                child: Text(
                                  appLocalization.donor_register_now,
                                  style: TextStyle(
                                    color: ColorManger.brightRed,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
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