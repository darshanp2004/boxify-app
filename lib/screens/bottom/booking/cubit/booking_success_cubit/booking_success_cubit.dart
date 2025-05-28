import 'package:boxify/screens/bottom/bottom_navigation/view/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'booking_success_state.dart';

class BookingSuccessCubit extends Cubit<BookingSuccessState> {
  BookingSuccessCubit() : super(BookingSuccessState());

  static BookingSuccessCubit get(context) => BlocProvider.of(context);

  void navigateToBookings(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavigationScreen(),
      ),
    );
  }
}
