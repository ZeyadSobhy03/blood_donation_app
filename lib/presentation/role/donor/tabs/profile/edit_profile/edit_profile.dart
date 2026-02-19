import 'package:blood_donation_app/core/resources/colors/color_manger.dart';

import 'package:blood_donation_app/core/widgets/loading_container.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/edit_profile/section/edit_body.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/edit_profile/section/edit_header.dart';
import 'package:blood_donation_app/presentation/role/donor/tabs/profile/edit_profile/section/edit_navigation.dart';
import 'package:flutter/material.dart';

class EditProfileDialog extends StatefulWidget {
  final String initialName;
  final String initialEmail;
  final String initialPhone;
  final String initialLocation;
  final String initialBloodType;
  final String initialWeight;
  final String initialAge;
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
    required this.initialGender,
  });

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _locationController;
  late TextEditingController _bloodTypeController;
  late TextEditingController _weightController;
  late TextEditingController _ageController;

  String _selectedGender = 'Female';
  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _emailController = TextEditingController(text: widget.initialEmail);
    _phoneController = TextEditingController(text: widget.initialPhone);
    _locationController = TextEditingController(text: widget.initialLocation);
    _bloodTypeController = TextEditingController(text: widget.initialBloodType);
    _weightController = TextEditingController(text: widget.initialWeight);
    _ageController = TextEditingController(text: widget.initialAge);
    _selectedGender = widget.initialGender;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _bloodTypeController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1200));

    if (mounted) {
      Navigator.pop(context, {
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'location': _locationController.text,
        'bloodType': _bloodTypeController.text,
        'weight': _weightController.text,
        'age': _ageController.text,
        'gender': _selectedGender,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 300,
              maxWidth: 400,
              maxHeight: 600,
            ),
            child: Container(
              width: double.infinity,
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
                          // Header
                          EditHeader(),

                          EditBody(
                            nameController: _nameController,
                            emailController: _emailController,
                            phoneController: _phoneController,
                            locationController: _locationController,
                            bloodTypeController: _bloodTypeController,
                            weightController: _weightController,
                            ageController: _ageController,
                            selectedGender: _selectedGender,
                            bloodTypes: _bloodTypes,
                            genders: _genders,
                          ),

                          // Buttons
                          EditNavigation(
                            isLoading: _isLoading,
                            handelSave: _handleSave,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Loading Overlay
                  if (_isLoading) LoadingContainer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
