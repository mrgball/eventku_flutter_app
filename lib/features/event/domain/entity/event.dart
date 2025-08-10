import 'package:event_app/features/event/domain/entity/category.dart';
import 'package:event_app/features/event/domain/entity/city.dart';
import 'package:event_app/features/event/domain/entity/ticket.dart';

class Event {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final String banner;
  final bool isFeatured;
  final bool isOnline;
  final bool isPublished;
  final String slug;
  final String address;
  final double longitude;
  final double latitude;
  final String createById;
  final String updatedById;
  final String categoryId;
  final String regionId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Category category;
  final City city;
  final List<Ticket> tickets;
  final Ticket? cheapestTicket;
  final int totalAudience;

  Event({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.banner,
    required this.isFeatured,
    required this.isOnline,
    required this.isPublished,
    required this.slug,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.createById,
    required this.updatedById,
    required this.categoryId,
    required this.regionId,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.city,
    required this.tickets,
    this.cheapestTicket,
    required this.totalAudience,
  });
}
