import 'package:blood_donation_app/core/resources/models/reset_password_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extension/text_ex.dart';
import '../../../core/resources/colors/color_manger.dart';
import '../../../core/resources/models/pin_verification_args.dart';
import '../../../core/resources/routes/route_manger.dart';
import '../../../core/widgets/custom_auth_box.dart';
import '../../../core/widgets/custom_label.dart';
import '../../../core/widgets/custom_pin_code.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/states/custom_loading_widget.dart';
import '../../../l10n/app_localizations.dart';
import '../../authentication/donor_authentication/presentation/error_mapper.dart';
import '../../authentication/donor_authentication/presentation/view_model/auth_view_model.dart';

class HospitalForgetPassword extends StatefulWidget {
  const HospitalForgetPassword({super.key});

  @override
  State<HospitalForgetPassword> createState() => _HospitalForgetPasswordState();
}

class _HospitalForgetPasswordState extends State<HospitalForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  late String _verificationEmail;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthForgetPasswordSuccessState) {
          _verificationEmail = _emailController.text.trim();
          final authCubit = context.read<AuthCubit>();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(appLocalization.forget_password_success),
              backgroundColor: ColorManger.successColor,
              behavior: SnackBarBehavior.floating,
            ),
          );

          Navigator.pushNamed(
            context,
            RouteManger.customPinVerificationScreen,
            arguments: PinVerificationArgs(
              title: appLocalization.donor_pin_verification_title,
              subtitle: appLocalization.donor_pin_verification_subtitle,
              submitText: appLocalization.confirm,
              cancelText: appLocalization.cancel,
              invalidPinText: appLocalization.invalidPin,
              role: AuthPinRole.hospital,
              pinLength: 6,
              onSubmit: (otp) async {
                final isValid = await authCubit.verifyForgetPasswordOtp(
                  email: _verificationEmail,
                  otp: otp,
                );
                return isValid;
              },
              onResend: () async {
                authCubit.forgetPassword(email: _verificationEmail);
              },
            ),
          );
        }

        if (state is AuthVerifyOtpSuccessState) {
          if (state.verified) {
            Navigator.pop(context);
            Future.delayed(const Duration(milliseconds: 100), () {
              Navigator.pushNamed(
                context,
                RouteManger.customResetPassword,
                arguments: ResetPasswordArgs(
                  email: _verificationEmail,
                  otp: state.otp ?? '',
                  primaryColor: ColorManger.skyBlue,
                  backgroundColor: ColorManger.veryLightBlue,
                  successRoute: RouteManger.hospitalAuth,
                  title: appLocalization.hospital_reset_password_title,
                  subtitle: appLocalization.hospital_reset_password_subtitle,
                ),
              );
            });
          }
        }

        if (state is AuthErrorState) {
          final message = ErrorMapper.map(state.errorKey, appLocalization);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: ColorManger.veryLightBlue,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return CustomLoadingWidget(
                      indicatorColor: ColorManger.skyBlue,
                      message: appLocalization.processingRequest,
                    );
                  }

                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back, color: ColorManger.black),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.favorite_border, color: ColorManger.brightRed, size: 32),
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
                                validator: (value) => value?.emailValidator(context),
                                hint: "someone@example.com",
                                icon: Icons.email_outlined,
                                isPassword: false,
                              ),

                              const SizedBox(height: 32),

                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthCubit>().forgetPassword(
                                        email: _emailController.text.trim(),
                                      );
                                    }
                                  },
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