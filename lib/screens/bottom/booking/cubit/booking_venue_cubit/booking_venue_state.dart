abstract class BookingVenueState {}

class BookingVenueInitial extends BookingVenueState {}

class BookingVenueSlots extends BookingVenueState {
  final Map<String, List<String>> allSlots;
  final Map<String, List<String>> disabledSlots;
  final Map<String, List<String>> selectedSlots;


  BookingVenueSlots({
    required this.allSlots,
    required this.disabledSlots,
    required this.selectedSlots,
  });
}
