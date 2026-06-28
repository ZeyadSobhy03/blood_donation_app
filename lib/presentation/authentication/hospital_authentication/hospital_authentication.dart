import 'package:blood_donation_app/core/extension/text_ex.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/models/pin_verification_args.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/service/firebase_notification_service.dart';
import 'package:blood_donation_app/core/widgets/custom_auth_box.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_pin_code.dart';
import 'package:blood_donation_app/core/widgets/custom_text_field.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/presentation/view_model/hospital_view_model.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/notifications/presentation/view_model/fcm/fcm_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void _handleLoginPressed() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final loc = AppLocalizations.of(context)!;
    context.read<HospitalCubit>().login(
      hospitalId: _hospitalIdController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      loc: loc,
    );
  }

  Future<void> _onLoginSuccess() async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteManger.hospitalMainLayout,
          (route) => false,
    );
  }

  Future<String?> _showPinScreen() {
    final appLocalization = AppLocalizations.of(context)!;
    return Navigator.pushNamed<String>(
      context,
      RouteManger.customPinVerificationScreen,
      arguments: PinVerificationArgs(
        style: const PinVerificationStyle(
          screenBackgroundColor: ColorManger.veryLightBlue,
          appBarBackgroundColor: ColorManger.veryLightBlue,
          submitBackgroundColor: ColorManger.royalBlue,
          cancelBackgroundColor: ColorManger.accentBlue,
          cancelForegroundColor: ColorManger.royalBlue,
          cancelBorderColor: ColorManger.skyBlue,
        ),
        pinLength: 6,
        title: appLocalization.donor_pin_verification_title,
        subtitle: appLocalization.donor_pin_verification_subtitle,
        submitText: appLocalization.secure_login,
        cancelText: appLocalization.cancel,
        invalidPinText: appLocalization.donor_pin_verification_invalid_pin,
        role: AuthPinRole.hospital,
      ),
    );
  }

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
            child: BlocListener<HospitalCubit, HospitalState>(
              listener: (context, state) async {
                if (state is HospitalLoginSuccessState) {
                  await FirebaseNotificationService.requestPermission();
                  final fcmToken = await FirebaseNotificationService.getFCMToken();
                  if (fcmToken != null && context.mounted) {
                    final token = state.accessToken;
                    if (token != null) {
                      context.read<FcmCubit>().saveFcmToken(
                        token: fcmToken,
                        accessToken: token,
                      );
                    }
                  }
                  if (context.mounted) await _onLoginSuccess();
                }

                if (state is HospitalErrorState) {
                  if (!context.mounted) return;
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
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManger.black,
                                  ),
                                ),
                                Text(
                                  appLocalization.authorized_access_only,
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
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorManger.accentBlue,
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                  Border.all(color: ColorManger.skyBlue),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.shield_outlined,
                                      color: ColorManger.royalBlue,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      appLocalization.secure_login,
                                      style: const TextStyle(
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
                                style: const TextStyle(
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
                                hint: 'HOSP-12345',
                                icon: Icons.domain,
                                isPassword: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return appLocalization
                                        .please_enter_hospital_id;
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 16),

                              CustomLabel(
                                  text: appLocalization.official_email),
                              const SizedBox(height: 8),
                              CustomTextField(
                                controller: _emailController,
                                hint: 'admin@hospital.org',
                                icon: Icons.email_outlined,
                                isPassword: false,
                                validator: (value) =>
                                    value?.emailValidator(context),
                              ),

                              const SizedBox(height: 16),

                              CustomLabel(
                                  text: appLocalization.secure_password),
                              const SizedBox(height: 8),
                              CustomTextField(
                                controller: _passwordController,
                                hint: '••••••••',
                                icon: Icons.lock_outline,
                                isPassword: true,
                                validator: (value) =>
                                    value?.passwordValidator(context),
                              ),

                              const SizedBox(height: 8),

                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    RouteManger.hospitalForgetPassword,
                                  ),
                                  child: Text(
                                    appLocalization.donor_forget_password,
                                    style: const TextStyle(
                                      color: ColorManger.skyBlue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 24),

                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _handleLoginPressed,
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
                                    style: const TextStyle(
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
                                  border:
                                  Border.all(color: Colors.grey[200]!),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appLocalization.new_hospital_patient,
                                      style: const TextStyle(
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
                                            text: appLocalization
                                                .hospital_contact_text_1,
                                          ),
                                          const TextSpan(
                                            text: 'support@lifelink.org',
                                            style: TextStyle(
                                              color: ColorManger.skyBlue,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text: appLocalization
                                                .hospital_contact_text_2,
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