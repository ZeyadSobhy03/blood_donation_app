import 'package:blood_donation_app/core/widgets/custom_label.dart';
import 'package:blood_donation_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class EditHospitalProfileDialog extends StatefulWidget {
  const EditHospitalProfileDialog({super.key});

  @override
  State<EditHospitalProfileDialog> createState() => _EditHospitalProfileDialogState();
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
    _nameController = TextEditingController(text: "Metro General Hospital");
    _deptController = TextEditingController(text: "Emergency Department");
    _phoneController = TextEditingController(text: "+1 (555) 987-6543");
    _emailController = TextEditingController(text: "emergency@metrohealth.com");
    _addressController =
        TextEditingController(text: "123 Medical Center Dr, City");
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
                  const Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                        Icons.close, size: 20, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              CustomLabel(text: "Hospital Name"),
              CustomTextField(controller: _nameController, isPassword: false,),
              const SizedBox(height: 16),

              CustomLabel(text: "Department"),
              CustomTextField(controller: _deptController, isPassword: false,),
              const SizedBox(height: 16),

              CustomLabel(text: "Phone"),
              CustomTextField(controller: _phoneController, isPassword: false,),
              const SizedBox(height: 16),

              CustomLabel(text: "Email"),
              CustomTextField(controller: _emailController, isPassword: false,),
              const SizedBox(height: 16),

              CustomLabel(text: "Address"),
              CustomTextField(
                controller: _addressController, isPassword: false,),
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
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel", style: TextStyle(
                            fontWeight: FontWeight.w600)),
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
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Save Changes",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
