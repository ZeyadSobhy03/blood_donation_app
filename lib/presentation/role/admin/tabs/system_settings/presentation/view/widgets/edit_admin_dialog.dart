import 'package:blood_donation_app/core/utils/error_localizer.dart';
import 'package:blood_donation_app/core/widgets/custom_elevated_button.dart';
import 'package:blood_donation_app/core/widgets/custom_text.dart';
import 'package:blood_donation_app/presentation/role/hospital/tabs/home/section/request_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/extension/text_ex.dart';
import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/widgets/custom_label.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../donor/tabs/donate/presentation/view/schedule_donation/presentation/view/widgets/custom_text_form_field.dart';
import '../../view_model/profile/admin_profile_view_model.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/presentation/view_model/admin_auth_view_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/presentation/view_model/auth_view_model.dart';
import 'package:blood_donation_app/core/service/firebase_notification_service.dart';

class EditAdminDialog extends StatefulWidget {
  const EditAdminDialog({super.key});

  @override
  State<EditAdminDialog> createState() => _EditAdminDialogState();
}

class _EditAdminDialogState extends State<EditAdminDialog> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  String? initialEmail;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final admin = context.read<AdminProfileCubit>().currentProfile?.data?.admin;
    nameController = TextEditingController(text: admin?.fullName ?? '');
    emailController = TextEditingController(text: admin?.email ?? '');
    phoneController = TextEditingController(text: admin?.phone?.toString() ?? '');
    initialEmail = admin?.email;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocListener<AdminProfileCubit, ProfileState>(
      listener: (context, state) async {
        if (state is ProfileUpdateSuccessState) {
          // Show success snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomText(
                text: loc.profileUpdatedSuccessfully,
                textStyle: TextStyle(color: ColorManger.pureWhite),
              ),
              backgroundColor: ColorManger.green,
              duration: const Duration(seconds: 2),
            ),
          );

          // Refetch the profile to ensure UI reflects updated data
          context.read<AdminProfileCubit>().fetchAdminProfile();

          final bool isEmailChanged = emailController.text.trim() != initialEmail;

          if (isEmailChanged) {
            final authCubit = context.read<AuthCubit>();
            final adminCubit = context.read<AdminAuthCubit>();
            final refreshToken = await adminCubit.adminHiveDataSource.getRefreshToken();
            final fcmToken = await FirebaseNotificationService.getFCMToken();

            if (context.mounted) {
              authCubit.logOut(refreshToken: refreshToken ?? '', fcmToken: fcmToken ?? '');
              await adminCubit.adminHiveDataSource.clearAllData();
            }
          } else {
            // Close dialog after a short delay
            Future.delayed(const Duration(milliseconds: 500), () {
              if (context.mounted) Navigator.of(context).pop();
            });
          }
        } else if (state is ProfileErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: CustomText(
                text: localizeError(state.errorKey, loc),
                textStyle: TextStyle(color: ColorManger.pureWhite),
              ),
              backgroundColor: ColorManger.brightRed,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Dialog(
        backgroundColor: ColorManger.pureWhite,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDialogHeader(
                      title: loc.editAdminProfile,
                      subtitle: loc.updateAdminProfileInfo,
                    ),
                    const SizedBox(height: 16),
                    _buildField(
                      keyboardType: TextInputType.text,
                      label: loc.full_name,
                      hintText: loc.enterFullName,
                      controller: nameController,
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: ColorManger.slateGrey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => (value ?? '').emailValidator(context),
                      label: loc.emailAddressLabel,
                      hintText: loc.enterEmailAddress,
                      controller: emailController,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: ColorManger.slateGrey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildField(
                      keyboardType: TextInputType.phone,
                      validator: (value) => (value ?? '').phoneValidator(context),
                      label: loc.phoneNumberLabel,
                      hintText: loc.enterPhoneNumber,
                      controller: phoneController,
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                        color: ColorManger.slateGrey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<AdminProfileCubit, ProfileState>(
                      buildWhen: (previous, current) =>
                      current is ProfileUpdateLoadingState ||
                          current is ProfileUpdateSuccessState ||
                          current is ProfileErrorState,
                      builder: (context, state) {
                        final isLoading = state is ProfileUpdateLoadingState;
                        return Row(
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                onPressed: isLoading ? null : () => _handleSave(context),
                                child: isLoading
                                    ? SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: ColorManger.pureWhite,
                                  ),
                                )
                                    : CustomText(text: loc.saveChanges),
                              ),
                            ),
                            const SizedBox(width: 4),
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                                child: CustomText(text: loc.cancel),
                              ),
                            ),
                          ],
                        );
                      },
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

  void _handleSave(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    context.read<AdminProfileCubit>().updateAdminProfile(
      fullName: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
    );
  }

  Widget _buildField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    Widget? prefixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(text: label),
        const SizedBox(height: 8),
        CustomTextFormField(
          prefixIcon: prefixIcon,
          textEditingController: controller,
          keyboardType: keyboardType,
          hintText: hintText,
          validator: validator ?? (value) => _requiredValidator(value),
        ),
      ],
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.fieldIsRequired;
    }
    return null;
  }
}