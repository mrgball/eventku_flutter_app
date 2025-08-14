import 'package:dio/dio.dart';
import 'package:event_app/core/helper/dio_helper.dart';
import 'package:event_app/core/helper/error_parser.dart';
import 'package:event_app/core/utils/app_exceptions.dart';
import 'package:event_app/core/utils/injector.dart';
import 'package:event_app/features/payment/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final _dioHelper = locator<DioHelper>();

  @override
  Future<Map<String, dynamic>> createOrder(List<dynamic>? params) async {
    try {
      final response = await _dioHelper.postRequestArray(
        '/api/v1/orders',
        requestBody: params,
      );

      if (response.statusCode != 201) {
        throw DataException(message: response.data['message']);
      }

      return response.data['data'] ?? {};
    } on DioException catch (e) {
      throw ErrorParser().parseErrorResponse(e);
    } catch (e) {
      rethrow;
    }
  }
}
