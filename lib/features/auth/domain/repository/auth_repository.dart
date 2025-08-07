abstract class AuthRepository {
  Future<Map<String, dynamic>> registerAccount(Map<String, dynamic>? params);
  Future<Map<String, dynamic>> loginAccount(Map<String, dynamic>? params);
}
