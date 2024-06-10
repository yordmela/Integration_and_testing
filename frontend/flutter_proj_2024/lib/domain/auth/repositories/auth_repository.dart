abstract class AuthRepository {
  Future<Map<String, dynamic>?> login(String email, String password);
  Future<Map<String, dynamic>?> signup(String name, String email, String password, bool isAdmin);
  Future<void> logout();
}
