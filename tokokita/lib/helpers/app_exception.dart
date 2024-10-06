class AppException implements Exception {
  final String? _message; // Menggunakan tipe data yang eksplisit
  final String _prefix;

  // Konstruktor dengan parameter opsional
  AppException([this._message, this._prefix = ""]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

// Exception yang terjadi saat kesalahan pengambilan data
class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

// Exception untuk request yang tidak valid
class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, "Invalid Request: ");
}

// Exception untuk kesalahan otorisasi
class UnauthorisedException extends AppException {
  UnauthorisedException([String? message]) : super(message, "Unauthorised: ");
}

// Exception untuk entitas yang tidak dapat diproses
class UnprocessableEntityException extends AppException {
  UnprocessableEntityException([String? message])
      : super(message, "Unprocessable Entity: ");
}

// Exception untuk input yang tidak valid
class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
