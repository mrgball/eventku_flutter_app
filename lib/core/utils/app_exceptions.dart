class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => message;
}

class BasicException extends AppException {
  BasicException({required String message}) : super(message);
}

class NoConnectionException extends AppException {
  NoConnectionException({required String message}) : super(message);
}

class BadRequestException extends AppException {
  BadRequestException({required String message}) : super(message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException({required String message}) : super(message);
}

class InvalidInputException extends AppException {
  InvalidInputException({required String message}) : super(message);
}

class NotFoundException extends AppException {
  NotFoundException({required String message}) : super(message);
}

class DataException extends AppException {
  final List<String> errMessage;
  final String? errorCode;

  DataException({
    required String message,
    this.errMessage = const [],
    this.errorCode,
  }) : super(message);
}

class QRException extends AppException {
  QRException({required String message}) : super(message);
}

class LocationException extends AppException {
  String title;

  LocationException({required this.title, required String message})
    : super(message);
}
