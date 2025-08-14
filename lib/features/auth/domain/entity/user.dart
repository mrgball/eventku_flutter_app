import 'package:event_app/features/auth/domain/entity/user_preferences.dart';

class User {
  final String id;
  final String fullname;
  final String email;
  final bool isEmailVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserPreferences userPreferences;
  final String role;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.isEmailVerified,
    required this.createdAt,
    required this.updatedAt,
    required this.userPreferences,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'isEmailVerified': isEmailVerified,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'userPreferences': userPreferences.toJson(),
      'role': role,
    };
  }
}
