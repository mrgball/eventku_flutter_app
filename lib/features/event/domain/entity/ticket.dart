class Ticket {
  final String id;
  final String name;
  final int price;
  final String description;
  final int quantity;
  final String createById;
  final String updatedById;
  final String eventId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Ticket({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.quantity,
    required this.createById,
    required this.updatedById,
    required this.eventId,
    required this.createdAt,
    required this.updatedAt,
  });
}
