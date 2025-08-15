import 'package:equatable/equatable.dart';
import 'package:event_app/features/event/domain/entity/event.dart';
import 'package:event_app/features/event/domain/entity/ticket.dart';

class Order extends Equatable {
  final Event event;
  final Ticket ticket;
  final int quantity;

  const Order({
    required this.event,
    required this.ticket,
    required this.quantity,
  });

  @override
  List<Object?> get props => [event, ticket];
}
