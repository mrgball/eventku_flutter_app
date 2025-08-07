import 'package:dio/dio.dart';
import 'package:event_app/core/helper/dio_helper.dart';
import 'package:event_app/core/helper/error_parser.dart';
import 'package:event_app/core/utils/app_exceptions.dart';
import 'package:event_app/core/utils/injector.dart';
import 'package:event_app/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final DioHelper _dioHelper = locator<DioHelper>();

  @override
  Future<List> fetchBanner(Map<String, dynamic>? params) async {
    try {
      final response = await _dioHelper.getRequest(
        '/api/v1/banner',
        queryParameters: params,
      );

      if (!(response.data['message'] as String).contains('Success')) {
        throw DataException(message: response.data['message']);
      }

      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw ErrorParser().parseErrorResponse(e);
    } catch (e) {
      rethrow;
    }
  }
}
