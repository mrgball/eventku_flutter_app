import 'package:event_app/core/shared/base_usecase.dart';
import 'package:event_app/features/payment/domain/repository/payment_repository.dart';

class CreateOrderUseCase
    implements BaseUsecase<Map<String, dynamic>, List<dynamic>> {
  final PaymentRepository _paymentRepository;

  CreateOrderUseCase(this._paymentRepository);

  @override
  Future<Map<String, dynamic>> call({List<dynamic>? params}) {
    return _paymentRepository.createOrder(params);
  }
}
