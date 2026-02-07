extension EmailEx on String {
  static final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  String? get emailValidator {
    if (isEmpty) {
      return 'Email is required';
    }
    if (!emailRegex.hasMatch(this)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? get passwordValidator {
    if (isEmpty) {
      return 'Password is required';
    }
    if (!passwordRegex.hasMatch(this)) {
      return 'Enter a valid password';
    }
    return null;
  }

  static final RegExp phoneRegex = RegExp(r'^(010|011|012|015)[0-9]{8}$');

  String? get phoneValidator {
    if (isEmpty) {
      return 'Phone number is required';
    }
    if (!phoneRegex.hasMatch(this)) {
      return 'Enter a valid Egyptian phone number';
    }
    return null;
  }
  static final RegExp nameRegex = RegExp(r'^[a-zA-Z\u0621-\u064A ]+$');

  String? get nameValidator {
    if (trim().isEmpty) {
      return 'This field is required';
    }
    if (!nameRegex.hasMatch(this)) {
      return 'Enter a valid name';
    }
    return null;
  }
}
