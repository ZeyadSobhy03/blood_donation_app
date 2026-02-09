import 'package:flutter/material.dart';
import 'package:blood_donation_app/l10n/app_localizations.dart';

extension StringEx on String {
  static final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$',
  );
  static final RegExp phoneRegex = RegExp(r'^(010|011|012|015)[0-9]{8}$');
  static final RegExp nameRegex = RegExp(r'^[a-zA-Z\u0621-\u064A ]+$');
  static final RegExp locationRegex = RegExp(r'^[a-zA-Z\u0621-\u064A0-9 ,.-]+$');

  String? emailValidator(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    if (isEmpty) return appLocalization.emailIsRequired;
    if (!emailRegex.hasMatch(this)) return appLocalization.enterValidEmail;
    return null;
  }

  String? passwordValidator(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    if (isEmpty) return appLocalization.passwordIsRequired;
    if (!passwordRegex.hasMatch(this)) return appLocalization.enterValidPassword;
    return null;
  }

  String? phoneValidator(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    if (isEmpty) return appLocalization.phoneIsRequired;
    if (!phoneRegex.hasMatch(this)) return appLocalization.enterValidPhone;
    return null;
  }

  String? nameValidator(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    if (trim().isEmpty) return appLocalization.fieldIsRequired;
    if (!nameRegex.hasMatch(this)) return appLocalization.enterValidName;
    return null;
  }

  String? locationValidator(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    if (trim().isEmpty) return appLocalization.locationIsRequired;
    if (!locationRegex.hasMatch(this)) return appLocalization.enterValidLocation;
    return null;
  }
  String? confirmPasswordValidator(BuildContext context, String originalPassword) {
    final appLocalization= AppLocalizations.of(context)!;
    if (isEmpty) return appLocalization.fieldIsRequired;
    if (this != originalPassword) return appLocalization.passwordsDoNotMatch;
    return null;
  }
}
