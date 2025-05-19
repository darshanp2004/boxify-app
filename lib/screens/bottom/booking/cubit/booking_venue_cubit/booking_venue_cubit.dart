import 'package:flutter_bloc/flutter_bloc.dart';

import 'booking_venue_state.dart';

class BookingVenueCubit extends Cubit<BookingVenueState> {
  BookingVenueCubit() : super(BookingVenueInitial());

  static BookingVenueCubit get(context) => BlocProvider.of(context);

  final Map<String, List<String>> allSlots = {
    'Court 1': [
      '06:00',
      '07:00',
      '08:00',
      '09:00',
      '10:00',
      '11:00',
      '12:00',
      '13:00',
      '14:00',
      '15:00',
      '16:00',
      '17:00',
      '18:00',
      '19:00',
      '20:00',
      '21:00',
      '22:00',
      '23:00',
    ],
    'Court 2': [
      '06:00',
      '07:00',
      '08:00',
      '09:00',
      '10:00',
      '11:00',
      '12:00',
      '13:00',
      '14:00',
      '15:00',
      '16:00',
      '17:00',
      '18:00',
      '19:00',
      '20:00',
      '21:00',
      '22:00',
      '23:00',
    ],
  };

  final Map<String, List<String>> disabledSlots = {
    'Court 1': ['06:00', '07:00', '10:00', '15:00', '16:00', '19:00'],
    'Court 2': ['08:00', '12:00', '13:00', '15:00', '19:00'],
  };

  final Map<String, List<String>> selectedSlots = {
    'Court 1': [],
    'Court 2': [],
  };

  void loadSlots() {
    emit(
      BookingVenueSlots(
        allSlots: allSlots,
        disabledSlots: disabledSlots,
        selectedSlots: selectedSlots,
      ),
    );
  }

  void selectSlot(String court, String slot) {
    if (disabledSlots[court]?.contains(slot) == true) return;
    List<String> selected = selectedSlots[court] ?? [];
    if (selected.contains(slot)) {
      selected.remove(slot);
    } else {
      if (selected.length < 2) {
        selected.add(slot);
      } else {
        selected = [slot];
      }
    }
    selectedSlots[court] = selected;
    emit(
      BookingVenueSlots(
        allSlots: allSlots,
        disabledSlots: disabledSlots,
        selectedSlots: selectedSlots,
      ),
    );
  }
}
