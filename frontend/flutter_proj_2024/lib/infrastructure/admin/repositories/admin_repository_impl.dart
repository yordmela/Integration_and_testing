// lib/infrastructure/admin/repositories/admin_repository_impl.dart
import 'package:flutter_proj_2024/domain/admin/repositories/admin_repository.dart';
import 'package:flutter_proj_2024/domain/room/room_repository.dart';
import 'package:flutter_proj_2024/domain/room/room.dart';

class AdminRepositoryImpl implements AdminRepository {
  final RoomRepository roomRepository;

  AdminRepositoryImpl(this.roomRepository);

  @override
  Future<List<Room>> loadItems() async {
    List<Map<String, dynamic>> roomMaps = await roomRepository.loadRooms();
    List<Room> rooms = roomMaps.map((roomMap) => Room.fromJson(roomMap)).toList();
    return rooms;
  }

  @override
  Future<void> addItem(Room room) async {
    await roomRepository.addRoom(room);
  }

  @override
  Future<void> updateItem(Room room) async {
    await roomRepository.updateRoom(room);
  }

  @override
  Future<void> deleteItem(String roomId) async {
    await roomRepository.deleteRoom(roomId);
  }
}
