import 'package:equatable/equatable.dart';

class CreateOrderDto extends Equatable {
  final String idEvent;
  final int qty;
  final String idTicket;

  const CreateOrderDto({
    required this.idEvent,
    required this.qty,
    required this.idTicket,
  });

  Map<String, dynamic> toJson() {
    return {'id_event': idEvent, 'qty': qty, 'id_ticket': idTicket};
  }

  @override
  List<Object?> get props => [];
}
