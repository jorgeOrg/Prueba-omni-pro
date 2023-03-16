import 'dart:async';
import 'dart:io';

class ExceptionHandlers {
  static getExceptionString(error) {
    switch (error) {
      case SocketException:
        return 'No internet connection.';
      case HttpException:
        return 'HTTP error occured.';
      case FormatException:
        return 'Invalid data format.';
      case TimeoutException:
        return 'Request timedout.';
      case BadRequestException:
        return error.message.toString();
      case UnAuthorizedException:
        return error.message.toString();
      case NotFoundException:
        return error.message.toString();
      case FetchDataException:
        return error.message.toString();
      default:
        return 'Unknown error occured.';
    }
  }
}

class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException([this.message, this.prefix, this.url]);
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url])
      : super(message, 'Bad request', url);
}

class FetchDataException extends AppException {
  FetchDataException([String? message, String? url])
      : super(message, 'Unable to process the request', url);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message, String? url])
      : super(message, 'Api not responding', url);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, String? url])
      : super(message, 'Unauthorized request', url);
}

class NotFoundException extends AppException {
  NotFoundException([String? message, String? url])
      : super(message, 'Page not found', url);
}