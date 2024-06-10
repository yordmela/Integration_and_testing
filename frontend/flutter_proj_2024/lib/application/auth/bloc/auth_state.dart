import 'package:equatable/equatable.dart';
import 'package:flutter_proj_2024/domain/auth/entities/user.dart'; // Adjust the path as needed

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String token;
  final String role;

  AuthSuccess({required this.token, required this.role});

  @override
  List<Object> get props => [token, role];
}

class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

// Add this class
class AuthAuthenticated extends AuthState {
  final User user;

  AuthAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}
