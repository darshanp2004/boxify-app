abstract class BookingVenueState {}

class BookingVenueInitial extends BookingVenueState {}

class BookingSlots extends BookingVenueState {
  final Map<String, List<String>> allSlots;
  final Map<String, List<String>> disabledSlots;
  final Map<String, List<String>> selectedSlots;

  BookingSlots({
    required this.allSlots,
    required this.disabledSlots,
    required this.selectedSlots,
  });
}
