import 'package:blood_donation_app/core/extension/text_ex.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_auth_box.dart';
import 'package:blood_donation_app/core/widgets/custom_drop_down_button_form_field.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/custom_text_field.dart';
import 'package:blood_donation_app/core/widgets/states/custom_error_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_loading_widget.dart';
import 'package:blood_donation_app/core/widgets/states/custom_success_widget.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/presentation/error_mapper.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/resources/models/pin_verification_args.dart';
import '../../../core/widgets/custom_pin_code.dart';

class DonorRegister extends StatefulWidget {
  const DonorRegister({super.key});

  @override
  State<DonorRegister> createState() => _DonorRegisterState();
}

class _DonorRegisterState extends State<DonorRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _selectedBloodType;
  final List<String> _bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dateOfBirthController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorManger.softPinkishWhite,
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSignUpSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(appLocalization.success),
                  backgroundColor: ColorManger.successColor,
                ),
              );
            }
          },
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return CustomLoadingWidget(
                  message: appLocalization.processingRequest,
                );
              }

              if (state is AuthErrorState) {
                final text = ErrorMapper.map(
                  state.errorKey,
                  AppLocalizations.of(context)!,
                );

                return CustomErrorWidget(
                  message: text,
                  onRetry: () {
                    context.read<AuthCubit>().reset();
                  },
                  onDismiss: () {
                    context.read<AuthCubit>().reset();
                  },
                );
              }

              if (state is AuthSignUpSuccessState) {
                return CustomSuccessWidget<String>(
                  data: state.user?.email ?? appLocalization.registration,
                  message: appLocalization.registrationSuccess,
                  actionButtonText: appLocalization.continueButton,
                  onAction: () async {
                    if (!state.needsEmailVerification) {
                      Navigator.pushReplacementNamed(
                        context,
                        RouteManger.donorMainLayout,
                      );
                      return;
                    }

                    final pin = await _showPinScreen();
                    if (!mounted) return;
                    if (pin != null) {
                      Navigator.pushReplacementNamed(
                        context,
                        RouteManger.donorMainLayout,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(appLocalization.pinVerificationCancelled),
                          backgroundColor: ColorManger.brightRed,
                        ),
                      );
                    }
                  },
                );
              }

              return _buildRegisterForm(context, appLocalization);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterForm(
    BuildContext context,
    AppLocalizations appLocalization,
  ) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: ColorManger.grey600,
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
                      CustomText(
                        text: appLocalization.donor_login_title,
                        textStyle: TextStyle(
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
              const SizedBox(height: 20),
              CustomAuthBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: appLocalization.donor_register_title,
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: ColorManger.black,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Full Name
                    CustomLabel(text: appLocalization.full_name),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: _fullNameController,
                      validator: (value) => value?.nameValidator(context),
                      hint: "John Doe",
                      icon: Icons.person_outline,
                      isPassword: false,
                    ),
                    const SizedBox(height: 16),
                    // Email
                    CustomLabel(text: appLocalization.donor_email),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: _emailController,
                      validator: (value) => value?.emailValidator(context),
                      hint: "donor@example.com",
                      icon: Icons.email_outlined,
                      isPassword: false,
                    ),
                    const SizedBox(height: 16),
                    // Phone Number
                    CustomLabel(text: appLocalization.phone_number),
                    const SizedBox(height: 8),
                    CustomTextField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      validator: (value) => value?.phoneValidator(context),
                      hint: "+1 (555) 000-0000",
                      icon: Icons.phone_outlined,
                      isPassword: false,
                    ),
                    const SizedBox(height: 16),
                    // Blood Type
                    CustomLabel(text: appLocalization.donor_blood_type),
                    const SizedBox(height: 8),
                    CustomDropDownButtonFormField(
                      items: _bloodTypes,
                      hintText: appLocalization.donor_select_blood_type,
                      onChanged: (val) =>
                          setState(() => _selectedBloodType = val),
                      initialValue: _selectedBloodType,
                      prefixIcon: Icon(
                        Icons.water_drop_outlined,
                        color: ColorManger.slateGrey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomLabel(text: appLocalization.dateOfBirth),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: CustomTextField(
                        controller: _dateOfBirthController,
                        validator: (value) => value?.isEmpty == true
                            ? appLocalization.dateRequired
                            : null,
                        hint: appLocalization.dateHint,
                        icon: Icons.calendar_today_outlined,
                        isPassword: false,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Password
                    CustomLabel(text: appLocalization.donor_password),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: _passwordController,

                      hint: "••••••••",
                      icon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    const SizedBox(height: 16),
                    CustomLabel(text: appLocalization.confirm_password),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      hint: "••••••••",
                      icon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    const SizedBox(height: 32),
                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => _handleRegister(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManger.brightRed,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          appLocalization.donor_register_now,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          appLocalization.already_have_account,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            appLocalization.donor_login_button,
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
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _dateOfBirthController.text =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _handleRegister(BuildContext context) {
    if (_formKey.currentState!.validate() && _selectedBloodType != null) {
      context.read<AuthCubit>().signUp(
        fullName: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        phoneNumber: _phoneController.text.trim(),
        dateOfBirth: _dateOfBirthController.text.trim(),
        bloodType: _selectedBloodType!,
      );
    } else if (_selectedBloodType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.donor_select_blood_type),
          backgroundColor: ColorManger.brightRed,
        ),
      );
    }
  }
  Future<String?> _showPinScreen() async {
    final appLocalization = AppLocalizations.of(context)!;
    return Navigator.pushNamed<String>(
      context,
      RouteManger.customPinVerificationScreen,
      arguments: PinVerificationArgs(
        title: appLocalization.donor_pin_verification_title,
        subtitle: appLocalization.donor_pin_verification_subtitle,
        submitText: appLocalization.donor_login_button,
        cancelText: appLocalization.cancel,
        invalidPinText: appLocalization.donor_pin_verification_invalid_pin,
        role: AuthPinRole.donor,
        onResend: () async {
          final email = _emailController.text.trim();
          if (email.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(appLocalization.please_enter_email),
                backgroundColor: ColorManger.brightRed,
              ),
            );
            return;
          }

          final ok = await context
              .read<AuthCubit>()
              .resendVerificationEmail(email: email);
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                ok
                    ? appLocalization.donor_code_resent_success
                    : appLocalization.donor_code_resent_error,
              ),
              backgroundColor:
                  ok ? ColorManger.successColor : ColorManger.brightRed,
            ),
          );
        },
        onSubmit: (pin) async {
          final email = _emailController.text.trim();
          if (email.isEmpty) {
            if (!mounted) return false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(appLocalization.please_enter_email),
                backgroundColor: ColorManger.brightRed,
              ),
            );
            return false;
          }

          final ok = await context
              .read<AuthCubit>()
              .verifyEmailOtp(email: email, otp: pin);
          if (!mounted) return ok;
          if (ok) {
            Navigator.pop(context, pin);
          }
          return ok;
        },
      ),
    );
  }
}
