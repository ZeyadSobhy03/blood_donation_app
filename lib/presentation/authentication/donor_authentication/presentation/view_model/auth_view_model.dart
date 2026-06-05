import 'dart:developer';

import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/login_model.dart'
as login_model;
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/me_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/sign_up_model.dart'
as sign_up_model;
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/validate_token_model.dart'
    hide Data;
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/verify_email_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/domain/use_case/auth_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/error_localizer.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase authUseCase;
  final AuthLocalDataSource authHiveDataSource;

  AuthCubit({required this.authUseCase, required this.authHiveDataSource})
      : super(AuthInitialState());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoadingState());
    try {
      final loginModel = await authUseCase.login(
        email: email,
        password: password,
        role: 'donor',
      );
      if (loginModel.success == true && loginModel.data != null) {
        await authHiveDataSource.saveLoginData(loginModel: loginModel);
        emit(AuthLoginSuccessState(loginModel: loginModel));
      } else {
        emit(AuthErrorState(errorKey: 'unknown_error'));
      }
    } on NetworkTimeoutException {
      emit(AuthErrorState(errorKey: 'network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(AuthErrorState(errorKey: mapServerErrorToKey(e.message)));
    } on ServerException catch (e) {
      emit(AuthErrorState(errorKey: mapServerErrorToKey(e.serverMessage)));
    } on NotFoundException {
      emit(AuthErrorState(errorKey: 'not_found'));
    } on RequestCancelledException {
      emit(AuthErrorState(errorKey: 'request_cancelled'));
    } on UnknownNetworkException {
      emit(AuthErrorState(errorKey: 'unknown_error'));
    } catch (e) {
      emit(AuthErrorState(errorKey: 'unknown_error'));
    }
  }

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
    required String phoneNumber,
    required String dateOfBirth,
    required String bloodType,
    required String gender,
    required String city,
    required String governorate,
    required double lat,
    required double lng,
  }) async {
    emit(AuthLoadingState());
    try {
      final signUpModel = await authUseCase.signUp(
        fullName: fullName,
        email: email,
        password: password,
        role: 'donor',
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        bloodType: bloodType,
        confirmPassword: confirmPassword,
        governorate: governorate,
        city: city,
        lat: lat,
        gender: gender,
        lng: lng,
      );
      if (signUpModel.success == true && signUpModel.data != null) {
        await _saveAuthData(signUpModel);
        emit(AuthSignUpSuccessState(signUpModel: signUpModel));
      } else {
        emit(AuthErrorState(errorKey: 'unknown_error'));
      }
    } on NetworkTimeoutException {
      emit(AuthErrorState(errorKey: 'network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(AuthErrorState(errorKey: mapServerErrorToKey(e.message)));
    } on ServerException catch (e) {
      emit(AuthErrorState(errorKey: mapServerErrorToKey(e.serverMessage)));
    } on NotFoundException {
      emit(AuthErrorState(errorKey: 'not_found'));
    } on RequestCancelledException {
      emit(AuthErrorState(errorKey: 'request_cancelled'));
    } on UnknownNetworkException {
      emit(AuthErrorState(errorKey: 'unknown_error'));
    } catch (e) {
      emit(AuthErrorState(errorKey: 'unknown_error'));
    }
  }

  Future<void> verifyEmail({required String email}) async {
    emit(AuthLoadingState());
    try {
      final verifyEmailModel = await authUseCase.verifyEmail(email: email);
      if (verifyEmailModel.success == true) {
        emit(AuthVerifyEmailSuccessState(verifyEmailModel: verifyEmailModel));
      } else {
        emit(AuthErrorState(errorKey: 'server_error'));
      }
    } on NetworkTimeoutException {
      emit(AuthErrorState(errorKey: 'network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(AuthErrorState(errorKey: mapServerErrorToKey(e.message)));
    } on ServerException catch (e) {
      emit(AuthErrorState(errorKey: mapServerErrorToKey(e.serverMessage)));
    } on NotFoundException {
      emit(AuthErrorState(errorKey: 'not_found'));
    } on RequestCancelledException {
      emit(AuthErrorState(errorKey: 'request_cancelled'));
    } on UnknownNetworkException {
      emit(AuthErrorState(errorKey: 'unknown_error'));
    } catch (e) {
      emit(AuthErrorState(errorKey: 'unknown_error'));
    }
  }

  Future<bool> verifyForgetPasswordOtp({
    required String email,
    required String otp,
  }) async {
    emit(AuthLoadingState());
    try {
      final verifyOtpModel = await authUseCase.verifyForgetPasswordOtp(
        email: email,
        otp: otp,
      );
      if (verifyOtpModel.success == true) {
        emit(AuthVerifyOtpSuccessState(
          verified: verifyOtpModel.data?.verified ?? false,
          email: verifyOtpModel.data?.email,
          otp: otp,
        ));
        return true;
      } else {
        emit(AuthErrorState(errorKey: 'server_error'));
        return false;
      }
    } on NetworkTimeoutException {
      emit(AuthErrorState(errorKey: 'network_timeout'));
      return false;
    } on UnauthorizedException catch (e) {
      emit(AuthErrorState(errorKey: mapServerErrorToKey(e.message)));
      return false;
    } on ServerException catch (e) {
      emit(AuthErrorState(errorKey: mapServerErrorToKey(e.serverMessage)));
      return false;
    } on NotFoundException {
      emit(AuthErrorState(errorKey: 'not_found'));
      return false;
    } on RequestCancelledException {
      emit(AuthErrorState(errorKey: 'request_cancelled'));
      return false;
    } on UnknownNetworkException {
      emit(AuthErrorState(errorKey: 'unknown_error'));
      return false;
    } catch (e) {
      emit(AuthErrorState(errorKey: 'unknown_error'));
      return false;
    }
  }

  Future<void> forgetPassword({required String email}) async {
    emit(AuthLoadingState());
    try {
      await authUseCase.forgetPassword(email: email);
      emit(AuthForgetPasswordSuccessState());
    } on NetworkTimeoutException {
      emit(AuthErrorState(errorKey: 'network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(AuthErrorState(errorKey: mapServerErrorToKey(e.message)));
    } on ServerException catch (e) {
      emit(AuthErrorState(errorKey: mapServerErrorToKey(e.serverMessage)));
    } on NotFoundException {
      emit(AuthErrorState(errorKey: 'not_found'));
    } on RequestCancelledException {
      emit(AuthErrorState(errorKey: 'request_cancelled'));
    } on UnknownNetworkException {
      emit(AuthErrorState(errorKey: 'unknown_error'));
    } catch (e) {
      emit(AuthErrorState(errorKey: 'unknown_error'));
    }
  }

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String password,
  }) async {
    emit(AuthLoadingState());
    try {
      await authUseCase.resetPassword(
        email: email,
        otp: otp,
        password: password,
      );
      emit(AuthResetPasswordSuccessState());
    } on NetworkTimeoutException {
      emit(AuthErrorState(errorKey: 'network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(AuthErrorState(errorKey: mapServerErrorToKey(e.message)));
    } on ServerException catch (e) {
      emit(AuthErrorState(errorKey: mapServerErrorToKey(e.serverMessage)));
    } on NotFoundException {
      emit(AuthErrorState(errorKey: 'not_found'));
    } on RequestCancelledException {
      emit(AuthErrorState(errorKey: 'request_cancelled'));
    } on UnknownNetworkException {
      emit(AuthErrorState(errorKey: 'unknown_error'));
    } catch (e) {
      emit(AuthErrorState(errorKey: 'unknown_error'));
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

  Future<void> getMe() async {
    emit(AuthLoadingState());
    try {
      final meModel = await authUseCase.getMe();
      if (meModel.success == true && meModel.data != null) {
        emit(AuthGetMeSuccessState(data: meModel.data!));
      } else {
        log('Get Me failed: ${meModel.toJson()}');
        emit(AuthErrorState(errorKey: 'unknown_error'));
      }
    } on NetworkTimeoutException {
      emit(AuthErrorState(errorKey: 'network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(AuthErrorState(errorKey: mapServerErrorToKey(e.message)));
    } on ServerException catch (e) {
      emit(AuthErrorState(errorKey: mapServerErrorToKey(e.serverMessage)));
    } on NotFoundException {
      emit(AuthErrorState(errorKey: 'not_found'));
    } on RequestCancelledException {
      emit(AuthErrorState(errorKey: 'request_cancelled'));
    } on UnknownNetworkException {
      emit(AuthErrorState(errorKey: 'unknown_error'));
    } catch (e) {
      emit(AuthErrorState(errorKey: 'unknown_error'));
    }
  }

  void retrySignUp({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
    required String phoneNumber,
    required String dateOfBirth,
    required String bloodType,
    required String gender,
    required String city,
    required String governorate,
    required double lat,
    required double lng,
  }) {
    if (state is AuthErrorState) {
      signUp(
        lng: lng,
        lat: lat,
        governorate: governorate,
        city: city,
        role: role,
        gender: gender,
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

  Future<String?> validateToken() async {
    try {
      final validateTokenModel = await authUseCase.validateToken();
      log('Validate Token Model: ${validateTokenModel.toJson()}');
      if (validateTokenModel.success == true &&
          validateTokenModel.data != null &&
          validateTokenModel.data!.isValid == true) {
        emit(AuthValidateTokenSuccessState(
            validateTokenModel: validateTokenModel));
        return validateTokenModel.data!.role ??
            validateTokenModel.data!.userRole;
      }
      return null;
    } on NetworkTimeoutException {
      emit(AuthErrorState(errorKey: 'network_timeout'));
      return null;
    } on UnauthorizedException catch (e) {
      emit(AuthErrorState(errorKey: mapServerErrorToKey(e.message)));
      return null;
    } on ServerException catch (e) {
      emit(AuthErrorState(errorKey: mapServerErrorToKey(e.serverMessage)));
      return null;
    } on NotFoundException {
      emit(AuthErrorState(errorKey: 'not_found'));
      return null;
    } on RequestCancelledException {
      emit(AuthErrorState(errorKey: 'request_cancelled'));
      return null;
    } on UnknownNetworkException {
      emit(AuthErrorState(errorKey: 'unknown_error'));
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> isUserLoggedIn() async {
    try {
      return await authHiveDataSource.isUserLoggedIn();
    } catch (e) {
      return false;
    }
  }

  Future<void> logOut({
    required String refreshToken,
    required String fcmToken,
  }) async {
    try {
      emit(AuthLoadingState());
      await authUseCase.logOut(refreshToken: refreshToken, fcmToken: fcmToken);
      await authHiveDataSource.clearAllData();
      emit(AuthInitialState());
    } catch (e) {
      emit(AuthErrorState(errorKey: 'unknown_error'));
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

  Future<void> _saveAuthData(sign_up_model.SignUpModel signUpModel) async {
    try {
      final tokens = signUpModel.data?.tokens;
      final user = signUpModel.data?.user;

      if (tokens?.accessToken != null && tokens?.refreshToken != null) {
        await authHiveDataSource.saveTokens(
          accessToken: tokens!.accessToken!,
          refreshToken: tokens.refreshToken!,
        );
      }

      if (user != null) {
        await authHiveDataSource.saveUserData(userData: user.toJson());
      }

      await authHiveDataSource.savSignUpData(signUpModel: signUpModel);
    } catch (_) {}
  }

  Future<void> initializeAuth() async {
    try {
      final isLoggedIn = await authHiveDataSource.isUserLoggedIn();

      if (!isLoggedIn) {
        emit(AuthInitialState());
        return;
      }

      final userData = await authHiveDataSource.getUserData();
      if (userData != null) {
        emit(AuthInitialState());
      } else {
        emit(AuthInitialState());
      }
    } catch (e) {
      emit(AuthInitialState());
    }
  }
}

// ─── States ───────────────────────────────────────────────────────────────────

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

class AuthVerifyOtpSuccessState extends AuthState {
  final bool verified;
  final String? email;
  final String? otp;

  AuthVerifyOtpSuccessState({
    required this.verified,
    this.email,
    this.otp,
  });
}

class AuthForgetPasswordSuccessState extends AuthState {}

class AuthResetPasswordSuccessState extends AuthState {}

class AuthGetMeSuccessState extends AuthState {
  final Data data;

  AuthGetMeSuccessState({required this.data});

  String? get fullName => data.fullName;
  String? get email => data.email;
  String? get bloodType => data.bloodType;
  String? get phoneNumber => data.phoneNumber;
  String? get gender => data.gender;
  String? get dateOfBirth => data.dateOfBirth;
  bool? get isEmailVerified => data.isEmailVerified;
  bool? get isAvailable => data.isAvailable;
  String? get role => data.role;
  Location? get location => data.location;
  HealthHistory? get healthHistory => data.healthHistory;
  Settings? get settings => data.settings;
}

class AuthValidateTokenSuccessState extends AuthState {
  final ValidateTokenModel validateTokenModel;

  AuthValidateTokenSuccessState({required this.validateTokenModel});

  bool get isValid => validateTokenModel.data?.isValid ?? false;
  String? get userRole => validateTokenModel.data?.userRole;
  String? get userId => validateTokenModel.data?.userId;
  String? get role => validateTokenModel.data?.role;
  bool get isTokenValid => validateTokenModel.success == true && isValid;
}

class AuthErrorState extends AuthState {
  final String errorKey;

  AuthErrorState({required this.errorKey});

  bool get isNetworkError => errorKey == 'network_timeout';
  bool get isUnauthorized => errorKey == 'unauthorized';
  bool get isServerError => errorKey == 'server_error';
}