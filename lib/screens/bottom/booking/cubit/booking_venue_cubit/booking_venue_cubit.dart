import 'package:boxify/utils/image_resources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'booking_venue_state.dart';

class BookingVenueCubit extends Cubit<BookingVenueState> {
  BookingVenueCubit() : super(BookingVenueInitial()) ;

  static BookingVenueCubit get(context) => BlocProvider.of(context);

  final List<Map<String, String>> amenitiesList = [
    {"icon": parkingIcon, "label": "Parking"},
    {"icon": restRoomIcon, "label": "Restroom"},
    {"icon": changingRoomIcon, "label": "Changing\n  Room"},
    {"icon": cafeIcon, "label": "Cafe"},
    {"icon": accessibilityIcon, "label": "Accessibility"},
  ];

  final Map<String, List<String>> allSlots = {};

  final Map<String, List<String>> disabledSlots = {
    "Court 1": ["06:00", "07:00", "10:00", "15:00", "16:00", "19:00","21:00","22:00"],
    "Court 2": ["08:00", "12:00", "13:00", "15:00", "19:00"],
  };

  final Map<String, List<String>> selectedSlots = {
    "Court 1": [],
    "Court 2": [],
  };

  void initializeSlots() {
    final currentHour = DateTime.now().hour;
    final totalHours = 25 - currentHour;

    List<String> slots = List.generate(totalHours, (index) {
      int hour = currentHour + index;
      return '${hour.toString().padLeft(2, "0")}:00';
    });

    allSlots["Court 1"] = List.from(slots);
    allSlots["Court 2"] = List.from(slots);

    emit(
      BookingSlots(
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
      BookingSlots(
        allSlots: allSlots,
        disabledSlots: disabledSlots,
        selectedSlots: selectedSlots,
      ),
    );
  }
}
