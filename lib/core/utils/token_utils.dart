import 'dart:convert';

bool isTokenExpired(String? token) {
  if (token == null || token.isEmpty) return true;

  try {
    final parts = token.split('.');
    if (parts.length != 3) return true;

    final payload = utf8.decode(
      base64Url.decode(base64Url.normalize(parts[1])),
    );
    final payloadMap = jsonDecode(payload);

    if (payloadMap['exp'] == null) return true;

    final expiryDate = DateTime.fromMillisecondsSinceEpoch(
      payloadMap['exp'] * 1000,
    );

    return DateTime.now().isAfter(expiryDate);
  } catch (_) {
    return true;
  }
}
