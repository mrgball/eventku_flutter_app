class UserPreferences {
  final String id;
  final bool enable2FA;
  final bool emailNotification;
  final String? twoFactorSecret;
  final String userId;

  UserPreferences({
    required this.id,
    required this.enable2FA,
    required this.emailNotification,
    this.twoFactorSecret,
    required this.userId,
  });



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'enable2FA': enable2FA,
      'emailNotification': emailNotification,
      'twoFactorSecret': twoFactorSecret,
      'userId': userId,
    };
  }
}
