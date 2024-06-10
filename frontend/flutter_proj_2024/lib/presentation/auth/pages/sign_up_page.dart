import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_bloc.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_event.dart';
import 'package:flutter_proj_2024/application/auth/bloc/auth_state.dart';
import 'package:flutter_proj_2024/shared/widgets/text_field_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  List<bool> _isSelected = [true, false];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
              height: screenSize.height * 0.325,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bgc_hotel.jpeg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(400),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Sign Up',
              style: TextStyle(
                color: Color.fromARGB(255, 95, 65, 65),
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ToggleButtons(
                isSelected: _isSelected,
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0; buttonIndex < _isSelected.length; buttonIndex++) {
                      _isSelected[buttonIndex] = buttonIndex == index;
                    }
                  });
                },
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('ADMIN'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('User'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextFieldWidget(hintText: "Full Name", obscure: false, controller: _nameController),
            const SizedBox(height: 20),
            TextFieldWidget(hintText: "Email", obscure: false, controller: _emailController),
            const SizedBox(height: 20),
            TextFieldWidget(hintText: "Password", obscure: true, controller: _passwordController),
            const SizedBox(height: 20),
            TextFieldWidget(hintText: "Confirm Password", obscure: true, controller: _confirmPasswordController),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an Account?',
                  style: TextStyle(
                    color: Color.fromARGB(255, 95, 65, 65),
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    'LOG IN',
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
            const SizedBox(height: 20),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                print('AuthState: $state'); // Debug print statement
                if (state is AuthSuccess) {
                  print('Navigating to login'); // Add this print statement
                  Navigator.pushNamed(context, '/login'); // Navigate to the login page
                } else if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sign Up Failed: ${state.errorMessage}')),
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state is AuthLoading
                      ? null
                      : () {
                          final name = _nameController.text;
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          final confirmPassword = _confirmPasswordController.text;

                          if (password != confirmPassword) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Passwords do not match')),
                            );
                            return;
                          }

                          final isAdmin = _isSelected[0];
                          context.read<AuthBloc>().add(SignUpRequested(name: name, email: email, password: password, isAdmin: isAdmin));
                        },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 93, 64, 50),
                    ),
                  ),
                  child: state is AuthLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('SIGN UP', style: TextStyle(color: Colors.white)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
