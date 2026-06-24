import 'package:flutter/material.dart';

class HospitalFormControllers {
  final name = TextEditingController();
  final location = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final latitude = TextEditingController();
  final longitude = TextEditingController();
  final licenseNumber = TextEditingController();
  final adminContactName = TextEditingController();
  final adminContactPhone = TextEditingController();
  final emergencyContact = TextEditingController();
  final hospitalCode = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final zipCode = TextEditingController();
  final capacity = TextEditingController();

  bool get hasPickedLocation =>
      latitude.text.trim().isNotEmpty && longitude.text.trim().isNotEmpty;

  void dispose() {
    name.dispose();
    location.dispose();
    phone.dispose();
    email.dispose();
    latitude.dispose();
    longitude.dispose();
    licenseNumber.dispose();
    adminContactName.dispose();
    adminContactPhone.dispose();
    emergencyContact.dispose();
    hospitalCode.dispose();
    password.dispose();
    confirmPassword.dispose();
    city.dispose();
    state.dispose();
    zipCode.dispose();
    capacity.dispose();
  }
}