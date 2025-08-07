import 'package:dio/dio.dart';
import 'package:event_app/core/utils/app_exceptions.dart';

class ErrorParser {
  DataException parseErrorResponse(DioException e) {
    final data = e.response?.data;
    final rawErrors = data?['errors'];
    final topErrorCode = data?['errorCode'];
    final topMessage = data?['message'] ?? 'Terjadi kesalahan';

    String message = topMessage;
    List<String>? errMessages = [];
    String? errorCode;

    if (rawErrors is List) {
      errMessages =
          rawErrors
              .map(
                (err) => '${err['field'] ?? '-'}: ${err['message'] ?? 'Error'}',
              )
              .toList();

      message = errMessages.join('\n');
    } else if (topErrorCode != null) {
      errorCode = topErrorCode.toString();
    }

    return DataException(
      message: message,
      errMessage: errMessages,
      errorCode: errorCode,
    );
  }
}
