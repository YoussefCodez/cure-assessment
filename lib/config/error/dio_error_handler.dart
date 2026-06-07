import 'package:dio/dio.dart';

class DioErrorHandler {
  static Exception handleError(DioException error) {
    String message = 'Unexpected error occurred';
    if (error.response != null) {
      final data = error.response?.data;
      if (data is Map && data.containsKey('message')) {
        message = data['message'] as String;
      } else {
        message = 'Server error: ${error.response?.statusCode}';
      }
    } else {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          message = 'Connection timeout';
          break;
        case DioExceptionType.sendTimeout:
          message = 'Send timeout';
          break;
        case DioExceptionType.receiveTimeout:
          message = 'Receive timeout';
          break;
        case DioExceptionType.cancel:
          message = 'Request cancelled';
          break;
        default:
          message = 'No internet connection';
          break;
      }
    }
    return Exception(message);
  }
}
