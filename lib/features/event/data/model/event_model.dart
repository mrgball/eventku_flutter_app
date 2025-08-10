import 'package:event_app/features/event/data/model/category_model.dart';
import 'package:event_app/features/event/data/model/city_model.dart';
import 'package:event_app/features/event/data/model/ticket_model.dart';
import 'package:event_app/features/event/domain/entity/event.dart';

class EventModel extends Event {
  EventModel({
    required super.id,
    required super.name,
    required super.startDate,
    required super.endDate,
    required super.description,
    required super.banner,
    required super.isFeatured,
    required super.isOnline,
    required super.isPublished,
    required super.slug,
    required super.address,
    required super.longitude,
    required super.latitude,
    required super.createById,
    required super.updatedById,
    required super.categoryId,
    required super.regionId,
    required super.createdAt,
    required super.updatedAt,
    required super.category,
    required super.city,
    required super.tickets,
    required super.cheapestTicket,
    required super.totalAudience,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      name: json['name'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      description: json['description'],
      banner: json['banner'],
      isFeatured: json['isFeatured'],
      isOnline: json['isOnline'],
      isPublished: json['isPublished'],
      slug: json['slug'],
      address: json['address'],
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      createById: json['createById'],
      updatedById: json['updatedById'],
      categoryId: json['categoryId'],
      regionId: json['regionId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      category: CategoryModel.fromJson(json['category']),
      city: CityModel.fromJson(json['city']),
      tickets:
          (json['tickets'] == null || (json['tickets'] as List).isEmpty)
              ? []
              : (json['tickets'] as List)
                  .map((e) => TicketModel.fromJson(e))
                  .toList(),
      cheapestTicket:
          (json['cheapestTicket'] == null)
              ? null
              : TicketModel.fromJson(json['cheapestTicket']),
      totalAudience: json['totalAudience'],
    );
  }
}
