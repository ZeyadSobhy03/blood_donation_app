import 'package:blood_donation_app/core/resources/routes/route_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/resources/colors/color_manger.dart';
import '../../../../../../../../core/resources/fonts/font_manger.dart';
import '../../../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../../../core/widgets/custom_text.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../authentication/donor_authentication/presentation/error_mapper.dart';
import '../../../../donate/presentation/view/schedule_donation/widgets/custom_text_form_field.dart';
import '../../view_model/change_password/change_password_view_model.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({
    super.key,
    required this.currentController,
    required this.newController,
    required this.confirmController,
  });

  final TextEditingController currentController;
  final TextEditingController newController;
  final TextEditingController confirmController;

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  String _currentPasswordError = '';
  String _newPasswordError = '';
  String _confirmPasswordError = '';
  String _serverError = '';
  bool _isPasswordLoading = false;

  @override
  void initState() {
    super.initState();
    widget.currentController.addListener(() {
      if (_serverError.isNotEmpty) {
        setState(() {
          _serverError = '';
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _validateInputs(AppLocalizations appLocalization) {
    bool isValid = true;
    _currentPasswordError = '';
    _newPasswordError = '';
    _confirmPasswordError = '';

    if (widget.currentController.text.isEmpty) {
      _currentPasswordError = appLocalization.currentPasswordRequired;
      isValid = false;
    }

    if (widget.newController.text.isEmpty) {
      _newPasswordError = appLocalization.newPasswordRequired;
      isValid = false;
    } else if (widget.newController.text.length < 6) {
      _newPasswordError = appLocalization.passwordAtLeast6Characters;
      isValid = false;
    }

    if (widget.confirmController.text.isEmpty) {
      _confirmPasswordError = appLocalization.pleaseConfirmPassword;
      isValid = false;
    } else if (widget.newController.text != widget.confirmController.text) {
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

    context.read<ChangePasswordCubit>().changePassword(
      currentPassword: widget.currentController.text.trim(),
      newPassword: widget.newController.text.trim(),
      confirmNewPassword: widget.confirmController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;

    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessAndLoggedOutState) {
          widget.currentController.clear();
          widget.newController.clear();
          widget.confirmController.clear();

          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteManger.chooseRole,
                (route) => false,
          );

          Future.delayed(const Duration(milliseconds: 300), () {
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
          });
        } else if (state is ChangePasswordErrorState) {
          setState(() {
            _serverError = ErrorMapper.map(state.errorMessage, appLocalization);
          });
        }
      },
      child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
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
                        CustomText(
                          text: appLocalization.changePasswordDescription,
                          textStyle: TextStyle(
                            color: ColorManger.slateGrey.withValues(alpha: 0.6),
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.regular,
                          ),
                        ),
                        SizedBox(height: 20.h),
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
                        if (_serverError.isNotEmpty)
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
                                  backgroundColor: ColorManger.brightRed,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  foregroundColor: ColorManger.pureWhite,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 8,
                                  ),
                                  onPressed: () =>
                                      _handleChangePassword(appLocalization),
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
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 400.w,
                              minWidth: 300.w,
                            ),
                            child: CustomElevatedButton(
                              backgroundColor: _isPasswordLoading
                                  ? Colors.grey
                                  : ColorManger.brightRed,
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
                                  : () =>
                                        _handleChangePassword(appLocalization),
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
                                            fontWeight:
                                                FontWeightManager.semiBold,
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
