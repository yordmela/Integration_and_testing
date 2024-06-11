// lib/infrastructure/admin/repositories/admin_repository_impl.dart
import 'package:flutter_proj_2024/domain/admin/repositories/admin_repository.dart';
import 'package:flutter_proj_2024/domain/room/room.dart';
import 'package:flutter_proj_2024/domain/room/room_repository.dart';

class AdminRepositoryImpl implements AdminRepository {
  final RoomRepository roomRepository;

  AdminRepositoryImpl(this.roomRepository);

  @override
  Future<List<Room>> loadItems() async {
    return await roomRepository.loadRooms();
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
  Future<void> deleteItem(String id) async {
    await roomRepository.deleteRoom(id);
  }
}
