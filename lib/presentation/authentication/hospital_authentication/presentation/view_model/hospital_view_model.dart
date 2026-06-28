import 'dart:developer';

import 'package:blood_donation_app/l10n/app_localizations.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/data_source/local_data_source/hospital_local_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/data/model/hospital_login_model.dart';
import 'package:blood_donation_app/presentation/authentication/hospital_authentication/domain/use_case/hospital_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalCubit extends Cubit<HospitalState> {
  final HospitalUseCase hospitalUseCase;
  final HospitalLocalDataSource hospitalHiveDataSource;
  AppLocalizations? _loc;

  HospitalCubit({
    required this.hospitalUseCase,
    required this.hospitalHiveDataSource,
  }) : super(HospitalInitialState());


  Future<void> login({
    required String hospitalId,
    required String email,
    required String password,
    required AppLocalizations loc,
  }) async {
    _loc = loc;
    try {
      emit(HospitalLoadingState());

      final loginModel = await hospitalUseCase.login(
        hospitalId: hospitalId,
        email: email,
        password: password,
      );

      log('Hospital login response: success=${loginModel.success}, '
          'user=${loginModel.data?.userName}');

      if (loginModel.success == true && loginModel.data != null) {
        log('Saving hospital login data for: ${loginModel.data?.userName}');
        await hospitalHiveDataSource.saveLoginData(loginModel: loginModel);
        log('Hospital login data saved successfully.');
        emit(HospitalLoginSuccessState(loginModel: loginModel));
      } else {
        emit(HospitalErrorState(message: _loc?.somethingWentWrong ?? 'Something went wrong. Please try again.'));
      }
    } catch (e) {
      emit(HospitalErrorState(message: _parseError(e.toString())));
    }
  }


  Future<void> forgotPassword({
    required String email,
    required AppLocalizations loc,
  }) async {
    _loc = loc;
    try {
      emit(HospitalLoadingState());
      await hospitalUseCase.forgotPassword(email: email);
      emit(HospitalForgotPasswordSuccessState());
    } catch (e) {
      emit(HospitalErrorState(message: _parseError(e.toString())));
    }
  }


  Future<bool> isUserLoggedIn() async {
    try {
      return await hospitalHiveDataSource.isUserLoggedIn();
    } catch (_) {
      return false;
    }
  }

  Future<HospitalUser?> getSavedUserData() async {
    try {
      return await hospitalHiveDataSource.getUserData();
    } catch (_) {
      return null;
    }
  }

  Future<String?> getSavedAccessToken() async {
    try {
      return await hospitalHiveDataSource.getAccessToken();
    } catch (_) {
      return null;
    }
  }

  Future<void> logout({String? fcmToken}) async {
    try {
      final refreshToken = await hospitalHiveDataSource.getRefreshToken();
      if (refreshToken != null && fcmToken != null) {
        await hospitalUseCase.logOut(
          refreshToken: refreshToken,
          fcmToken: fcmToken,
        );
      }
    } catch (_) {
    } finally {
      await hospitalHiveDataSource.clearAllData();
      emit(HospitalInitialState());
    }
  }

  void reset() => emit(HospitalInitialState());

  String _parseError(String error) {
    final e = error.toLowerCase();

    if (e.contains('timeout') || e.contains('connection_timeout')) {
      return _loc?.connectionTimeout ?? 'Connection timed out. Please try again.';
    } else if (e.contains('no_internet') || e.contains('connectionerror')) {
      return _loc?.noInternet ?? 'No internet connection.';
    } else if (e.contains('hospital_not_approved')) {
      return 'Your hospital account is not yet approved. Please contact support@lifelink.org.';
    } else if (e.contains('bad_response') || e.contains('server_error') || e.contains('empty_response')) {
      return _loc?.somethingWentWrong ?? 'Something went wrong. Please try again.';
    } else if (e.contains('unauthorized')) {
      return _loc?.error_token_expired ?? 'Session expired. Please log in again.';
    }

    if (e.contains('invalid hospital id')) {
      return 'Invalid hospital ID.';
    }
    if (e.contains('invalid email or password') || e.contains('invalid credentials')) {
      return _loc?.error_invalid_credentials ?? 'Invalid email or password.';
    }

    return _loc?.somethingWentWrong ?? 'Something went wrong. Please try again.';
  }
}

sealed class HospitalState {}

class HospitalInitialState extends HospitalState {}

class HospitalLoadingState extends HospitalState {}

class HospitalLoginSuccessState extends HospitalState {
  final HospitalLoginModel loginModel;

  HospitalLoginSuccessState({required this.loginModel});

  String? get accessToken => loginModel.data?.accessToken;
  String? get refreshToken => loginModel.data?.refreshToken;
  HospitalUser? get user => loginModel.data?.user;
  String? get hospitalName => loginModel.data?.userName;
  bool get isLoginSuccess => loginModel.success == true;
}

class HospitalForgotPasswordSuccessState extends HospitalState {}

class HospitalErrorState extends HospitalState {
  final String message;

  HospitalErrorState({required this.message});
}