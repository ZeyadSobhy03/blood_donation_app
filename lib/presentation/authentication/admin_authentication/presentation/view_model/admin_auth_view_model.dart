import 'dart:developer';

import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/data_source/local/admin_hive_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/admin_authentication/data/model/admin_login_model.dart' as admin_login_model;
import 'package:blood_donation_app/presentation/authentication/admin_authentication/domain/use_case/admin_auth_use_case.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/me_model.dart' hide Data;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/error_localizer.dart';
import '../../../donor_authentication/data/model/validate_token_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/me_model.dart' as me_model;

class AdminAuthCubit extends Cubit<AdminAuthState> {
  final AdminAuthUseCase adminAuthUseCase;
  final AdminHiveDataSource adminHiveDataSource;

  AdminAuthCubit({
    required this.adminAuthUseCase,
    required this.adminHiveDataSource,
  }) : super(AdminAuthInitialState());

  Future<void> adminLogin({
    required String accessKey,
    required String email,
    required String password,
  }) async {
    emit(AdminAuthLoadingState());
    try {
      final loginModel = await adminAuthUseCase.adminLogin(
        accessKey: accessKey,
        email: email,
        password: password,
      );
      if (loginModel.success == true && loginModel.data != null) {
        await adminHiveDataSource.saveLoginData(loginModel: loginModel);
        emit(AdminAuthLoginSuccessState(loginModel: loginModel));
      } else {
        emit(AdminAuthErrorState(errorKey: 'unknown_error'));
      }
    } on NetworkTimeoutException {
      emit(AdminAuthErrorState(errorKey: 'network_timeout'));
    } on UnauthorizedException catch (e) {
      log('Admin login unauthorized error: ${e.message}');
      emit(AdminAuthErrorState(errorKey: mapServerErrorToKey(e.message)));
    } on ServerException catch (e) {
      log('Admin login server error: ${e.serverMessage}');
      emit(AdminAuthErrorState(errorKey: mapServerErrorToKey(e.serverMessage)));
    } on NotFoundException {

      log('Admin login not found error');
      emit(AdminAuthErrorState(errorKey: 'not_found'));
    } on RequestCancelledException {
      log('Admin login request cancelled');
      emit(AdminAuthErrorState(errorKey: 'request_cancelled'));
    } on UnknownNetworkException {
      log('Admin login unknown network error');
      emit(AdminAuthErrorState(errorKey: 'unknown_error'));
    } catch (e) {

      log('Admin login error: $e');
      emit(AdminAuthErrorState(errorKey: 'unknown_error'));
    }
  }

  Future<void> initializeAdminAuth() async {
    try {
      final isLoggedIn = await adminHiveDataSource.isAdminLoggedIn();

      if (!isLoggedIn) {
        emit(AdminAuthInitialState());
        return;
      }

      // Admin is already logged in, get fresh data from API
      await getMe();
    } catch (e) {
      log('Admin auth initialization error: $e');
      emit(AdminAuthInitialState());
    }
  }

  Future<void> getMe() async {
    emit(AdminAuthLoadingState());
    try {
      final meModel = await adminAuthUseCase.getMe();
      if (meModel.success == true && meModel.data != null) {
        emit(AuthGetMeSuccessState(data: meModel.data!));
      } else {
        log('Get Me failed: ${meModel.toJson()}');
        emit(AdminAuthErrorState(errorKey: 'unknown_error'));
      }
    } on NetworkTimeoutException {
      emit(AdminAuthErrorState(errorKey: 'network_timeout'));
    } on UnauthorizedException catch (e) {
      emit(AdminAuthErrorState(errorKey: mapServerErrorToKey(e.message)));
    } on ServerException catch (e) {
      emit(AdminAuthErrorState(errorKey: mapServerErrorToKey(e.serverMessage)));
    } on NotFoundException {
      emit(AdminAuthErrorState(errorKey: 'not_found'));
    } on RequestCancelledException {
      emit(AdminAuthErrorState(errorKey: 'request_cancelled'));
    } on UnknownNetworkException {
      emit(AdminAuthErrorState(errorKey: 'unknown_error'));
    } catch (e) {
      emit(AdminAuthErrorState(errorKey: 'unknown_error'));
    }
  }
  Future<String?> validateToken() async {
    try {
      final validateTokenModel = await adminAuthUseCase.validateToken();
      log('Validate Token Model: ${validateTokenModel.toJson()}');
      if (validateTokenModel.success == true &&
          validateTokenModel.data != null &&
          validateTokenModel.data!.isValid == true) {
        emit(AdminAuthValidateTokenSuccessState(
            validateTokenModel: validateTokenModel));
        return validateTokenModel.data!.role ??
            validateTokenModel.data!.userRole;
      }
      return null;
    } on NetworkTimeoutException {
      emit(AdminAuthErrorState(errorKey: 'network_timeout'));
      return null;
    } on UnauthorizedException catch (e) {
      emit(AdminAuthErrorState(errorKey: mapServerErrorToKey(e.message)));
      return null;
    } on ServerException catch (e) {
      emit(AdminAuthErrorState(errorKey: mapServerErrorToKey(e.serverMessage)));
      return null;
    } on NotFoundException {
      emit(AdminAuthErrorState(errorKey: 'not_found'));
      return null;
    } on RequestCancelledException {
      emit(AdminAuthErrorState(errorKey: 'request_cancelled'));
      return null;
    } on UnknownNetworkException {
      emit(AdminAuthErrorState(errorKey: 'unknown_error'));
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> isAdminLoggedIn() async {
    try {
      return await adminHiveDataSource.isAdminLoggedIn();
    } catch (e) {
      return false;
    }
  }
}



sealed class AdminAuthState {}

class AdminAuthInitialState extends AdminAuthState {}

class AdminAuthLoadingState extends AdminAuthState {}

class AdminAuthLoginSuccessState extends AdminAuthState {
  final admin_login_model.AdminLoginModel loginModel;

  AdminAuthLoginSuccessState({required this.loginModel});

  String? get accessToken => loginModel.data?.accessToken;
  String? get refreshToken => loginModel.data?.refreshToken;
  admin_login_model.User? get user => loginModel.data?.user;
  bool get isLoginSuccess => loginModel.success == true;
}

class AdminAuthValidateTokenSuccessState extends AdminAuthState {
  final ValidateTokenModel validateTokenModel;

  AdminAuthValidateTokenSuccessState({required this.validateTokenModel});

  bool get isValid => validateTokenModel.data?.isValid ?? false;
  String? get userRole => validateTokenModel.data?.userRole;
  String? get userId => validateTokenModel.data?.userId;
  String? get role => validateTokenModel.data?.role;
  bool get isTokenValid => validateTokenModel.success == true && isValid;
}
class AuthGetMeSuccessState extends AdminAuthState {
final me_model.Data data;
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
class AdminAuthenticatedState extends AdminAuthState {
  final admin_login_model.AdminLoginModel loginModel;

  AdminAuthenticatedState({required this.loginModel});

  String? get accessToken => loginModel.data?.accessToken;
  String? get refreshToken => loginModel.data?.refreshToken;
  admin_login_model.User? get user => loginModel.data?.user;
}

class AdminAuthErrorState extends AdminAuthState {
  final String errorKey;

  AdminAuthErrorState({required this.errorKey});

  bool get isNetworkError => errorKey == 'network_timeout';
  bool get isUnauthorized => errorKey == 'unauthorized';
  bool get isServerError => errorKey == 'server_error';
}
