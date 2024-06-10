import 'package:flutter_proj_2024/domain/room/room.dart';

abstract class AdminRepository {
  Future<List<Room>> loadItems();
  Future<void> addItem(Room room);
  Future<void> updateItem(Room room);
  Future<void> deleteItem(String roomId);
}
