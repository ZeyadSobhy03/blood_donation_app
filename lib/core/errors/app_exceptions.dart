class NetworkTimeoutException implements Exception {
  const NetworkTimeoutException();
}

class NetworkConnectionException implements Exception {
  const NetworkConnectionException();
}

class ServerException implements Exception {
  final int? statusCode;
  final String? serverMessage;
  const ServerException({this.statusCode, this.serverMessage});
}

class RequestCancelledException implements Exception {
  const RequestCancelledException();
}

class UnknownNetworkException implements Exception {
  final String? message;
  const UnknownNetworkException({this.message});
}

class UnauthorizedException implements Exception {
  final String? message;
  const UnauthorizedException({this.message});
}

class NotFoundException implements Exception {
  const NotFoundException();
}