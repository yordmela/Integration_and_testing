import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_proj_2024/domain/room/room.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomRepository {
  final String apiUrl = 'http://localhost:3000/room';

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<List<Room>> loadRooms() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Room.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  Future<void> addRoom(Room room) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(room.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add room');
    }
  }

  Future<void> updateRoom(Room room) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse('$apiUrl/${room.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(room.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update room');
    }
  }

  Future<void> deleteRoom(String id) async {
    final token = await _getToken();
    final response = await http.delete(
      Uri.parse('$apiUrl/$id'),
      headers: {
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete room');
    }
  }
}
