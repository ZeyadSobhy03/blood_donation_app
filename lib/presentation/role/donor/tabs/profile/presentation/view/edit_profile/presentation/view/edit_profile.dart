import 'package:blood_donation_app/core/cubits/map_cubit.dart';
import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/core/widgets/loading_container.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/presentation/view/section/edit_body.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/presentation/view/section/edit_header.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/presentation/view/section/edit_navigation.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view/edit_profile/presentation/view_model/edit_profile_view_model.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/presentation/view_model/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileDialog extends StatefulWidget {
  final String initialName;
  final String initialEmail;
  final String initialPhone;
  final String initialLocation;
  final String initialBloodType;
  final String initialWeight;
  final String initialAge;
  final DateTime? initialBirthDate;
  final String initialGender;

  const EditProfileDialog({
    super.key,
    required this.initialName,
    required this.initialEmail,
    required this.initialPhone,
    required this.initialLocation,
    required this.initialBloodType,
    required this.initialWeight,
    required this.initialAge,
    this.initialBirthDate,
    required this.initialGender,
  });

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _cityController;
  late final TextEditingController _governorateController;
  late final TextEditingController _bloodTypeController;
  late final TextEditingController _weightController;
  late final TextEditingController _ageController;
  late final TextEditingController _birthDateController;

  late String _selectedGender;
  late DateTime _selectedBirthDate;

  double _latitude = 0.0;
  double _longitude = 0.0;

  static const List<String> _bloodTypes = [
    'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-',
  ];

  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _weightError;
  String? _birthDateError;

  @override
  void initState() {
    super.initState();
    _initControllers();
    _getLatLong();
  }

  void _initControllers() {
    _nameController = TextEditingController(text: widget.initialName);
    _emailController = TextEditingController(text: widget.initialEmail);
    _phoneController = TextEditingController(text: widget.initialPhone);

    final locationParts = widget.initialLocation.split(',');
    final city = locationParts.isNotEmpty ? locationParts[0].trim() : 'Cairo';
    final governorate =
    locationParts.length > 1 ? locationParts[1].trim() : 'Cairo';

    _cityController = TextEditingController(text: city);
    _governorateController = TextEditingController(text: governorate);
    _bloodTypeController =
        TextEditingController(text: widget.initialBloodType);
    _weightController = TextEditingController(text: widget.initialWeight);
    _ageController = TextEditingController(text: widget.initialAge);
    _selectedGender = widget.initialGender;

    _selectedBirthDate = widget.initialBirthDate ??
        DateTime.now().subtract(
          Duration(days: (int.tryParse(widget.initialAge) ?? 0) * 365),
        );

    _birthDateController =
        TextEditingController(text: _formatDate(_selectedBirthDate));
  }

  void _getLatLong() {
    final state = context.read<MapCubit>().state;
    if (state is MapLoaded) {
      _latitude = state.latitude;
      _longitude = state.longitude;
    }
  }

  String _formatDate(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  int _calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  bool _validateInputs(AppLocalizations l10n) {
    setState(() {
      _nameError =
      _nameController.text.trim().isEmpty ? l10n.nameIsRequired : null;
      _emailError =
      _emailController.text.trim().isEmpty ? l10n.emailIsRequired : null;
      _phoneError =
      _phoneController.text.trim().isEmpty ? l10n.phoneIsRequired : null;
      _weightError =
      _weightController.text.trim().isEmpty ? l10n.weightIsRequired : null;
      _birthDateError = null;
    });

    return _nameError == null &&
        _emailError == null &&
        _phoneError == null &&
        _weightError == null;
  }

  Future<void> _selectBirthDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedBirthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 16)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: ColorScheme.light(
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
        _ageController.text = _calculateAge(picked).toString();
      });
    }
  }

  Future<void> _handleSave() async {
    final l10n = AppLocalizations.of(context)!;
    if (!_validateInputs(l10n)) return;

    final weight = int.tryParse(_weightController.text.trim()) ?? 0;

    context.read<EditProfileCubit>().editProfile(
      dateOfBirth: _birthDateController.text,
      city: _cityController.text.trim(),
      governorate: _governorateController.text.trim(),
      lat: _latitude,
      lng: _longitude,
      fullName: _nameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      bloodType: _bloodTypeController.text,
      weight: weight,
      gender: _selectedGender,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _governorateController.dispose();
    _bloodTypeController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        final l10n = AppLocalizations.of(context)!;

        if (state is EditProfileSuccessState) {
          context.read<ProfileCubit>().fetchProfile();
          Navigator.pop(context, true);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomText(text: l10n.profile_updated_successfully),
              backgroundColor: ColorManger.green,
              
            ),
          );
        } else if (state is EditProfileErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(localizeError(state.message, l10n)),
              backgroundColor: ColorManger.brightRed,
            ),
          );
        }
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            final isLoading = state is EditProfileLoadingState;

            return ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 300,
                maxWidth: 400,
                maxHeight: 700,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: ColorManger.pureWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const EditHeader(),
                            EditBody(
                              nameController: _nameController,
                              emailController: _emailController,
                              phoneController: _phoneController,
                              cityController: _cityController,
                              governorateController: _governorateController,
                              bloodTypeController: _bloodTypeController,
                              weightController: _weightController,
                              ageController: _ageController,
                              birthDateController: _birthDateController,
                              selectedGender: _selectedGender,
                              bloodTypes: _bloodTypes,
                              onGenderChanged: (value) =>
                                  setState(() => _selectedGender = value),
                              onBirthDateTap: _selectBirthDate,
                              nameError: _nameError,
                              emailError: _emailError,
                              phoneError: _phoneError,
                              weightError: _weightError,
                              birthDateError: _birthDateError,
                            ),
                            EditNavigation(
                              isLoading: isLoading,
                              handelSave: _handleSave,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isLoading) const LoadingContainer(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}