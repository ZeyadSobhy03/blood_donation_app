import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/app_localizations.dart';

class EditHospitalProfileDialog extends StatefulWidget {
  final String hospitalName;
  final String department;
  final String contactNumber;
  final String email;
  final String address;
  final void Function({
    required String hospitalName,
    required String department,
    required String contactNumber,
    required String email,
    required String address,
  }) onSave;

  const EditHospitalProfileDialog({
    super.key,
    required this.hospitalName,
    required this.department,
    required this.contactNumber,
    required this.email,
    required this.address,
    required this.onSave,
  });

  @override
  State<EditHospitalProfileDialog> createState() =>
      _EditHospitalProfileDialogState();
}

class _EditHospitalProfileDialogState extends State<EditHospitalProfileDialog> {
  late TextEditingController _nameController;
  late TextEditingController _deptController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.hospitalName);
    _deptController = TextEditingController(text: widget.department);
    _phoneController = TextEditingController(text: widget.contactNumber);
    _emailController = TextEditingController(text: widget.email);
    _addressController = TextEditingController(text: widget.address);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _deptController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.editProfile,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              CustomLabel(text: loc.hospitalName),
              CustomTextField(
                controller: _nameController,
                isPassword: false,
              ),
              const SizedBox(height: 16),
              CustomLabel(text: loc.department),
              CustomTextField(
                controller: _deptController,
                isPassword: false,
              ),
              const SizedBox(height: 16),
              CustomLabel(text: loc.phone),
              CustomTextField(
                controller: _phoneController,
                isPassword: false,
              ),
              const SizedBox(height: 16),
              CustomLabel(text: loc.email),
              CustomTextField(
                controller: _emailController,
                isPassword: false,
              ),
              const SizedBox(height: 16),
              CustomLabel(text: loc.address),
              CustomTextField(
                controller: _addressController,
                isPassword: false,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          loc.cancel,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          widget.onSave(
                            hospitalName: _nameController.text.trim(),
                            department: _deptController.text.trim(),
                            contactNumber: _phoneController.text.trim(),
                            email: _emailController.text.trim(),
                            address: _addressController.text.trim(),
                          );
                          Navigator.pop(context);
                        },
                        child: Text(
                          loc.saveChanges,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
