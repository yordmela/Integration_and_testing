import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_bloc.dart';
import 'package:flutter_proj_2024/infrastructure/auth/data_sources/auth_api.dart';
import 'package:flutter_proj_2024/infrastructure/auth/repositories/auth_repository_impl.dart';
import 'package:flutter_proj_2024/presentation/admin/pages/admin_page.dart';
import 'package:flutter_proj_2024/presentation/auth/pages/log_in_page.dart';
import 'package:flutter_proj_2024/presentation/auth/pages/sign_up_page.dart';
import 'package:flutter_proj_2024/presentation/booking/pages/booking_page.dart';

void main() {
  final authApi = AuthApi(baseUrl: 'http://localhost:3000');
  final authRepository = AuthRepositoryImpl(authApi: authApi);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepositoryImpl>(
          create: (context) => authRepository,
        ),
      ],
      child: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(authRepository: authRepository),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SignUpPage(),
        '/login': (context) => const LoginPage(),
        '/booking_page': (context) => BookingPage(),
        '/admin_page': (context) => AdminPage(),
      },
      initialRoute: '/',
    );
  }
}
