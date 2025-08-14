abstract class PaymentRepository {
  Future<Map<String, dynamic>> createOrder(List<dynamic>? body);
}
