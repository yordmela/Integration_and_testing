import 'package:flutter_proj_2024/domain/room/room.dart';

abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminLoaded extends AdminState {
  final List<Room> rooms;
  AdminLoaded(this.rooms);
}

class AdminError extends AdminState {
  final String message;
  AdminError(this.message);
}

class ItemAdded extends AdminState {}

class ItemUpdated extends AdminState {}

class ItemDeleted extends AdminState {}
