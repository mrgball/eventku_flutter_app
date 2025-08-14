import 'package:event_app/features/auth/domain/entity/user_preferences.dart';

class UserPreferencesModel extends UserPreferences {
  UserPreferencesModel({
    required super.id,
    required super.enable2FA,
    required super.emailNotification,
    required super.userId,
    super.twoFactorSecret,
  });

  factory UserPreferencesModel.fromJson(Map<String, dynamic> json) {
    return UserPreferencesModel(
      id: json['id'],
      enable2FA: json['enable2FA'] == true,
      emailNotification: json['emailNotification'] == true,
      userId: json['userId'],
      twoFactorSecret: json['twoFactorSecret'],
    );
  }
}
