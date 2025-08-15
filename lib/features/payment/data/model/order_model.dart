import 'package:event_app/features/payment/domain/entity/order.dart';

class OrderModel extends Order {
  const OrderModel({
    required super.event,
    required super.ticket,
    required super.quantity,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    event: json['event'],
    ticket: json['ticket'],
    quantity: json['quantity'],
  );
}
