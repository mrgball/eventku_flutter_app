part of 'payment_bloc.dart';

class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class CreateOrderEvent extends PaymentEvent {
  final List<CreateOrderDto> orders;

  const CreateOrderEvent({required this.orders});

  @override
  List<Object?> get props => [orders];
}

class StartPaymentEvent extends PaymentEvent {
  final String? snapToken;

  const StartPaymentEvent({required this.snapToken});

  @override
  List<Object?> get props => [snapToken];
}
