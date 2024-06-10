import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthApi {
  final String baseUrl;

  AuthApi({required this.baseUrl});

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    print('Login response status: ${response.statusCode}');
    print('Login response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      String token = responseBody['token'];
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return {'token': token, 'role': decodedToken['role']};
    } else {
      throw Exception('Failed to login: ${response.statusCode} - ${response.body}');
    }
  }

  Future<Map<String, dynamic>?> signup(String name, String email, String password, bool isAdmin) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'email': email,
        'password': password,
        'role': isAdmin ? 'admin' : 'customer'
      }),
    );

    print('Signup response status: ${response.statusCode}');
    print('Signup response body: ${response.body}');

    if (response.statusCode == 201) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      String token = responseBody['token'];
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return {'token': token, 'role': decodedToken['role']};
    } else {
      throw Exception('Failed to sign up: ${response.statusCode} - ${response.body}');
    }
  }

  Future<void> logout() async {
    // Implement logout logic if needed (e.g., call an API endpoint to invalidate the session)
    final response = await http.post(
      Uri.parse('$baseUrl/auth/logout'),
      headers: <String, String>{'Content-Type': 'application/json'},
    );

    print('Logout response status: ${response.statusCode}');
    print('Logout response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to logout: ${response.statusCode} - ${response.body}');
    }
  }
}
