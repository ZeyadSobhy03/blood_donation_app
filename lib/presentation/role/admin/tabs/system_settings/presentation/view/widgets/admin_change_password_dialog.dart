
import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:blood_donation_app/presentation/role/admin/tabs/system_settings/presentation/view_model/admin_change_password/admin_change_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../authentication/donor_authentication/presentation/error_mapper.dart';
import '../../../../../../donor/tabs/donate/presentation/view/schedule_donation/presentation/view/widgets/custom_text_form_field.dart';

class AdminChangePasswordDialog extends StatefulWidget {
  const AdminChangePasswordDialog({
    super.key,
    required this.currentController,
    required this.newController,
    required this.confirmController,
    this.backgroundColor = ColorManger.brightRed,
  });

  final TextEditingController currentController;
  final TextEditingController newController;
  final TextEditingController confirmController;
  final Color backgroundColor;

  @override
  State<AdminChangePasswordDialog> createState() => _AdminChangePasswordDialogState();
}

class _AdminChangePasswordDialogState extends State<AdminChangePasswordDialog> {
  String _currentPasswordError = '';
  String _newPasswordError = '';
  String _confirmPasswordError = '';
  String _serverError = '';
  bool _isPasswordLoading = false;

  @override
  void initState() {
    super.initState();
    // Clear server error when user starts typing
    widget.currentController.addListener(_clearServerError);
    widget.newController.addListener(_clearServerError);
    widget.confirmController.addListener(_clearServerError);
  }

  @override
  void dispose() {
    widget.currentController.removeListener(_clearServerError);
    widget.newController.removeListener(_clearServerError);
    widget.confirmController.removeListener(_clearServerError);
    super.dispose();
  }

  void _clearServerError() {
    if (_serverError.isNotEmpty) {
      setState(() {
        _serverError = '';
      });
    }
  }

  bool _validateInputs(AppLocalizations appLocalization) {
    bool isValid = true;
    _currentPasswordError = '';
    _newPasswordError = '';
    _confirmPasswordError = '';

    // Validate current password
    if (widget.currentController.text.isEmpty) {
      _currentPasswordError = appLocalization.currentPasswordRequired;
      isValid = false;
    }

    // Validate new password
    if (widget.newController.text.isEmpty) {
      _newPasswordError = appLocalization.newPasswordRequired;
      isValid = false;
    } else if (widget.newController.text.length < 6) {
      _newPasswordError = appLocalization.passwordAtLeast6Characters;
      isValid = false;
    }

    // Validate confirm password
    if (widget.confirmController.text.isEmpty) {
      _confirmPasswordError = appLocalization.please_confirm_password;
      isValid = false;
    } else if (widget.confirmController.text != widget.newController.text) {
      _confirmPasswordError = appLocalization.passwordsDoNotMatch;
      isValid = false;
    }

    return isValid;
  }

  void _handleChangePassword(AppLocalizations appLocalization) {
    if (!_validateInputs(appLocalization)) {
      setState(() {});
      return;
    }

    context.read<AdminChangePasswordCubit>().changePassword(
      currentPassword: widget.currentController.text.trim(),
      newPassword: widget.newController.text.trim(),
    );
  }

