import 'package:blood_donation_app/core/resources/api_manger/api_constants.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/login_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/sign_up_model.dart';
import 'package:blood_donation_app/presentation/authentication/donor_authentication/data/model/verify_email_model.dart';
import 'package:dio/dio.dart';

class AuthApiDataSource implements AuthRemoteDataSource {
  final Dio dio;

  AuthApiDataSource(this.dio);

  @override
  Future<SignUpModel> signUp({
    required String fullName,
    required String email,
    required String password,
    required String role,
    required String phoneNumber,
    required String dateOfBirth,
    required String bloodType,
    required String confirmPassword,
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
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        if (response.data == null) {
          throw Exception('EMPTY_RESPONSE');
        }

        return SignUpModel.fromJson(response.data);
      }

      throw Exception(_extractServerError(response));
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    } catch (e) {
      throw Exception('UNKNOWN_ERROR');
    }
  }

  String _extractServerError(Response response) {
    final data = response.data;

    if (data is Map && data['message'] != null) {
      return data['message'];
    }

    return response.statusMessage ?? 'SERVER_ERROR';
  }

  String _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'CONNECTION_TIMEOUT';

      case DioExceptionType.sendTimeout:
        return 'SEND_TIMEOUT';

      case DioExceptionType.receiveTimeout:
        return 'RECEIVE_TIMEOUT';

      case DioExceptionType.badResponse:
        return 'BAD_RESPONSE';

      case DioExceptionType.cancel:
        return 'REQUEST_CANCELLED';

      case DioExceptionType.connectionError:
        return 'NO_INTERNET';

      default:
        return 'UNKNOWN_ERROR';
    }
  }

  @override
  Future<VerifyEmailModel> verifyEmail({required String email})async {
    try {
      final response = await dio.post(
        ApiManger.verifyEmailEndpoint,
        data: {
          "email": email,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        if (response.data == null) {
          throw Exception('EMPTY_RESPONSE');
        }

        return VerifyEmailModel.fromJson(response.data);
      }

      throw Exception(_extractServerError(response));
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    } catch (e) {
      throw Exception('UNKNOWN_ERROR');
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
        data: {
          "email": email,
          "otp": otp,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        if (response.data == null) {
          throw Exception('EMPTY_RESPONSE');
        }

        return VerifyEmailModel.fromJson(response.data);
      }

      throw Exception(_extractServerError(response));
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    } catch (e) {
      throw Exception('UNKNOWN_ERROR');
    }
  }

  @override
  Future<LoginModel> login({required String email, required String password, required String role}) async{

    try {
      final response = await dio.post(
        "https://graduation-project-cy61.onrender.com/auth/login",
        data: {
          "email": email,
          "password": password,
          "role": role,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        if (response.data == null) {
          throw Exception('EMPTY_RESPONSE');
        }

        return LoginModel.fromJson(response.data);
      }

      throw Exception(_extractServerError(response));
    } on DioException catch (e) {
      throw Exception(_mapDioError(e));
    } catch (e) {
      throw Exception('UNKNOWN_ERROR');
    }
  }
}
