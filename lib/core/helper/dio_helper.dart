import 'package:dio/dio.dart';
import 'package:requests_inspector/requests_inspector.dart';

class DioHelper {
  final Dio dio;

  DioHelper({
    required String baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
  }) : dio = Dio(
         BaseOptions(
           connectTimeout: connectTimeout ?? const Duration(seconds: 60),
           receiveTimeout: receiveTimeout ?? const Duration(seconds: 60),
           baseUrl: const String.fromEnvironment('BASE_URL_PROD'),
           //  headers: {"X-API-KEY": baseUrl},
         ),
       ) {
    dio.interceptors.addAll([
      RequestsInspectorInterceptor(),
      // DioLoggingInterceptor(),
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
}
