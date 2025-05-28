abstract class BookingProcessState {}

class BookingProcessInitial extends BookingProcessState {}

class BookingProcessLoading extends BookingProcessState {}

class SelectDateAndTime extends BookingProcessState {
  final List<Map<String, String>> calender;
  final int selectedIndex;
  final Map<String, List<String>> allSlots;
  final Map<String, List<String>> disabledSlots;
  final Map<String, List<String>> selectedSlots;
  final int hour;

  SelectDateAndTime({
    required this.calender,
    required this.selectedIndex,
    required this.allSlots,
    required this.disabledSlots,
    required this.selectedSlots,
    required this.hour
  });
}