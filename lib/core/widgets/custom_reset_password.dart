import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/app_localizations.dart';
import '../../presentation/authentication/donor_authentication/presentation/error_mapper.dart';
import '../../presentation/authentication/donor_authentication/presentation/view_model/auth_view_model.dart';
import '../resources/colors/color_manger.dart';
import '../resources/models/reset_password_args.dart';
import 'custom_auth_box.dart';
import 'custom_label.dart';
import 'custom_text_field.dart';
import 'states/custom_loading_widget.dart';

class CustomResetPassword extends StatefulWidget {
  final ResetPasswordArgs args;

  const CustomResetPassword({super.key, required this.args});

  @override
  State<CustomResetPassword> createState() => _CustomResetPasswordState();
}

class _CustomResetPasswordState extends State<CustomResetPassword> {
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
    final args = widget.args;

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
            args.successRoute,
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
        backgroundColor: args.backgroundColor,
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
                              icon: const Icon(Icons.arrow_back,
                                  color: ColorManger.black),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.favorite_border,
                                color: args.primaryColor, size: 32),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    args.title,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: ColorManger.black,
                                    ),
                                  ),
                                  Text(
                                    args.subtitle,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: ColorManger.grey600,
                                    ),
                                  ),
                                ],
                              ),
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
                                        email: args.email,
                                        otp: args.otp,
                                        password:
                                        _passwordController.text.trim(),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: args.primaryColor,
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