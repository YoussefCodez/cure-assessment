import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'auth_mock_interceptor.dart';

@lazySingleton
class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = 'https://api.cure.com'
      ..options.connectTimeout = const Duration(seconds: 15)
      ..options.receiveTimeout = const Duration(seconds: 15)
      ..interceptors.add(AuthMockInterceptor());
  }

  Dio get dio => _dio;
}
