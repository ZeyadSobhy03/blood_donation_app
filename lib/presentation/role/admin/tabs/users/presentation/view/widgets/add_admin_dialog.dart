import 'dart:developer';

import 'package:blood_donation_app/core/resources/colors/color_manger.dart';
import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_drop_down_button_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/extension/text_ex.dart';
import '../../../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../../../core/widgets/custom_label.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../hospital/tabs/home/section/request_header.dart';
import '../../view_model/users_view_model.dart';
import 'admin_created_summary.dart';
import 'build_field.dart';

class AddAdminDialog extends StatefulWidget {
  const AddAdminDialog({super.key});

  @override
  State<AddAdminDialog> createState() => _AddAdminDialogState();
}

class _AddAdminDialogState extends State<AddAdminDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _locationController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _adminCodeController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  String? selectedAccessLevel;
  bool _isLoading = false;
  CreatedAdminSummary? _createdAdminSummary;

  List<String> _accessLevelItems(AppLocalizations loc) {
    return [loc.admin, loc.superAdmin];
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _locationController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _adminCodeController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _adminCodeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _requiredValidator(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.fieldIsRequired;
    }
    return null;
  }

  SnackBar _buildSnackBar({required String message, required bool isSuccess}) {
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: isSuccess ? ColorManger.successColor : ColorManger.brightRed,
          fontWeight: FontWeight.w600,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      backgroundColor: isSuccess
          ? ColorManger.successBackground
          : ColorManger.errorLightBackground,
    );
  }

  Future<void> _onSave() async {
    final loc = AppLocalizations.of(context)!;

    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (selectedAccessLevel == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          _buildSnackBar(
              message: loc.pleaseSelectAccessLevel, isSuccess: false),
        );
      return;
    }

    setState(() => _isLoading = true);
    String role = 'admin';
    if (selectedAccessLevel == loc.superAdmin) {
      role = 'superadmin';
    } else if (selectedAccessLevel == loc.admin) {
      role = 'admin';
    }

    final result = await context.read<UsersCubit>().createAdmin(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      phone: _phoneController.text.trim(),
      role: role,
    );
    log('$result');

    if (!mounted) return;

    setState(() => _isLoading = false);

    if (result.success && result.admin != null) {
      final admin = result.admin!;
      setState(() {
        _createdAdminSummary = CreatedAdminSummary(
          fullName: admin.fullName ?? '',
          adminKey: admin.adminKey ?? '',
          email: admin.email ?? '',
          phone: admin.phone ?? '',
          role: admin.role ?? selectedAccessLevel!,
        );
      });
    } else {
      log('Create admin failed: ${result.errorMessage}');
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          _buildSnackBar(
            message:  localizeError(result.errorMessage ?? loc.error_unknown, loc),
            isSuccess: false,
          ),
        );
    }
  }

  Widget _buildField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required BuildContext context,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,

    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return BuildField(
      textInputAction: textInputAction,
      label: label,
      controller: controller,
      keyboardType: keyboardType,
      hintText: hintText,
      obscureText: obscureText,
      validator: validator ?? (value) => _requiredValidator(value, context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final accessLevelItems = _accessLevelItems(loc);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManger.lightGrey),
      ),
      backgroundColor: ColorManger.pureWhite,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.86,
            ),
            child: _createdAdminSummary != null
                ? AdminCreatedSuccessView(
              summary: _createdAdminSummary!,
              onDone: () => Navigator.of(context).pop(_createdAdminSummary),
            )
                : Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomDialogHeader(
                    title: loc.addAdmin,
                    subtitle: loc.admin_authentication,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildField(
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            validator: (value) =>
                                (value ?? '').nameValidator(context),
                            label: loc.fullName,
                            hintText: loc.fullName,
                            controller: _nameController,
                            context: context,
                          ),
                          const SizedBox(height: 16),
                          _buildField(
                            obscureText: false,
                            label: loc.email,
                            hintText: loc.please_enter_email,
                            controller: _emailController,
                            context: context,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                (value ?? '').emailValidator(context),
                          ),
                          const SizedBox(height: 16),
                          _buildField(
                            label: loc.phone,
                            hintText: loc.please_enter_phone,
                            controller: _phoneController,
                            obscureText: false,
                            context: context,
                            keyboardType: TextInputType.phone,
                            validator: (value) =>
                                (value ?? '').phoneValidator(context),
                          ),
                          const SizedBox(height: 16),
                          CustomLabel(text: loc.accessLevel),
                          CustomDropDownButtonFormField(
                            items: accessLevelItems,
                            hintText: loc.selectAccessLevel,
                            initialValue: selectedAccessLevel,
                            onChanged: (value) {
                              setState(() {
                                selectedAccessLevel = value;
                              });
                            },
                          ),

                          const SizedBox(height: 16),
                          _buildField(
                            keyboardType: TextInputType.text,
                            label: loc.secure_password,
                            hintText: loc.please_enter_secure_password,
                            controller: _passwordController,
                            context: context,
                            obscureText: true,

                          ),
                          const SizedBox(height: 16),
                          _buildField(
                            textInputAction: TextInputAction.done,
                            label: loc.confirm_password,
                            hintText: loc.please_confirm_password,
                            controller: _confirmPasswordController,
                            keyboardType: TextInputType.text,
                            context: context,
                            obscureText: true,
                            validator: (value) =>
                                (value ?? '').confirmPasswordValidator(
                                  context,
                                  _passwordController.text.trim(),
                                ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          backgroundColor: ColorManger.pureWhite,
                          foregroundColor: ColorManger.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: ColorManger.slateGrey
                                  .withValues(alpha: 0.3),
                              width: 1.2,
                            ),
                          ),
                          onPressed: _isLoading
                              ? null
                              : () => Navigator.of(context).pop(),
                          child: CustomText(text: loc.cancel),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomElevatedButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: ColorManger.royalBlue
                                  .withValues(alpha: 0.45),
                              width: 1,
                            ),
                          ),
                          backgroundColor: ColorManger.royalBlue,
                          foregroundColor: ColorManger.pureWhite,
                          onPressed: _isLoading ? null : _onSave,
                          child: _isLoading
                              ? SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: ColorManger.pureWhite,
                            ),
                          )
                              : CustomText(text: loc.save),
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
    );
  }
}