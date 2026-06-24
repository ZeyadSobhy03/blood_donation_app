import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/resources/fonts/font_manger.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/users/data/model/users_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../l10n/app_localizations.dart';

class UserEditSheet extends StatefulWidget {
  final Users user;

  const UserEditSheet({super.key, required this.user});

  static Future<Map<String, dynamic>?> show(
      BuildContext context,
      Users user,
      ) {
    return showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => UserEditSheet(user: user),
    );
  }

  @override
  State<UserEditSheet> createState() => _UserEditSheetState();
}

class _UserEditSheetState extends State<UserEditSheet> {
  late final TextEditingController _fullNameController;

  late final TextEditingController _donorPhoneController;
  String? _selectedBloodType;

  late final TextEditingController _hospitalNameController;
  late final TextEditingController _hospitalPhoneController;
  late final TextEditingController _capacityController;
  List<String> _selectedBloodBanks = [];

  bool _isSuspended = false;

  static const List<String> _bloodTypes = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-',
  ];

  bool get _isDonor => widget.user.role == 'donor';
  bool get _isHospital => widget.user.role == 'hospital';
  bool get _isAdmin => widget.user.role == 'admin';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(
      text: widget.user.fullName ?? widget.user.name ?? '',
    );

    if (_isDonor) {
      _donorPhoneController = TextEditingController(
        text: widget.user.phoneNumber ?? '',
      );
      _selectedBloodType = widget.user.bloodType;
    } else if (_isHospital) {
      _hospitalNameController = TextEditingController(
        text: widget.user.name ?? widget.user.fullName ?? '',
      );
      _hospitalPhoneController = TextEditingController(
        text: widget.user.phone ?? '',
      );
      _capacityController = TextEditingController();
      _selectedBloodBanks = [];
    } else if (_isAdmin) {
      _isSuspended = widget.user.isSuspended ?? false;
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    if (_isDonor) {
      _donorPhoneController.dispose();
    } else if (_isHospital) {
      _hospitalNameController.dispose();
      _hospitalPhoneController.dispose();
      _capacityController.dispose();
    }
    super.dispose();
  }

  void _handleSave() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    Map<String, dynamic> data;

    if (_isDonor) {
      data = {
        'type': 'donor',
        'fullName': _fullNameController.text.trim(),
        'phoneNumber': _donorPhoneController.text.trim(),
        'bloodType': _selectedBloodType ?? '',
      };
    } else if (_isHospital) {
      data = {
        'type': 'hospital',
        'fullName': _fullNameController.text.trim(),
        'hospitalName': _hospitalNameController.text.trim(),
        'phone': _hospitalPhoneController.text.trim(),
        'bloodBanksAvailable': List<String>.from(_selectedBloodBanks),
        'capacity': int.tryParse(_capacityController.text.trim()) ?? 0,
      };
    } else if (_isAdmin) {
      data = {
        'type': 'admin',
        'fullName': _fullNameController.text.trim(),
        'isSuspended': _isSuspended,
      };
    } else {
      return;
    }

    Navigator.of(context).pop(data);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: ColorManger.pureWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: ColorManger.grey300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CustomText(
                  text: _isDonor
                      ? appLocalization.editDonor
                      : _isHospital
                      ? appLocalization.editHospital
                      : appLocalization.editAdmin,
                  textStyle: const TextStyle(
                    fontSize: FontSize.s18,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManger.black,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextFormField(
                  controller: _fullNameController,
                  label: appLocalization.fullName,
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return appLocalization.fullName;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                if (_isDonor) ..._buildDonorFields(appLocalization),
                if (_isHospital) ..._buildHospitalFields(appLocalization),
                if (_isAdmin) ..._buildAdminFields(appLocalization),
                const SizedBox(height: 24),
                CustomElevatedButton(
                  onPressed: _handleSave,
                  backgroundColor: ColorManger.successColor,
                  foregroundColor: ColorManger.pureWhite,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  CustomText(
                    text:appLocalization.save ,
                    textStyle: TextStyle(
                      color: ColorManger.pureWhite,
                      fontSize: FontSize.s16,
                      fontWeight: FontWeightManager.semiBold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                CustomElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  backgroundColor: ColorManger.pureWhite,
                  foregroundColor: ColorManger.black,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: ColorManger.lightGrey),
                  ),
                  child: CustomText(
                    text: appLocalization.cancel,
                    textStyle: const TextStyle(
                      color: ColorManger.black,
                      fontSize: FontSize.s16,
                      fontWeight: FontWeightManager.medium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDonorFields(AppLocalizations appLocalization) {
    return [
      _buildTextFormField(
        controller: _donorPhoneController,
        label: appLocalization.phoneNumber,
        icon: Icons.phone_outlined,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return appLocalization.phoneNumber;
          }
          return null;
        },
      ),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(
        initialValue: _selectedBloodType,
        decoration: InputDecoration(
          labelText: appLocalization.bloodType,
          prefixIcon: const Icon(Icons.bloodtype_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ColorManger.lightGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ColorManger.brightRed),
          ),
        ),
        items: _bloodTypes.map((type) {
          return DropdownMenuItem(value: type, child: Text(type));
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedBloodType = value;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return appLocalization.bloodType;
          }
          return null;
        },
      ),
    ];
  }

  List<Widget> _buildHospitalFields(AppLocalizations appLocalization) {
    return [
      _buildTextFormField(
        controller: _hospitalNameController,
        label: appLocalization.hospitalName,
        icon: Icons.local_hospital_outlined,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return appLocalization.hospitalName;
          }
          return null;
        },
      ),
      const SizedBox(height: 12),
      _buildTextFormField(
        controller: _hospitalPhoneController,
        label: appLocalization.phoneNumber,
        icon: Icons.phone_outlined,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return appLocalization.phoneNumber;
          }
          return null;
        },
      ),
      const SizedBox(height: 12),
      _buildTextFormField(
        controller: _capacityController,
        label: appLocalization.capacity,
        icon: Icons.people_outline,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return appLocalization.capacity;
          }
          return null;
        },
      ),
      const SizedBox(height: 12),
      CustomText(
        text: appLocalization.bloodBanksAvailable,
        textStyle: const TextStyle(
          fontSize: FontSize.s14,
          fontWeight: FontWeightManager.medium,
          color: ColorManger.black,
        ),
      ),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: _bloodTypes.map((type) {
          final isSelected = _selectedBloodBanks.contains(type);
          return FilterChip(
            label: Text(type),
            selected: isSelected,
            selectedColor: ColorManger.lightBlue,
            checkmarkColor: ColorManger.royalBlue,
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  _selectedBloodBanks.add(type);
                } else {
                  _selectedBloodBanks.remove(type);
                }
              });
            },
          );
        }).toList(),
      ),
    ];
  }

  List<Widget> _buildAdminFields(AppLocalizations appLocalization) {
    return [
      SwitchListTile(
        title: CustomText(
          text: appLocalization.banUser,
          textStyle: const TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.medium,
          ),
        ),
        value: _isSuspended,
        activeThumbColor: ColorManger.brightRed,
        contentPadding: EdgeInsets.zero,
        onChanged: (value) {
          setState(() {
            _isSuspended = value;
          });
        },
      ),
    ];
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorManger.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorManger.royalBlue),
        ),
      ),
    );
  }
}