import 'dart:developer';

import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/login_model.dart' as login_model;
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/sign_up_model.dart' as sign_up_model;
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/verify_email_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/domain/use_case/auth_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/error_keys.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase authUseCase;
  final AuthLocalDataSource authHiveDataSource;

  AuthCubit({required this.authUseCase, required this.authHiveDataSource})
    : super(AuthInitialState());
  
  
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoadingState());



      final loginModel = await authUseCase.login(
        email: email,
        password: password,
        role: 'donor',
      );

      log('${loginModel.data?.userName} logged in successfully with access token: ${loginModel.data?.accessToken}');

      if (loginModel.success == true && loginModel.data != null) {
        log('Saving login data to local storage for user: ${loginModel.data?.userName}');
        await authHiveDataSource.saveLoginData(loginModel: loginModel);
        log('Login data saved successfully for user: ${loginModel.data?.userName}');
        emit(AuthLoginSuccessState(loginModel: loginModel));
      } else {
        emit(AuthErrorState(errorKey: ErrorKeys.unknown));
      }
    } catch (e) {
      emit(AuthErrorState(errorKey: _parseError(e.toString())));
    }
  }

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required String dateOfBirth,
    required String bloodType,
  }) async {
    try {
      emit(AuthLoadingState());

      final signUpModel = await authUseCase.signUp(
        fullName: fullName,
        email: email,
        password: password,
        role: 'donor',
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        bloodType: bloodType,
        confirmPassword: confirmPassword,
      );

      if (signUpModel.success == true && signUpModel.data != null) {
        await _saveAuthData(signUpModel);
        emit(AuthSignUpSuccessState(signUpModel: signUpModel));
      } else {
        emit(AuthErrorState(errorKey: ErrorKeys.unknown));
      }
    } catch (e) {
      emit(AuthErrorState(errorKey: _parseError(e.toString())));
    }
  }

  Future<void> verifyEmail({required String email}) async {
    try {
      emit(AuthLoadingState());

      final verifyEmailModel = await authUseCase.verifyEmail(email: email);
      if (verifyEmailModel.success == true) {
        emit(AuthVerifyEmailSuccessState(verifyEmailModel: verifyEmailModel));
      } else {
        emit(AuthErrorState(errorKey: ErrorKeys.serverError));
      }
    } catch (e) {
      emit(AuthErrorState(errorKey: _parseError(e.toString())));
    }
  }

  Future<bool> resendVerificationEmail({required String email}) async {
    try {
      final verifyEmailModel = await authUseCase.verifyEmail(email: email);
      return verifyEmailModel.success == true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> verifyEmailOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final verifyOtpModel = await authUseCase.verifyEmailOtp(
        email: email,
        otp: otp,
      );
      return verifyOtpModel.success == true;
    } catch (_) {
      return false;
    }
  }

  void retrySignUp({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required String dateOfBirth,
    required String bloodType,
  }) {
    if (state is AuthErrorState) {
      signUp(
        fullName: fullName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        bloodType: bloodType,
      );
    }
  }

  void reset() {
    emit(AuthInitialState());
  }

  Future<bool> isUserLoggedIn() async {
    try {
      return await authHiveDataSource.isUserLoggedIn();
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await authHiveDataSource.clearAllData();
      emit(AuthInitialState());
    } catch (e) {
      emit(AuthInitialState());
    }
  }

  Future<sign_up_model.User?> getSavedUserData() async {
    try {
      return await authHiveDataSource.getUserData();
    } catch (e) {
      return null;
    }
  }

  Future<String?> getSavedAccessToken() async {
    try {
      return await authHiveDataSource.getAccessToken();
    } catch (e) {
      return null;
    }
  }

  String _parseError(String error) {
    final e = error.toLowerCase();

    if (e.contains('timeout') || e.contains('connection_timeout')) {
      return ErrorKeys.connectionTimeout;
    } else if (e.contains('no_internet') || e.contains('connection')) {
      return ErrorKeys.noInternet;
    } else if (e.contains('email')) {
      return ErrorKeys.emailError;
    } else if (e.contains('password')) {
      return ErrorKeys.passwordError;
    } else if (e.contains('bad_response') || e.contains('server_error')) {
      return ErrorKeys.serverError;
    } else if (e.contains('404') || e.contains('500')) {
      return ErrorKeys.serverError;
    }

    return ErrorKeys.unknown;
  }

  Future<void> _saveAuthData(sign_up_model.SignUpModel signUpModel) async {
    try {
      final tokens = signUpModel.data?.tokens;
      final user = signUpModel.data?.user;

      // Save tokens
      if (tokens?.accessToken != null && tokens?.refreshToken != null) {
        await authHiveDataSource.saveTokens(
          accessToken: tokens!.accessToken!,
          refreshToken: tokens.refreshToken!,
        );
      }

      if (user != null) {
        await authHiveDataSource.saveUserData(userData: user.toJson());
      }

      // No verification token is provided by SignUpModel.
      await authHiveDataSource.savSignUpData(signUpModel: signUpModel);
    } catch (e) {
      // Handle any errors during saving, but don't emit an error state since sign-up was successful
    }
  }
  
  
}

// ============= State Classes =============

sealed class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoginSuccessState extends AuthState {
  final login_model.LoginModel loginModel;

  AuthLoginSuccessState({required this.loginModel});

  String? get accessToken => loginModel.data?.accessToken;

  String? get refreshToken => loginModel.data?.refreshToken;

  login_model.User? get user => loginModel.data?.user;

  bool get isLoginSuccess => loginModel.success == true;
}

class AuthSignUpSuccessState extends AuthState {
  final sign_up_model.SignUpModel signUpModel;

  AuthSignUpSuccessState({required this.signUpModel});

  String? get accessToken => signUpModel.data?.tokens?.accessToken;

  String? get refreshToken => signUpModel.data?.tokens?.refreshToken;

  sign_up_model.User? get user => signUpModel.data?.user;


  bool get needsEmailVerification =>
      signUpModel.data?.user?.isEmailVerified != true;

  bool get isRegistrationSuccess => signUpModel.success == true;
}

class AuthVerifyEmailSuccessState extends AuthState {
  final VerifyEmailModel verifyEmailModel;

  AuthVerifyEmailSuccessState({required this.verifyEmailModel});

  String? get message => verifyEmailModel.data;

  bool get isSuccess => verifyEmailModel.success == true;
}

class AuthErrorState extends AuthState {
  final String errorKey;

  AuthErrorState({required this.errorKey});

  bool get isNetworkError =>
      errorKey.toLowerCase().contains('network') ||
      errorKey.toLowerCase().contains('timeout') ||
      errorKey.toLowerCase().contains('connection');

  bool get isEmailError =>
      errorKey.toLowerCase().contains('email') ||
      errorKey.toLowerCase().contains('already');

  bool get isPasswordError => errorKey.toLowerCase().contains('password');

  bool get isValidationError =>
      errorKey.toLowerCase().contains('fill') ||
      errorKey.toLowerCase().contains('invalid');

  bool get isServerError =>
      errorKey.contains('500') ||
      errorKey.contains('404') ||
      errorKey.toLowerCase().contains('server');
}
