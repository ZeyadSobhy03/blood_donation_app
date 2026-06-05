import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_success_widget.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/presentation/error_mapper.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubits/map_cubit.dart';
import '../../../core/resources/models/pin_verification_args.dart';
import '../../../core/widgets/custom_pin_code.dart';
import 'presentation/view/widgets/donor_register_form.dart';

class DonorRegister extends StatefulWidget {
  const DonorRegister({super.key});

  @override
  State<DonorRegister> createState() => _DonorRegisterState();
}

class _DonorRegisterState extends State<DonorRegister> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AuthCubit>().reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => MapCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorManger.softPinkishWhite,
        body: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSignUpSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(loc.success),
                    backgroundColor: ColorManger.successColor,
                  ),
                );
              }

              if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      ErrorMapper.map(
                        state.errorKey,
                        AppLocalizations.of(context)!,
                      ),
                    ),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                context.read<AuthCubit>().reset();
              }
            },
            builder: (context, authState) {
              if (authState is AuthLoadingState) {
                return CustomLoadingWidget(message: loc.processingRequest);
              }

              if (authState is AuthSignUpSuccessState) {
                return CustomSuccessWidget<String>(
                  message: loc.registrationSuccess,
                  actionButtonText: loc.continueButton,
                  onAction: () async {
                    if (!authState.needsEmailVerification) {
                      Navigator.pushReplacementNamed(
                        context,
                        RouteManger.donorMainLayout,
                      );
                      return;
                    }

                    final pin = await _showPinScreen(context);
                    if (pin != null) {
                      if (!context.mounted) return;
                      Navigator.pushReplacementNamed(
                        context,
                        RouteManger.donorMainLayout,
                      );
                    } else {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(loc.pinVerificationCancelled),
                          backgroundColor: ColorManger.brightRed,
                        ),
                      );
                    }
                  },
                );
              }

              return const DonorRegisterForm();
            },
          ),
        ),
      ),
    );
  }

  Future<String?> _showPinScreen(BuildContext context) async {
    final loc = AppLocalizations.of(context)!;
    final authCubit = context.read<AuthCubit>();

    return Navigator.pushNamed<String>(
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
          final state = authCubit.state;
          String? email;
          if (state is AuthSignUpSuccessState) {
            email = state.user?.email;
          }

          if (email == null || email.isEmpty) {
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
                ok ? loc.donor_code_resent_success : loc.donor_code_resent_error,
              ),
              backgroundColor:
              ok ? ColorManger.successColor : ColorManger.brightRed,
            ),
          );
        },
        onSubmit: (pin) async {
          final state = authCubit.state;
          String? email;
          if (state is AuthSignUpSuccessState) {
            email = state.user?.email;
          }

          if (email == null || email.isEmpty) {
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
          if (ok) Navigator.pop(context, pin);
          return ok;
        },
        onCancel: () {
          authCubit.reset();
          Navigator.popAndPushNamed(context, RouteManger.donorLogin);
        },
      ),
    );
  }
}