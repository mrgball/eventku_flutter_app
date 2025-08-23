import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String idUser;
  final String idEvent;
  final String idTicket;
  final String name;
  final String ticketName;
  final int price;
  final int quantity;

  const CartItem({
    required this.idUser,
    required this.idEvent,
    required this.idTicket,
    required this.name,
    required this.price,
    required this.quantity,
    required this.ticketName,
  });

  CartItem copyWith({
    String? idEvent,
    String? idUser,
    String? idTicket,
    String? name,
    String? ticketName,
    int? price,
    int? quantity,
  }) => CartItem(
    idEvent: idEvent ?? this.idEvent,
    idUser: idUser ?? this.idUser,
    idTicket: idTicket ?? this.idTicket,
    name: name ?? this.name,
    ticketName: ticketName ?? this.ticketName,
    price: price ?? this.price,
    quantity: quantity ?? this.quantity,
  );

  @override
  List<Object?> get props => [idEvent, idTicket, idUser, name, price, quantity, ticketName];
}
