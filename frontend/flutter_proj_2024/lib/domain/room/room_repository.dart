import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_proj_2024/domain/room/room.dart';

class RoomRepository {
  final String apiUrl = 'http://localhost:3000/room';

  Future<List<Map<String, dynamic>>> loadRooms() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  Future<void> addRoom(Room room) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(room.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add room');
    }
  }

  Future<void> updateRoom(Room room) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${room.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(room.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update room');
    }
  }

  Future<void> deleteRoom(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete room');
    }
  }
}
