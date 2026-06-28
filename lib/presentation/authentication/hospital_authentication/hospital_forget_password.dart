import 'package:blood_donation_app/core/extension/text_ex.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_auth_box.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text_field.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/presentation/view_model/hospital_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalForgetPassword extends StatefulWidget {
  const HospitalForgetPassword({super.key});

  @override
  State<HospitalForgetPassword> createState() => _HospitalForgetPasswordState();
}

class _HospitalForgetPasswordState extends State<HospitalForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  late String _verificationEmail;

  void _handleSendOtp() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final loc = AppLocalizations.of(context)!;
    context.read<HospitalCubit>().forgotPassword(
      email: _emailController.text.trim(),
      loc: loc,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
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
            child: BlocListener<HospitalCubit, HospitalState>(
              listener: (context, state) {
                if (state is HospitalForgotPasswordSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'A verification code has been sent to your registered email.',
                      ),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  // TODO: Navigate to OTP verification screen when available.
                }

                if (state is HospitalErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: BlocBuilder<HospitalCubit, HospitalState>(
                builder: (context, state) {
                  if (state is HospitalLoadingState) {
                    return CustomLoadingWidget(
                      message: appLocalization.processingRequest,
                      indicatorColor: Colors.blueAccent,
                    );
                  }

                  return Form(
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
                              onPressed: () => Navigator.pop(context),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.favorite_border,
                              color: ColorManger.brightRed,
                              size: 32,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  appLocalization.donor_forget_password_title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManger.black,
                                  ),
                                ),
                                Text(
                                  appLocalization.donor_login_subtitle,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: ColorManger.grey600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        CustomAuthBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appLocalization.donor_forget_password_title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: ColorManger.black,
                                ),
                              ),
                              const SizedBox(height: 16),

                              Text(
                                appLocalization.donor_forget_password_text,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  height: 1.5,
                                ),
                              ),

                              const SizedBox(height: 24),

                              CustomLabel(text: appLocalization.donor_email),
                              const SizedBox(height: 8),

                              CustomTextField(
                                controller: _emailController,
                                validator: (value) =>
                                    value?.emailValidator(context),
                                hint: 'admin@hospital.org',
                                icon: Icons.email_outlined,
                                isPassword: false,
                              ),

                              const SizedBox(height: 32),

                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _handleSendOtp,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorManger.skyBlue,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    appLocalization.donor_send_reset_link,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 24),

                              Center(
                                child: TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    appLocalization.donor_back_to_login,
                                    style: const TextStyle(
                                      color: ColorManger.skyBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}