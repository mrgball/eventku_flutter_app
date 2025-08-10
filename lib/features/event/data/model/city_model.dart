import 'package:event_app/features/event/domain/entity/city.dart';

class CityModel extends City {
  CityModel({
    required super.id,
    required super.code,
    required super.name,
    required super.provinceId,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      provinceId: json['provinceId'],
    );
  }
}
