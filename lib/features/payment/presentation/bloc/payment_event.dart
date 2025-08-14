part of 'payment_bloc.dart';

class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class CreateOrderEvent extends PaymentEvent {
  final String idEvent;
  final int qty;
  final String idTicket;

  const CreateOrderEvent({
    required this.idEvent,
    required this.idTicket,
    required this.qty,
  });

  @override
  List<Object?> get props => [idEvent, qty, idTicket];
}

class StartPaymentEvent extends PaymentEvent {
  final String? snapToken;

  const StartPaymentEvent({required this.snapToken});

  @override
  List<Object?> get props => [snapToken];
}
