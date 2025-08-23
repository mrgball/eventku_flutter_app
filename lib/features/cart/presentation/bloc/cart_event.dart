part of 'cart_bloc.dart';

class CartEvent extends Equatable {
  const CartEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddToCartEvent extends CartEvent {
  final CartItem order;

  const AddToCartEvent(this.order);

  @override
  List<Object?> get props => [order];
}

class GetCartEvent extends CartEvent {}

class UpdateTicketQtyEvent extends CartEvent {
  final String userId;
  final String ticketId;
  final int quantity;
  final bool isIncrement;

  const UpdateTicketQtyEvent({
    required this.userId,
    required this.ticketId,
    required this.quantity,
    required this.isIncrement,
  });

  @override
  List<Object?> get props => [userId, ticketId, quantity, isIncrement];
}
