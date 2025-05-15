import 'package:boxify/Utils/image_resources.dart';
import 'package:boxify/models/booking_screen_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'booking_info_state.dart';

class BookingInfoCubit extends Cubit<BookingInfoState> {
  BookingInfoCubit() : super(BookingInfoInitial());

  void loadBookings() async {
    emit(BookingInfoLoading());

    await Future.delayed(Duration(seconds: 1));

    final bookings = [
      CardModel(
        title: "Urban Box Cricket",
        date: "Saturday, 3rd February",
        time: "07:00 pm to 09:00 pm",
        court: "Court 1",
        image: boxCricket,
      ),
    ];

    emit(BookingInfoLoaded(bookings));
  }
}
