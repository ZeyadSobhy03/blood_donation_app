import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/core/utils/dio_error_handler.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/local_data_source/auth_hive_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/forget_password_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/log_out_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/login_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/me_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/reset_password_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/sign_up_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/validate_token_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/verify_email_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/verify_otp_model.dart';
import 'package:dio/dio.dart';

class AuthApiDataSource implements AuthRemoteDataSource {
  final Dio dio;
  final AuthHiveDataSource authHiveDataSource;

  AuthApiDataSource(this.dio, this.authHiveDataSource);

  @override
  Future<SignUpModel> signUp({
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
    try {
      final response = await dio.post(
        ApiManger.signUpEndpoint,
        data: {
          "fullName": fullName,
          "email": email,
          "password": password,
          "role": role,
          "phoneNumber": phoneNumber,
          "dateOfBirth": dateOfBirth,
          "bloodType": bloodType,
          "confirmPassword": confirmPassword,
          "gender": gender,
          "location": {
            "city": city,
            "governorate": governorate,
            "coordinates": {"lat": lat, "lng": lng},
          },
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return SignUpModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerifyEmailModel> verifyEmail({required String email}) async {
    try {
      final response = await dio.post(
        ApiManger.verifyEmailEndpoint,
        data: {"email": email},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return VerifyEmailModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerifyEmailModel> verifyEmailOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await dio.post(
        ApiManger.verifyEmailOtpEndpoint,
        data: {"email": email, "otp": otp},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return VerifyEmailModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final response = await dio.post(
        ApiManger.loginEndpoint,
        data: {"email": email, "password": password, "role": role},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LogOutModel> logOut({
    required String refreshToken,
    required String fcmToken,
  }) {
    try {
      return dio
          .post(
            ApiManger.logoutEndpoint,
            data: {"refreshToken": refreshToken, "fcmToken": fcmToken},
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            ),
          )
          .then((response) => LogOutModel.fromJson(response.data));
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ForgetPasswordModel> forgetPassword({required String email}) async {
    try {
      final response = await dio.post(
        ApiManger.forgetPasswordEndpoint,
        data: {"email": email},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return ForgetPasswordModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerifyOtpModel> verifyForgetPasswordOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await dio.post(
        ApiManger.verifyForgetPasswordOtp,
        data: {"email": email, "otp": otp},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return VerifyOtpModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResetPasswordModel> resetPassword({
    required String email,
    required String otp,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiManger.resetPasswordEndpoint,
        data: {"email": email, "otp": otp, "password": password},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      return ResetPasswordModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MeModel> getMe() async {
    try {
      final token = await authHiveDataSource.getAccessToken();
      final response = await dio.get(
        ApiManger.me,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return MeModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ValidateTokenModel> validateToken()async {
    try {
      final token = await authHiveDataSource.getAccessToken();
      final response = await dio.post(
        ApiManger.validateToken,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return ValidateTokenModel.fromJson(response.data);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
