import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final bool isAdmin;

  SignUpRequested({required this.name, required this.email, required this.password, required this.isAdmin});

  @override
  List<Object> get props => [name, email, password, isAdmin];
}

class LoggedOut extends AuthEvent {}
