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
      if (statusCode == 401) throw const UnauthorizedException();
      if (statusCode == 404) throw const NotFoundException();
      final data = e.response?.data;
      final serverMessage =
      data is Map ? data['message'] ?? data['error'] : null;
      throw ServerException(
        statusCode: statusCode,
        serverMessage: serverMessage?.toString(),
      );
    case DioExceptionType.cancel:
      throw const RequestCancelledException();
    default:
      throw UnknownNetworkException(message: e.message);
  }
}