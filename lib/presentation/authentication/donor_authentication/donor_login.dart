import 'package:blood_donation_app/core/extension/text_ex.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_auth_box.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text_field.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/presentation/error_mapper.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';

class DonorLogin extends StatefulWidget {
  const DonorLogin({super.key});

  @override
  State<DonorLogin> createState() => _DonorLoginState();
}

class _DonorLoginState extends State<DonorLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  Future<void> _handleLoginPressed() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    context.read<AuthCubit>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

            child: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoginSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(appLocalization.success),
                      backgroundColor: ColorManger.successColor,
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(milliseconds: 800),
                    ),
                  );

                  Future.delayed(const Duration(milliseconds: 900), () {
                    if (!context.mounted) return;

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteManger.donorMainLayout,
                      (route) => false,
                    );
                  });
                }

                // ERROR
                if (state is AuthErrorState) {
                  final message = ErrorMapper.map(
                    state.errorKey,
                    appLocalization,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },

              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  // LOADING
                  if (state is AuthLoadingState) {
                    return CustomLoadingWidget(
                      message: appLocalization.processingRequest,
                      indicatorColor: ColorManger.brightRed,
                    );
                  }

                  return Form(
                    key: _formKey,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        // HEADER
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: ColorManger.grey600,
                              ),

                              onPressed: () {
                                Navigator.pop(context);
                              },
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
                                  appLocalization.donor_login_title,

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

                        const SizedBox(height: 30),

                        // LOGIN CARD
                        CustomAuthBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                appLocalization.donor_login_card_title,

                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: ColorManger.black,
                                ),
                              ),

                              const SizedBox(height: 24),

                              // EMAIL
                              CustomLabel(text: appLocalization.donor_email),

                              const SizedBox(height: 8),

                              CustomTextField(
                                controller: _emailController,

                                validator: (value) =>
                                    value?.emailValidator(context),

                                hint: "someone@example.com",

                                icon: Icons.email_outlined,

                                isPassword: false,
                              ),

                              const SizedBox(height: 20),

                              // PASSWORD
                              CustomLabel(text: appLocalization.donor_password),

                              const SizedBox(height: 8),

                              CustomTextField(
                                controller: _passwordController,

                                hint: ".........",

                                icon: Icons.lock_outline,

                                isPassword: true,
                              ),

                              // FORGET PASSWORD
                              Align(
                                alignment: Alignment.centerRight,

                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteManger.donorForgetPassword,
                                    );
                                  },

                                  child: Text(
                                    appLocalization.donor_forget_password,

                                    style: const TextStyle(
                                      color: ColorManger.brightRed,

                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),

                              // LOGIN BUTTON
                              SizedBox(
                                width: double.infinity,
                                height: 50,

                                child: ElevatedButton(
                                  onPressed: _handleLoginPressed,

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

                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 24),

                              // REGISTER
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Text(
                                    appLocalization.donor_dont_have_account,

                                    style: TextStyle(color: Colors.grey[600]),
                                  ),

                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        RouteManger.donorRegister,
                                      );
                                    },

                                    child: const Text(
                                      "Register Now",

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
