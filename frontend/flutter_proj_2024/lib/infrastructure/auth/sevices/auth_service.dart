import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
// import 'package:crypto/crypto.dart';
import 'package:bcrypt/bcrypt.dart';
import 'dart:convert';

class AuthService {
  final mongo.DbCollection userCollection;
  final String jwtSecret;

  AuthService(this.userCollection, this.jwtSecret);

  Future<Map<String, String>> signUp(Map<String, String> signUpDto) async {
    final name = signUpDto['name'];
    final email = signUpDto['email'];
    final password = signUpDto['password'];
    final role = signUpDto['role'];

    final hashedPassword = BCrypt.hashpw(password!, BCrypt.gensalt());

    final user = {
      'name': name,
      'email': email,
      'password': hashedPassword,
      'role': role,
    };

    await userCollection.insert(user);

    final id = user['_id'];
    
      final token = JWT(
      {
        'id': id,
        'role': user['role'],
        'name': user['name'],
      },
    ).sign(SecretKey(jwtSecret));

    return {'token': token};
  } 

  Future<Map<String, dynamic>?> login(Map<String, String> loginDto) async {
    final email = loginDto['email'];
    final password = loginDto['password'];

    
    if (email == null || password == null) {
      throw Exception('Email or password is null.');
    }


    final user = await userCollection.findOne(mongo.where.eq('email', email));
    if (user == null) {
      return null; 
    }

    final isPasswordMatched = BCrypt.checkpw(password, user['password']);
    if (!isPasswordMatched) {
      throw Exception('Invalid email or password.');
    }

    final token = JWT(
      {
        'id': user['_id'].toHexString(),
        'role': user['role'],
        'name': user['name'],
      },
    ).sign(SecretKey(jwtSecret));

    return {'token': token};
  }

  Future<bool> isAuthenticated(String? token) async {
    if (token == null){
      return false;
    }
  try {
    final parts = token.split('.');
    if (parts.length != 3) {
      return false;
    }

    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final decoded = utf8.decode(base64Url.decode(normalized));
    final decodedToken = json.decode(decoded);

    final expiry = decodedToken['exp'] as int;
    final currentTimeInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return expiry > currentTimeInSeconds;
  } catch (e) {
    return false;
  }
}
   Future<Map<String, dynamic>> getCurrentUser(String token) async {
    try {
      final parts = token.split('.');
      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final decodedToken = json.decode(decoded);
      final userId = decodedToken['id'];
      final user = await userCollection.findOne(mongo.where.eq('_id', mongo.ObjectId.parse(userId)));
      if (user != null) {
        return user;
      } else {
        throw Exception('User not found.');
      }
    } catch (e) {
      throw Exception('Error retrieving user: ${e.toString()}');
    }
  } 
   Future<void> signOut() async {
    // Implement sign out logic if necessary, e.g., remove token from storage
  }

  Future<String?> getToken() async {
    // Implement logic to retrieve token from storage
    return null;
  }
} 
