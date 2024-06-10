import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_bloc.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_event.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_state.dart';
import 'package:flutter_proj_2024/shared/widgets/text_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: screenSize.width,
              height: screenSize.height * 0.45,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bgc_hotel.jpeg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(300),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Log in',
              style: TextStyle(
                color: Color.fromARGB(255, 95, 65, 65),
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            TextFieldWidget(
              hintText: "Email",
              obscure: false,
              controller: _emailController,
            ),
            const SizedBox(height: 30),
            TextFieldWidget(
              hintText: 'Password',
              obscure: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account? ',
                  style: TextStyle(
                    color: Color.fromARGB(255, 95, 65, 65),
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(
                      color: Color.fromARGB(255, 95, 65, 65),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  print('Navigating based on role: ${state.role}');
                  if (state.role == 'admin') {
                    Navigator.pushNamed(context, '/admin_page');
                  } else if (state.role == 'customer') {
                    Navigator.pushNamed(context, '/booking_page');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('This account doesn\'t exist')),
                    );
                  }
                } else if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login Failed: ${state.errorMessage}')),
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state is AuthLoading
                      ? null
                      : () {
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          context.read<AuthBloc>().add(LoginRequested(email: email, password: password));
                        },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 93, 64, 50),
                    ),
                  ),
                  child: state is AuthLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('L O G I N', style: TextStyle(color: Colors.white)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
