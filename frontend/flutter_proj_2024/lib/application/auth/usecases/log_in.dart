import 'package:flutter_proj_2024/domain/auth/repositories/auth_repository.dart';

class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<Map<String, dynamic>?> call(String email, String password) {
    return repository.login(email, password);
  }
}
