import 'package:event_app/features/auth/data/model/user_preferences_model.dart';
import 'package:event_app/features/auth/domain/entity/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.fullname,
    required super.email,
    required super.isEmailVerified,
    required super.createdAt,
    required super.updatedAt,
    required super.userPreferences,
    required super.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] ?? '',
    fullname: json['fullname'] ?? '',
    email: json['email'] ?? '',
    isEmailVerified: json['isEmailVerified'] == true,
    createdAt:
        (json['createdAt'] == null)
            ? DateTime.now()
            : DateTime.parse(json['createdAt']),
    updatedAt:
        (json['updatedAt'] == null)
            ? DateTime.now()
            : DateTime.parse(json['updatedAt']),
    userPreferences: UserPreferencesModel.fromJson(json['userPreferences']),
    role: json['role'] ?? '',
  );
}
