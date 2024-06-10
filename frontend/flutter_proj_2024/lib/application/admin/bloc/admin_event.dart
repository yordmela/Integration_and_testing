import 'package:flutter_proj_2024/domain/room/room.dart';

abstract class AdminEvent {}

class LoadItemsEvent extends AdminEvent {}

class AddItemEvent extends AdminEvent {
  final Room room;
  AddItemEvent(this.room);
}

class UpdateItemEvent extends AdminEvent {
  final Room room;
  UpdateItemEvent(this.room);
}

class DeleteItemEvent extends AdminEvent {
  final String roomId;
  DeleteItemEvent(this.roomId);
}
