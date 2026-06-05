import 'package:blood_donation_app/core/extension/text_ex.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_auth_box.dart';
import 'package:blood_donation_app/core/widgets/custom_drop_down_button_form_field.dart';
import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../../core/cubits/map_cubit.dart';
import '../../view_model/auth_view_model.dart';
import 'location_status_chip.dart';

class DonorRegisterForm extends StatefulWidget {
  const DonorRegisterForm({super.key});

  @override
  State<DonorRegisterForm> createState() => _DonorRegisterFormState();
}

class _DonorRegisterFormState extends State<DonorRegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  DateTime? _selectedBirthDate;

  String? _selectedBloodType;
  String? _selectedGender;
  bool _bloodTypeTouched = false;

  final List<String> _bloodTypes = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-',
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  Future<void> _selectBirthDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedBirthDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 16)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(
            primary: ColorManger.brightRed,
            onPrimary: ColorManger.pureWhite,
            onSurface: ColorManger.black,
          ),
        ),
        child: child ?? const SizedBox(),
      ),
    );

    if (picked != null && picked != _selectedBirthDate) {
      setState(() {
        _selectedBirthDate = picked;
        _birthDateController.text = _formatDate(picked);
      });
    }
  }

  void _handleRegister(BuildContext context, AppLocalizations loc) {
    setState(() => _bloodTypeTouched = true);

    final formValid = _formKey.currentState!.validate();
    final bloodTypeValid = _selectedBloodType != null;
    if (!formValid || !bloodTypeValid) return;

    final mapState = context.read<MapCubit>().state;

    if (mapState is MapPermissionPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.locationPermanentlyDenied),
          backgroundColor: ColorManger.brightRed,
          action: SnackBarAction(
            label: loc.openSettings,
            textColor: Colors.white,
            onPressed: () => Geolocator.openAppSettings(),
          ),
        ),
      );
      return;
    }

    if (mapState is! MapLoaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.locationNotReady),
          backgroundColor: ColorManger.brightRed,
        ),
      );
      return;
    }

    context.read<AuthCubit>().signUp(
      fullName: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      phoneNumber: _phoneController.text.trim(),
      dateOfBirth: _birthDateController.text.trim(),
      bloodType: _selectedBloodType!,
      gender: _selectedGender ?? '',
      role: 'donor',
      governorate: mapState.governorate,
      city: mapState.city,
      lat: mapState.latitude,
      lng: mapState.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final Map<String, String> genders = {
      loc.male: 'male',
      loc.female: 'female',
    };

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.only(
          left: 24.0,
          right: 24.0,
          top: 20.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: ColorManger.grey600),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.favorite_border, color: ColorManger.brightRed, size: 32),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: loc.donor_login_title,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorManger.black,
                        ),
                      ),
                      Text(
                        loc.donor_login_subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: ColorManger.grey600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              BlocBuilder<MapCubit, MapState>(
                builder: (context, mapState) {
                  return LocationStatusChip(
                    state: mapState,
                    onTap: mapState is MapPermissionPermanentlyDenied
                        ? () => Geolocator.openAppSettings()
                        : null,
                  );
                },
              ),
              const SizedBox(height: 12),
              CustomAuthBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: loc.donor_register_title,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: ColorManger.black,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Full Name
                    CustomLabel(text: loc.full_name),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      keyboardType: TextInputType.name,
                      textEditingController: _fullNameController,
                      validator: (value) => value?.nameValidator(context),
                      hintText: 'John Doe',
                      prefixIcon: const Icon(Icons.person_outline),
                      obscureText: false,
                    ),
                    const SizedBox(height: 16),

                    // Email
                    CustomLabel(text: loc.donor_email),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textEditingController: _emailController,
                      validator: (value) => value?.emailValidator(context),
                      hintText: 'donor@example.com',
                      prefixIcon: const Icon(Icons.email_outlined),
                      obscureText: false,
                    ),
                    const SizedBox(height: 16),

                    // Phone
                    CustomLabel(text: loc.phone_number),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      keyboardType: TextInputType.phone,
                      textEditingController: _phoneController,
                      validator: (value) => value?.phoneValidator(context),
                      hintText: '+1 (555) 000-0000',
                      prefixIcon: const Icon(Icons.phone_outlined),
                      obscureText: false,
                    ),
                    const SizedBox(height: 16),

                    // Blood Type
                    CustomLabel(text: loc.donor_blood_type),
                    const SizedBox(height: 8),
                    CustomDropDownButtonFormField(
                      items: _bloodTypes,
                      hintText: loc.donor_select_blood_type,
                      onChanged: (val) => setState(() {
                        _selectedBloodType = val;
                        _bloodTypeTouched = true;
                      }),
                      initialValue: _selectedBloodType,
                      prefixIcon: const Icon(
                        Icons.water_drop_outlined,
                        color: ColorManger.slateGrey,
                      ),
                    ),
                    if (_bloodTypeTouched && _selectedBloodType == null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6, left: 4),
                        child: Text(
                          loc.donor_select_blood_type,
                          style: const TextStyle(
                            color: ColorManger.brightRed,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),

                    // Gender
                    CustomLabel(text: loc.gender),
                    const SizedBox(height: 8),
                    CustomDropDownButtonFormField(
                      items: genders.keys.toList(),
                      hintText: loc.selectGender,
                      onChanged: (val) => setState(() {
                        _selectedGender = genders[val];
                      }),
                      initialValue: _selectedGender == null
                          ? null
                          : genders.keys.firstWhere(
                            (key) => genders[key] == _selectedGender,
                      ),
                      prefixIcon: const Icon(
                        Icons.people_outline,
                        color: ColorManger.slateGrey,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Date of Birth
                    CustomLabel(text: loc.dateOfBirth),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _selectBirthDate,
                      child: AbsorbPointer(
                        child: CustomTextFormField(
                          keyboardType: TextInputType.datetime,
                          textEditingController: _birthDateController,
                          hintText: loc.dateHint,
                          prefixIcon: const Icon(Icons.calendar_today_outlined),
                          obscureText: false,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Password
                    CustomLabel(text: loc.donor_password),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      textEditingController: _passwordController,
                      hintText: '••••••••',
                      prefixIcon: const Icon(Icons.lock_outline),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),

                    // Confirm Password
                    CustomLabel(text: loc.confirm_password),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      textEditingController: _confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return loc.fieldIsRequired;
                        }
                        if (value != _passwordController.text) {
                          return loc.passwordsDoNotMatch;
                        }
                        return null;
                      },
                      hintText: '••••••••',
                      prefixIcon: const Icon(Icons.lock_outline),
                      obscureText: true,
                    ),
                    const SizedBox(height: 32),

                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => _handleRegister(context, loc),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManger.brightRed,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          loc.donor_register_now,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          loc.already_have_account,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            loc.donor_login_button,
                            style: const TextStyle(
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
}