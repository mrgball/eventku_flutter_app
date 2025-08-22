part of 'cart_bloc.dart';

class CartState extends Equatable {
  final BlocStatus status;
  final List<CartItem> listCart;

  const CartState({this.status = BlocStatus.initial, this.listCart = const []});

  CartState copyWith({BlocStatus? status, List<CartItem>? listCart}) =>
      CartState(status: status ?? this.status, listCart: listCart ?? this.listCart);

  int get totalCart => listCart.length;

  @override
  List<Object?> get props => [status, listCart, totalCart];
}
