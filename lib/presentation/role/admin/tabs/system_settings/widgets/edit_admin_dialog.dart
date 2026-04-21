import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/extension/text_ex.dart';
import '../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../core/widgets/custom_label.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';

class EditAdminDialog extends StatefulWidget {
  const EditAdminDialog({super.key});

  @override
  State<EditAdminDialog> createState() => _EditAdminDialogState();
}

class _EditAdminDialogState extends State<EditAdminDialog> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController=TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    final String nameLabel = appLocalization.full_name;
    final String emilLabel = appLocalization.emailAddressLabel;
    final String phoneLabel = appLocalization.phoneNumberLabel;

    return Dialog(
      backgroundColor: ColorManger.pureWhite,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: SafeArea(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDialogHeader(
                    title: 'Edit Admin Profile',
                    subtitle: 'Update your administrator profile information.',
                  ),
                  SizedBox(height: 16),
                  _buildField(
                    keyboardType: TextInputType.text,
                    label: nameLabel,
                    hintText: 'Enter full name',
                    controller: nameController,
                    context: context,
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: ColorManger.slateGrey,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => (value ?? '').emailValidator(context),
                    label: emilLabel,
                    hintText: 'Enter email address',
                    controller: emailController,
                    context: context,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: ColorManger.slateGrey,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildField(
                    keyboardType: TextInputType.phone,
                    validator: (value) => (value ?? '').phoneValidator(context),
                    label: phoneLabel,
                    hintText: 'Enter phone number',
                    controller: phoneController,
                    context: context,
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                      color: ColorManger.slateGrey,
                    ),
                  ),
                  SizedBox(height: 16),
                  CustomLabel(text: "Role")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required BuildContext context,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    Widget? prefixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(text: label),
        SizedBox(height: 8),
        CustomTextFormField(
          prefixIcon: prefixIcon,

          textEditingController: controller,
          keyboardType: keyboardType,
          hintText: hintText,
          validator: validator ?? (value) => _requiredValidator(value, context),
        ),
      ],
    );
  }

  String? _requiredValidator(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.fieldIsRequired;
    }
    return null;
  }
}
