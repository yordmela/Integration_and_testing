import 'package:flutter_proj_2024/domain/auth/repositories/auth_repository.dart';

class SignUp {
  final AuthRepository repository;

  SignUp(this.repository);

  Future<Map<String, dynamic>?> call(String name, String email, String password, bool isAdmin) {
    return repository.signup(name, email, password, isAdmin);
  }
}
