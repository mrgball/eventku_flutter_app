import 'dart:async';

import 'package:event_app/core/config/enum.dart';
import 'package:event_app/core/config/extension.dart';
import 'package:event_app/core/config/global.dart';
import 'package:event_app/core/shared/widget/custom_toast.dart';
import 'package:event_app/core/utils/app_exceptions.dart';
import 'package:event_app/core/utils/injector.dart';
import 'package:event_app/features/payment/data/dto/create_order_dto.dart';
import 'package:event_app/features/payment/domain/usecase/payment_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:toastification/toastification.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentState()) {
    on<CreateOrderEvent>(_onCreateOrder);
    on<StartPaymentEvent>(_onStartPayment);
  }

  void _onCreateOrder(
    CreateOrderEvent event,
    Emitter<PaymentState> emit,
  ) async {
    var completer = Completer();

    try {
      gNavigatorKey.currentContext!.showBlockDialog(completer: completer);

      emit(state.copyWith(orderStatus: BlocStatus.loading));

      final response = await locator<CreateOrderUseCase>().call(
        params:
            event.orders
                .map(
                  (o) => {
                    'eventId': o.idEvent,
                    'quantity': o.qty,
                    'ticketId': o.idTicket,
                  },
                )
                .toList(),
      );

      if (response.isEmpty) {
        throw DataException(message: 'Gagal create order');
      }

      if (!completer.isCompleted) {
        completer.complete();
      }

      add(StartPaymentEvent(snapToken: response['payment']['token']));
    } on DataException catch (e) {
      if (!completer.isCompleted) {
        completer.complete();
      }

      showToast(
        context: gNavigatorKey.currentContext!,
        message: e.toString(),
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
      );

      emit(state.copyWith(orderStatus: BlocStatus.error));
    } catch (e) {
      if (!completer.isCompleted) {
        completer.complete();
      }

      showToast(
        context: gNavigatorKey.currentContext!,
        message: 'Terjadi kesalahan pada sistem',
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
      );

      emit(state.copyWith(orderStatus: BlocStatus.error));
    } finally {
      if (!completer.isCompleted) {
        completer.complete();
      }
    }
  }

  Future<void> _onStartPayment(
    StartPaymentEvent event,
    Emitter<PaymentState> emit,
  ) async {
    final midtrans = await MidtransSDK.init(
      config: MidtransConfig(
        clientKey: String.fromEnvironment('MIDTRANS_CLIENT_KEY'),
        merchantBaseUrl: String.fromEnvironment('BASE_URL_PROD'),
      ),
    );

    await midtrans.startPaymentUiFlow(token: event.snapToken);

    midtrans.setTransactionFinishedCallback((result) {
      showToast(
        context: gNavigatorKey.currentContext!,
        message: result.status.toUpperCase(),
      );

      Navigator.of(gNavigatorKey.currentContext!).pop();
    });
  }
}
