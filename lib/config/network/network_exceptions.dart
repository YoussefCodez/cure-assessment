import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String message;
  const NetworkException([this.message = 'No Internet Connection']);

  @override
  String toString() => message;
}

class ErrorHandler {
  static String handle(dynamic error) {
    if (error is NetworkException) {
      return error.message;
    }
    
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Connection timed out. Please try again.';
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          if (statusCode == 401 || statusCode == 403) {
            return 'Unauthorized access. Please login again.';
          } else if (statusCode == 404) {
            return 'Requested resource not found.';
          } else if (statusCode != null && statusCode >= 500) {
            return 'Server error. Please try again later.';
          }
          return error.response?.data?['message']?.toString() ?? 'Something went wrong';
        case DioExceptionType.cancel:
          return 'Request was cancelled.';
        case DioExceptionType.connectionError:
          return 'No internet connection.';
        default:
          return 'An unexpected network error occurred.';
      }
    }
    
    return error?.toString() ?? 'An unknown error occurred';
  }
}
