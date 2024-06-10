import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/shared/widgets/appbar.dart';
import 'package:flutter_proj_2024/shared/widgets/drawer.dart';
import 'package:flutter_proj_2024/domain/booking/entities/booking.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_bloc.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_event.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_state.dart';
import 'package:flutter_proj_2024/infrastructure/booking/data_sources/booking_local_data_source.dart';
import 'package:flutter_proj_2024/infrastructure/booking/repositories/booking_repository_impl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class BookingPage extends StatelessWidget {
  BookingPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Deluxe Room',
      'images': ['lib/assets/images/vip1.jpeg', 'lib/assets/images/vip2.jpeg'],
      'descriptions': ['A luxurious room with a great view.', 'Spacious and comfortable.'],
      'prices': [120, 150]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final db = mongo.Db('mongodb://your_mongo_db_url');
    final bookingCollection = db.collection('bookings');
    final bookingLocalDataSource = BookingLocalDataSource(bookingCollection);
    final bookingRepository = BookingRepositoryImpl(bookingLocalDataSource);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      appBar: AppAppBar(),
      drawer: AppDrawer(),
      body: BlocProvider(
        create: (context) => BookingBloc(bookingRepository)..add(LoadBookingsEvent()),
        child: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state is BookingLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BookingLoaded) {
              return ListView.builder(
                itemCount: state.bookings.length,
                itemBuilder: (context, index) {
                  final booking = state.bookings[index];
                  return ListTile(
                    title: Text(booking.roomName),
                    subtitle: Text('Date: ${booking.bookingDate}'),
                  );
                },
              );
            } else if (state is BookingError) {
              return Center(child: Text('Failed to load bookings: ${state.errorMessage}'));
            }
            return Center(child: Text('No bookings found.'));
          },
        ),
      ),
    );
  }
}
