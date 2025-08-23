import 'package:event_app/features/cart/domain/entity/cart_item.dart';

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.idEvent,
    required super.idTicket,
    required super.name,
    required super.price,
    required super.quantity,
    required super.ticketName,
    required super.idUser,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      idEvent: json['event_id'],
      idTicket: json['ticket_id'],
      idUser: json['user_id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      ticketName: json['ticket_name'],
    );
  }
}
