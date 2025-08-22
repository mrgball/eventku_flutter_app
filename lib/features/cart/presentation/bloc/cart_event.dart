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
