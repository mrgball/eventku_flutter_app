import 'dart:async';

import 'package:event_app/core/shared/widget/custom_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/config/enum.dart';
import 'package:event_app/core/config/extension.dart';
import 'package:event_app/core/config/global.dart';
import 'package:event_app/core/helper/cart_service.dart';
import 'package:toastification/toastification.dart';

import '../../domain/entity/cart_item.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService _cartService = CartService();

  CartBloc() : super(CartState()) {
    on<AddToCartEvent>(_onAddToCart);
    on<GetCartEvent>(_onGetCart);
  }

  void _onGetCart(GetCartEvent event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      final response = await _cartService.getCartItems();

      emit(state.copyWith(status: BlocStatus.success, listCart: response));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.success, listCart: []));
    }
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    var completer = Completer();

    try {
      gNavigatorKey.currentContext!.showBlockDialog(completer: completer);

      await _cartService.addToCart(event.order);

      final existingCart = List<CartItem>.from(state.listCart);

      final index = existingCart.indexWhere((item) => item.idTicket == event.order.idTicket);

      if (index != -1) {
        existingCart[index] = existingCart[index].copyWith(
          quantity: existingCart[index].quantity + event.order.quantity,
        );
      } else {
        existingCart.add(
          CartItem(
            idEvent: event.order.idEvent,
            name: event.order.name,
            price: event.order.price,
            quantity: event.order.quantity,
            ticketName: event.order.ticketName,
            idTicket: event.order.idTicket,
          ),
        );
      }

      emit(state.copyWith(listCart: existingCart));

      await Future.delayed(const Duration(milliseconds: 1000));

      showToast(
        context: gNavigatorKey.currentContext!,
        message: 'Success add your item to cart',
        type: ToastificationType.success,
      );

      if (!completer.isCompleted) {
        completer.complete();
      }
    } catch (e, s) {
      print('error add to cart: $e \n $s');

      showToast(
        context: gNavigatorKey.currentContext!,
        message: 'Failed to add your item to cart',
        type: ToastificationType.error,
      );
    } finally {
      if (!completer.isCompleted) {
        completer.complete();
      }
    }
  }
}
