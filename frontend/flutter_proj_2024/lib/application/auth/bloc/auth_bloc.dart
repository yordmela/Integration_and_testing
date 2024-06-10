import 'package:bloc/bloc.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_event.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_state.dart';
import 'package:flutter_proj_2024/domain/auth/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<LoggedOut>(_onLoggedOut);  // Add this line
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await authRepository.login(event.email, event.password);
      final token = result?['token'];
      final role = result?['role'];
      if (token != null && role != null) {
        emit(AuthSuccess(token: token, role: role));
      } else {
        emit(AuthFailure(errorMessage: 'Invalid login response'));
      }
    } catch (e) {
      print('Login error: $e'); // Log error
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  void _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await authRepository.signup(event.name, event.email, event.password, event.isAdmin);
      final token = result?['token'];
      final role = result?['role'];
      if (token != null && role != null) {
        emit(AuthSuccess(token: token, role: role));
      } else {
        emit(AuthFailure(errorMessage: 'Invalid signup response'));
      }
    } catch (e) {
      print('Signup error: $e'); // Log error
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    try {
      await authRepository.logout(); // Add a logout method to your repository if not already present
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }
}
