import 'package:dio/dio.dart';
import 'package:event_app/core/helper/dio_helper.dart';
import 'package:event_app/core/helper/error_parser.dart';
import 'package:event_app/core/utils/injector.dart';
import 'package:event_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DioHelper _dioHelper = locator<DioHelper>();

  @override
  Future<Map<String, dynamic>> registerAccount(
    Map<String, dynamic>? params,
  ) async {
    try {
      final response = await _dioHelper.postRequest(
        '/api/v1/auth/register',
        requestBody: params,
      );

      return response.data ?? {};
    } on DioException catch (e) {
      throw ErrorParser().parseErrorResponse(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> loginAccount(
    Map<String, dynamic>? params,
  ) async {
    try {
      final response = await _dioHelper.postRequest(
        '/api/v1/auth/login',
        requestBody: params,
      );

      return response.data ?? {};
    } on DioException catch (e) {
      throw ErrorParser().parseErrorResponse(e);
    } catch (e) {
      rethrow;
    }
  }
}
