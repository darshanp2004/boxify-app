import 'package:boxify/models/booking_screen_model.dart';

abstract class BookingInfoState {}

class BookingInfoInitial extends BookingInfoState {}

class BookingInfoLoading extends BookingInfoState {}

class BookingInfoLoaded extends BookingInfoState {
  final List<CardModel> bookings;

  BookingInfoLoaded(this.bookings);
}

class BookingInfoError extends BookingInfoState {
  final String message;

  BookingInfoError(this.message);
}
