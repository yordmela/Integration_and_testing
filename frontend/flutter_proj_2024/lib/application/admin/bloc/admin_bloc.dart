import 'package:flutter_bloc/flutter_bloc.dart';
import 'admin_event.dart';
import 'admin_state.dart';
import 'package:flutter_proj_2024/domain/admin/repositories/admin_repository.dart';
import 'package:flutter_proj_2024/domain/room/room.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository adminRepository;

  AdminBloc(this.adminRepository) : super(AdminInitial()) {
    on<LoadItemsEvent>((event, emit) async {
      emit(AdminLoading());
      try {
        final rooms = await adminRepository.loadItems();
        emit(AdminLoaded(rooms));
      } catch (e) {
        emit(AdminError(e.toString()));
      }
    });

    on<AddItemEvent>((event, emit) async {
      emit(AdminLoading());
      try {
        await adminRepository.addItem(event.room);
        emit(ItemAdded());
        add(LoadItemsEvent()); // Refresh the items list
      } catch (e) {
        emit(AdminError(e.toString()));
      }
    });

    on<UpdateItemEvent>((event, emit) async {
      emit(AdminLoading());
      try {
        await adminRepository.updateItem(event.room);
        emit(ItemUpdated());
        add(LoadItemsEvent()); // Refresh the items list
      } catch (e) {
        emit(AdminError(e.toString()));
      }
    });

    on<DeleteItemEvent>((event, emit) async {
      emit(AdminLoading());
      try {
        await adminRepository.deleteItem(event.roomId);
        emit(ItemDeleted());
        add(LoadItemsEvent()); // Refresh the items list
      } catch (e) {
        emit(AdminError(e.toString()));
      }
    });
  }
}
