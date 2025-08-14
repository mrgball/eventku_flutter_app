part of 'payment_bloc.dart';

class PaymentState extends Equatable {
  final BlocStatus orderStatus;

  const PaymentState({this.orderStatus = BlocStatus.initial});

  PaymentState copyWith({BlocStatus? orderStatus}) =>
      PaymentState(orderStatus: orderStatus ?? this.orderStatus);

  @override
  List<Object?> get props => [orderStatus];
}
