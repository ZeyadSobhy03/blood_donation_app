import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_auth_box.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text_field.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/presentation/error_mapper.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonorResetPassword extends StatefulWidget {
  final String email;
  final String otp;

  const DonorResetPassword({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<DonorResetPassword> createState() => _DonorResetPasswordState();
}

class _DonorResetPasswordState extends State<DonorResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthResetPasswordSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(appLocalization.success),
              backgroundColor: ColorManger.successColor,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteManger.donorLogin,
            (route) => false,
          );
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
        backgroundColor: ColorManger.softPinkishWhite,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return CustomLoadingWidget(
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
                                appLocalization.changePassword,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: ColorManger.black,
                                ),
                              ),
                              const SizedBox(height: 24),
                              CustomLabel(text: appLocalization.newPassword),
                              const SizedBox(height: 8),
                              CustomTextField(
                                controller: _passwordController,

                                hint: ".........",
                                icon: Icons.lock_outline,
                                isPassword: true,
                              ),
                              const SizedBox(height: 20),
                              CustomLabel(
                                  text: appLocalization.confirmPassword),
                              const SizedBox(height: 8),
                              CustomTextField(
                                controller: _confirmPasswordController,
                                validator: (value) {
                                  if (value != _passwordController.text) {
                                    return appLocalization.passwordsDoNotMatch;
                                  }
                                  return null;
                                },
                                hint: ".........",
                                icon: Icons.lock_outline,
                                isPassword: true,
                              ),
                              const SizedBox(height: 32),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthCubit>().resetPassword(
                                            email: widget.email,
                                            otp: widget.otp,
                                            password:
                                                _passwordController.text.trim(),
                                          );
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
                                    appLocalization.confirm,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
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
