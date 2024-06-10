import 'package:flutter_proj_2024/domain/auth/repositories/auth_repository.dart';
import 'package:flutter_proj_2024/infrastructure/auth/data_sources/auth_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi authApi;

  AuthRepositoryImpl({required this.authApi});

  @override
  Future<Map<String, dynamic>?> login(String email, String password) async {
    return await authApi.login(email, password);
  }

  @override
  Future<Map<String, dynamic>?> signup(String name, String email, String password, bool isAdmin) async {
    return await authApi.signup(name, email, password, isAdmin);
  }

   @override
  Future<void> logout() async {
    // Implement the logic to log out the user
    // This might include clearing tokens, session data, etc.
    await authApi.logout();
  }

}
