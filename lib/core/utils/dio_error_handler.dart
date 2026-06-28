import 'package:blood_donation_app/core/errors/app_exceptions.dart';
import 'package:dio/dio.dart';

void handleDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      throw const NetworkTimeoutException();
    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      final data = e.response?.data;

      final serverMessage = _extractServerMessage(data);

      if (statusCode == 400) {
        throw ServerException(
          statusCode: statusCode,
          serverMessage: serverMessage ?? 'Invalid request',
        );
      }

      if (statusCode == 401) {
        throw UnauthorizedException(
          message: serverMessage,
        );
      }

      if (statusCode == 403) {
        throw ServerException(
          statusCode: statusCode,
          serverMessage: serverMessage ?? 'Access forbidden',
        );
      }

      if (statusCode == 404) {
        throw const NotFoundException();
      }

      if (statusCode == 409) {
        throw ServerException(
          statusCode: statusCode,
          serverMessage: serverMessage ?? 'Resource already exists',
        );
      }

      if (statusCode == 422) {
        throw ServerException(
          statusCode: statusCode,
          serverMessage: serverMessage ?? 'Invalid input provided',
        );
      }

      if (statusCode == 429) {
        throw ServerException(
          statusCode: statusCode,
          serverMessage: serverMessage ?? 'Too many requests. Please try again later.',
        );
      }

      if (statusCode == 500) {
        throw ServerException(
          statusCode: statusCode,
          serverMessage: serverMessage ?? 'Server error. Please try again later.',
        );
      }

      if (statusCode == 503) {
        throw ServerException(
          statusCode: statusCode,
          serverMessage: serverMessage ?? 'Service temporarily unavailable. Please try again later.',
        );
      }

      throw ServerException(
        statusCode: statusCode,
        serverMessage: serverMessage,
      );

    case DioExceptionType.cancel:
      throw const RequestCancelledException();
    case DioExceptionType.connectionError:
      throw const NetworkConnectionException();
    default:
      throw UnknownNetworkException(message: e.message);
  }
}


String? _extractServerMessage(dynamic data) {
  if (data == null) return null;

  if (data is Map<String, dynamic>) {
    if (data['message'] != null) return data['message'].toString();
    if (data['error'] != null) return data['error'].toString();
    if (data['errorMessage'] != null) return data['errorMessage'].toString();
    if (data['msg'] != null) return data['msg'].toString();

    if (data['errors'] is Map && data['errors'].isNotEmpty) {
      final firstError = data['errors'].values.first;
      if (firstError is String) return firstError;
      if (firstError is List && firstError.isNotEmpty) {
        return firstError.first.toString();
      }
    }
  }

  if (data is String && data.isNotEmpty) {
    return data;
  }

  return null;
}

