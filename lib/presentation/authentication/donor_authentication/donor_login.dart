import 'package:blood_donation_app/core/extension/text_ex.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_auth_box.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/custom_text_field.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/presentation/error_mapper.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';

import '../../../core/resources/models/pin_verification_args.dart';
import '../../../core/service/firebase_notification_service.dart';
import '../../../core/widgets/custom_pin_code.dart';
import '../../role/donor/tabs/notifications/presentation/view_model/fcm/fcm_view_model.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) async {
            if (state is AuthLoginSuccessState) {
              await FirebaseNotificationService.requestPermission();

              final fcmToken = await FirebaseNotificationService.getFCMToken();

              if (fcmToken != null && context.mounted) {
                context.read<FcmCubit>().saveFcmToken(token: fcmToken);
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(appLocalization.donor_login_success_message),
                  backgroundColor: ColorManger.successColor,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(milliseconds: 800),
                ),
              );

              final isEmailVerified =
                  state.loginModel.data?.user?.isEmailVerified ?? true;


              Future.delayed(const Duration(milliseconds: 900), () async {
                if (!context.mounted) return;

                if (!isEmailVerified) {
                  final pinVerified = await _showPinScreen(
                    context,
                    state.user?.email ?? '',
                  );
                  if (!context.mounted) return;

                  if (pinVerified) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteManger.donorMainLayout,
                      (route) => false,
                    );
                  } else {
                    context.read<AuthCubit>().reset();
                  }
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteManger.donorMainLayout,
                    (route) => false,
                  );
                }
              });
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
        ),

        BlocListener<FcmCubit, FcmState>(
          listener: (context, state) {
            if (state is FcmLoadingState) {
            } else if (state is FcmSuccessState) {
            } else if (state is FcmErrorState) {}
          },
        ),
      ],

      child: Scaffold(
        backgroundColor: ColorManger.softPinkishWhite,

        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
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

                              CustomLabel(text: appLocalization.donor_password),

                              const SizedBox(height: 8),

                              CustomTextField(
                                controller: _passwordController,

                                hint: ".........",

                                icon: Icons.lock_outline,

                                isPassword: true,
                              ),

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

                                    child: CustomText(
                                      text: appLocalization.donor_register_now,

                                      textStyle: TextStyle(
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

  Future<bool> _showPinScreen(BuildContext context, String email) async {
    final loc = AppLocalizations.of(context)!;
    final authCubit = context.read<AuthCubit>();

    final result = await Navigator.pushNamed<bool?>(
      context,
      RouteManger.customPinVerificationScreen,
      arguments: PinVerificationArgs(
        title: loc.donor_pin_verification_title,
        subtitle: loc.donor_pin_verification_subtitle,
        submitText: loc.donor_login_button,
        cancelText: loc.cancel,
        invalidPinText: loc.donor_pin_verification_invalid_pin,
        role: AuthPinRole.donor,
        onResend: () async {
          if (email.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(loc.please_enter_email),
                backgroundColor: ColorManger.brightRed,
              ),
            );
            return;
          }

          final ok = await authCubit.resendVerificationEmail(email: email);
          if (!context.mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                ok
                    ? loc.donor_code_resent_success
                    : loc.donor_code_resent_error,
              ),
              backgroundColor: ok
                  ? ColorManger.successColor
                  : ColorManger.brightRed,
            ),
          );
        },
        onSubmit: (pin) async {
          if (email.isEmpty) {
            if (!context.mounted) return false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(loc.please_enter_email),
                backgroundColor: ColorManger.brightRed,
              ),
            );
            return false;
          }

          final ok = await authCubit.verifyEmailOtp(email: email, otp: pin);
          if (!context.mounted) return ok;
          if (ok) Navigator.pop(context, true);
          return ok;
        },
        onCancel: () {
          authCubit.reset();
          Navigator.pop(context, false);
        },
      ),
    );

    return result ?? false;
  }
}