  void _clearControllers() {
    widget.currentController.clear();
    widget.newController.clear();
    widget.confirmController.clear();
    setState(() {
      _serverError = '';
      _currentPasswordError = '';
      _newPasswordError = '';
      _confirmPasswordError = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return BlocListener<AdminChangePasswordCubit, AdminChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessAndLoggedOutState) {
          _clearControllers();

          // Navigate to role selection screen
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteManger.chooseRole,
                (route) => false,
          );

          // Show success message
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: CustomText(
                    text: appLocalization.passwordChangedSuccessfully,
                    textStyle: TextStyle(color: ColorManger.pureWhite),
                  ),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          });
        } else if (state is ChangePasswordErrorState) {
          setState(() {
            _serverError = ErrorMapper.map(state.errorMessage, appLocalization);
          });
        }
      },
      child: BlocBuilder<AdminChangePasswordCubit, AdminChangePasswordState>(
        builder: (context, state) {
          _isPasswordLoading = state is ChangePasswordLoadingState;

          return LayoutBuilder(
            builder: (context, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400.w, minWidth: 300.w),
                child: Dialog(
                  backgroundColor: ColorManger.pureWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header with title and close button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: appLocalization.changePassword,
                              textStyle: TextStyle(
                                color: ColorManger.black,
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: _isPasswordLoading
                                  ? null
                                  : () => Navigator.pop(context),
                              icon: Icon(Icons.close, color: ColorManger.black),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),

                        // Description
                        CustomText(
                          text: appLocalization.changePasswordDescription,
                          textStyle: TextStyle(
                            color: ColorManger.slateGrey.withValues(alpha: 0.6),
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.regular,
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // Server error message
                        if (_serverError.isNotEmpty)
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.1),
                              border: Border.all(color: Colors.red, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: CustomText(
                                    text: _serverError,
                                    textStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: FontSize.s13,
                                      fontWeight: FontWeightManager.semiBold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (_serverError.isNotEmpty) SizedBox(height: 16.h),

                        // Current password field
                        CustomTextFormField(
                          textEditingController: widget.currentController,
                          hintText: appLocalization.currentPassword,
                          obscureText: true,
                        ),
                        if (_currentPasswordError.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: CustomText(
                              text: _currentPasswordError,
                              textStyle: TextStyle(
                                color: Colors.red,
                                fontSize: FontSize.s12,
                              ),
                            ),
                          ),
                        SizedBox(height: 12.h),

                        // New password field
                        CustomTextFormField(
                          hintText: appLocalization.newPassword,
                          textEditingController: widget.newController,
                          obscureText: true,
                        ),
                        if (_newPasswordError.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: CustomText(
                              text: _newPasswordError,
                              textStyle: TextStyle(
                                color: Colors.red,
                                fontSize: FontSize.s12,
                              ),
                            ),
                          ),
                        SizedBox(height: 12.h),

                        // Confirm password field
                        CustomTextFormField(
                          textEditingController: widget.confirmController,
                          hintText: appLocalization.confirmPassword,
                          obscureText: true,
                        ),
                        if (_confirmPasswordError.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: CustomText(
                              text: _confirmPasswordError,
                              textStyle: TextStyle(
                                color: Colors.red,
                                fontSize: FontSize.s12,
                              ),
                            ),
                          ),
                        SizedBox(height: 24.h),

                        // Action buttons
                        if (_serverError.isNotEmpty)
                        // Show Dismiss and Try Again buttons when there's a server error
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _serverError = '';
                                    });
                                  },
                                  child: CustomText(
                                    text: appLocalization.dismissButton,
                                    textStyle: TextStyle(
                                      color: ColorManger.brightRed,
                                      fontSize: FontSize.s14,
                                      fontWeight: FontWeightManager.semiBold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: CustomElevatedButton(
                                  backgroundColor: widget.backgroundColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  foregroundColor: ColorManger.pureWhite,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 8,
                                  ),
                                  onPressed: _isPasswordLoading
                                      ? null
                                      : () => _handleChangePassword(appLocalization),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomText(
                                      text: appLocalization.tryAgain,
                                      textStyle: TextStyle(
                                        fontWeight: FontWeightManager.semiBold,
                                        fontSize: FontSize.s14,
                                        color: ColorManger.pureWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        else
                        // Show main Change Password button
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 400.w,
                              minWidth: 300.w,
                            ),
                            child: CustomElevatedButton(
                              backgroundColor: _isPasswordLoading
                                  ? Colors.grey
                                  : widget.backgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              foregroundColor: ColorManger.pureWhite,
                              padding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 8,
                              ),
                              onPressed: _isPasswordLoading
                                  ? null
                                  : () => _handleChangePassword(appLocalization),
                              child: Center(
                                child: _isPasswordLoading
                                    ? SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(
                                      ColorManger.pureWhite,
                                    ),
                                  ),
                                )
                                    : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    text: appLocalization.changePassword,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeightManager.semiBold,
                                      fontSize: FontSize.s15,
                                      color: ColorManger.pureWhite,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}