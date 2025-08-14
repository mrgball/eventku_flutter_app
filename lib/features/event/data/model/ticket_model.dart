import 'package:event_app/features/event/domain/entity/ticket.dart';

class TicketModel extends Ticket {
  TicketModel({
    required super.id,
    required super.name,
    required super.price,
    required super.description,
    required super.quantity,
    required super.createById,
    required super.updatedById,
    required super.eventId,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      quantity: json['quantity'],
      createById: json['createById'],
      updatedById: json['updatedById'],
      eventId: json['eventId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "description": description,
      "quantity": quantity,
      "createById": createById,
      "updatedById": updatedById,
      "eventId": eventId,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }
}
