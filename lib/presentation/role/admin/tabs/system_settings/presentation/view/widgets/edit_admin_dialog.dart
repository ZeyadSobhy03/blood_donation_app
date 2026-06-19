import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/extension/text_ex.dart';
import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/widgets/custom_drop_down_button_form_field.dart';
import '../../../../../../../../core/widgets/custom_label.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../donor/tabs/donate/schedule_donation/widgets/custom_text_form_field.dart';
import 'admin_note_card.dart';

class EditAdminDialog extends StatefulWidget {
  const EditAdminDialog({super.key});

  @override
  State<EditAdminDialog> createState() => _EditAdminDialogState();
}

class _EditAdminDialogState extends State<EditAdminDialog> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  String? selectedAccessLevel;
  String? selectDepartment;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> _accessLevelItems(AppLocalizations loc) {
    return [loc.fullAccess, loc.limitedAccess, loc.viewOnly];
  }

  List<String> _departmentItems(AppLocalizations loc) {
    return [
      loc.systemManagement,
      loc.userSupport,
      loc.dataManagement,
      loc.security,
    ];
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
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
    final accessLevelItems = _accessLevelItems(appLocalization);

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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDialogHeader(
                      title: appLocalization.editAdminProfile,
                      subtitle: appLocalization.updateAdminProfileInfo,
                    ),
                    SizedBox(height: 16),
                    _buildField(
                      keyboardType: TextInputType.text,
                      label: nameLabel,
                      hintText: appLocalization.enterFullName,
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
                      validator: (value) =>
                          (value ?? '').emailValidator(context),
                      label: emilLabel,
                      hintText: appLocalization.enterEmailAddress,
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
                      validator: (value) =>
                          (value ?? '').phoneValidator(context),
                      label: phoneLabel,
                      hintText: appLocalization.enterPhoneNumber,
                      controller: phoneController,
                      context: context,
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                        color: ColorManger.slateGrey,
                      ),
                    ),
                    SizedBox(height: 16),
                    CustomLabel(text: appLocalization.accessLevel),
                    CustomDropDownButtonFormField(
                      items: accessLevelItems,
                      hintText: appLocalization.selectAccessLevel,
                      initialValue: selectedAccessLevel,
                      onChanged: (value) {
                        setState(() {
                          selectedAccessLevel = value;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    CustomLabel(text: appLocalization.department),
                    CustomDropDownButtonFormField(
                      items: _departmentItems(appLocalization),
                      hintText: appLocalization.selectDepartment,
                      initialValue: selectDepartment,
                      onChanged: (value) {
                        setState(() {
                          selectDepartment = value;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    AdminNoteCard(),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            backgroundColor: ColorManger.green,
                            foregroundColor: ColorManger.pureWhite,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: ColorManger.green.withValues(alpha: 0.3),
                                width: 1.1,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            onPressed: () =>
                                _handleSave(context, appLocalization),
                            child: CustomText(
                              text: appLocalization.saveChanges,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: CustomElevatedButton(
                            backgroundColor: ColorManger.pureWhite,
                            foregroundColor: ColorManger.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: ColorManger.grey300,
                                width: 1.1,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: CustomText(text: appLocalization.cancel),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSave(BuildContext context, AppLocalizations appLocalization) {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate access level
    if (selectedAccessLevel == null || selectedAccessLevel!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomText(
            text: appLocalization.pleaseSelectAccessLevel,
            textStyle: TextStyle(color: ColorManger.pureWhite),
          ),
          backgroundColor: ColorManger.brightRed,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    // Validate department
    if (selectDepartment == null || selectDepartment!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomText(
            text: appLocalization.pleasSelectDepartment,
            textStyle: TextStyle(color: ColorManger.pureWhite),
          ),
          backgroundColor: ColorManger.brightRed,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          text: appLocalization.adminAddedSuccessfully,
          textStyle: TextStyle(color: ColorManger.pureWhite),
        ),
        backgroundColor: ColorManger.green,
        duration: Duration(seconds: 2),
      ),
    );

    // Close dialog
    Future.delayed(Duration(milliseconds: 500), () {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    });
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
