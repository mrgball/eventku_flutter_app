import 'package:event_app/features/home/domain/entity/banner.dart';

class BannerModel extends Banner {
  const BannerModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    required super.isShow,
    required super.createdAt,
    required super.createdBy,
    required super.updatedAt,
    required super.updatedBy,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    id: json['id'] ?? '',
    title: json['title'] ?? '',
    imageUrl: json['image'] ?? '',
    isShow: json['isShow'] == true,
    createdBy: json['createById'] ?? '',
    updatedBy: json['updatedById'] ?? '',
    createdAt:
        (json['createdAt'] == null)
            ? DateTime.now()
            : DateTime.parse(json['createdAt']),
    updatedAt:
        (json['updatedAt'] == null)
            ? DateTime.now()
            : DateTime.parse(json['updatedAt']),
  );
}
