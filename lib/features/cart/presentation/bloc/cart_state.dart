part of 'cart_bloc.dart';

class CartState extends Equatable {
  final BlocStatus status;
  final List<CartItem> listCart;
  final Map<String, List<CartItem>> groupedCart;

  const CartState({this.status = BlocStatus.initial, this.listCart = const [], this.groupedCart = const {}});

  CartState copyWith({BlocStatus? status, List<CartItem>? listCart, Map<String, List<CartItem>>? groupedCart}) =>
      CartState(
        status: status ?? this.status,
        listCart: listCart ?? this.listCart,
        groupedCart: groupedCart ?? this.groupedCart,
      );

  int get totalCart => listCart.length;

  @override
  List<Object?> get props => [status, listCart, groupedCart, totalCart];
}
