import 'package:dio/dio.dart';
import 'package:event_app/core/helper/refresh_token_interceptor.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:requests_inspector/requests_inspector.dart';

class DioHelper {
  final Dio dio;
  final _secureStorage = const FlutterSecureStorage();

  DioHelper({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    bool isTransaction = false,
  }) : dio = Dio(
         BaseOptions(
           connectTimeout: connectTimeout ?? const Duration(seconds: 60),
           receiveTimeout: receiveTimeout ?? const Duration(seconds: 60),
           baseUrl:
               (isTransaction)
                   ? const String.fromEnvironment('MIDTRANS_TRANSACTION_URL')
                   : const String.fromEnvironment('BASE_URL_PROD'),
           headers: {'Content-Type': 'application/json'},
         ),
       ) {
    dio.interceptors.addAll([
      RequestsInspectorInterceptor(),
      // DioLoggingInterceptor(),
      RefreshTokenInterceptor(dio, _secureStorage),
    ]);
  }

  Future<Response> postRequest(
    String path, {
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await dio.post(
        path,
        data: requestBody,
        queryParameters: queryParameters,
      );

      if ((res.statusCode ?? 0) < 200 || (res.statusCode ?? 0) >= 300) {
        throw DioException(requestOptions: res.requestOptions);
      }

      return res;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<Response> getRequest(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    try {
      final res = await dio.get(
        path,
        queryParameters: queryParameters,
        data: body,
      );

      if ((res.statusCode ?? 0) < 200 || (res.statusCode ?? 0) >= 300) {
        throw DioException(requestOptions: res.requestOptions);
      }

      return res;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<Response> patchRequest(
    String path, {
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await dio.patch(
        path,
        data: requestBody,
        queryParameters: queryParameters,
      );

      if ((res.statusCode ?? 0) < 200 || (res.statusCode ?? 0) >= 300) {
        throw DioException(requestOptions: res.requestOptions);
      }

      return res;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<Response> putRequest(
    String path, {
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await dio.put(
        path,
        data: requestBody,
        queryParameters: queryParameters,
      );

      if ((res.statusCode ?? 0) < 200 || (res.statusCode ?? 0) >= 300) {
        throw DioException(requestOptions: res.requestOptions);
      }

      return res;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<Response> postRequestArray(
    String path, {
    List<dynamic>? requestBody,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await dio.post(
        path,
        data: requestBody,
        queryParameters: queryParameters,
      );

      if ((res.statusCode ?? 0) < 200 || (res.statusCode ?? 0) >= 300) {
        throw DioException(requestOptions: res.requestOptions);
      }

      return res;
    } on DioException catch (_) {
      rethrow;
    }
  }
}
