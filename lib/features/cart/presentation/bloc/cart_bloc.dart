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
    on<UpdateTicketQtyEvent>(_onUpdateTicketQty);
  }

  void _onUpdateTicketQty(UpdateTicketQtyEvent event, Emitter<CartState> emit) async {
    var completer = Completer();

    try {
      gNavigatorKey.currentContext!.showBlockDialog(completer: completer);

      await Future.delayed(Duration(milliseconds: 1000));

      await _cartService.updateCartQuantity(event.userId, event.ticketId, event.quantity);

      final updatedGroupedCart = _updateGroupedCartQuantity(
        state.groupedCart,
        event.userId,
        event.ticketId,
        isIncrement: event.isIncrement,
      );

      emit(state.copyWith(groupedCart: updatedGroupedCart));

      if (!completer.isCompleted) {
        completer.complete();
      }
    } catch (e) {
      add(GetCartEvent());

      if (!completer.isCompleted) {
        completer.complete();
      }
    }
  }

  void _onGetCart(GetCartEvent event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      final response = await _cartService.getCartItems();

      print('response cart: $response');

      final Map<String, List<CartItem>> groupedCart = {};

      for (var cart in response) {
        final eventName = cart.name;

        if (groupedCart.containsKey(eventName)) {
          groupedCart[eventName]!.add(cart);
        } else {
          groupedCart[eventName] = [cart];
        }
      }

      emit(state.copyWith(status: BlocStatus.success, listCart: response, groupedCart: groupedCart));
    } catch (e, s) {
      print('error pas pertama:$e \n $s');
      emit(state.copyWith(status: BlocStatus.success, listCart: [], groupedCart: {}));
    }
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    var completer = Completer();

    try {
      gNavigatorKey.currentContext!.showBlockDialog(completer: completer);

      await _cartService.addToCart(event.order);

      await Future.delayed(const Duration(milliseconds: 1000));

      showToast(
        context: gNavigatorKey.currentContext!,
        message: 'Success add your item to cart',
        type: ToastificationType.success,
        duration: Duration(seconds: 2),
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
        duration: Duration(seconds: 2),
      );
    } finally {
      if (!completer.isCompleted) {
        completer.complete();
      }
    }
  }

  Map<String, List<CartItem>> _updateGroupedCartQuantity(
    Map<String, List<CartItem>> currentGroupedCart,
    String userId,
    String ticketId, {
    bool isIncrement = true,
  }) {
    final updatedGroupedCart = <String, List<CartItem>>{};

    for (final entry in currentGroupedCart.entries) {
      final eventName = entry.key;
      final items = entry.value;
      final updatedItems = <CartItem>[];

      for (final item in items) {
        if (item.idUser == userId && item.idTicket == ticketId) {
          final newQuantity = (isIncrement) ? item.quantity + 1 : item.quantity - 1;

          if (newQuantity > 0) {
            updatedItems.add(item.copyWith(quantity: newQuantity));
          }
        } else {
          updatedItems.add(item);
        }
      }

      if (updatedItems.isNotEmpty) {
        updatedGroupedCart[eventName] = updatedItems;
      }
    }

    return updatedGroupedCart;
  }
}
