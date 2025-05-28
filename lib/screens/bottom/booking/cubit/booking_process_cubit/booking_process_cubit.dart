import 'package:flutter_bloc/flutter_bloc.dart';
import 'booking_process_state.dart';

class BookingProcessCubit extends Cubit<BookingProcessState> {
  BookingProcessCubit() : super(BookingProcessInitial());

  static BookingProcessCubit get(context) => BlocProvider.of(context);

  List<Map<String, String>> calender = [];

  int selectedIndex = 0;

  int hour = 2;

  final Map<String, List<String>> allSlots = {};
  final Map<String, List<String>> disabledSlots = {
    "Court 1": [
      "06:00",
      "07:00",
      "10:00",
      "11:00",
      "18:00",
      "19:00",
      "21:00",
      "22:00",
    ],
    "Court 2": ["08:00", "09:00", "13:00", "14:00", "15:00", "20:00", "21:00"],
  };
  final Map<String, List<String>> selectedSlots = {
    "Court 1": [],
    "Court 2": [],
  };

  void initializeDates() {
    calender = generateCalendar();
    initializeSlots();
  }

  void selectDate(int index) {
    selectedIndex = index;
    initializeSlots();
  }

  List<Map<String, String>> generateCalendar() {
    final now = DateTime.now();

    String day(DateTime date) {
      final weekday = date.weekday;
      if (weekday == DateTime.monday) return "Mon";
      if (weekday == DateTime.tuesday) return "Tue";
      if (weekday == DateTime.wednesday) return "Wed";
      if (weekday == DateTime.thursday) return "Thu";
      if (weekday == DateTime.friday) return "Fri";
      if (weekday == DateTime.saturday) return "Sat";
      return "Sun";
    }

    String month(DateTime date) {
      final month = date.month;
      if (month == 1) return "Jan";
      if (month == 2) return "Feb";
      if (month == 3) return "Mar";
      if (month == 4) return "Apr";
      if (month == 5) return "May";
      if (month == 6) return "Jun";
      if (month == 7) return "Jul";
      if (month == 8) return "Aug";
      if (month == 9) return "Sep";
      if (month == 10) return "Oct";
      if (month == 11) return "Nov";
      return "Dec";
    }

    return List.generate(15, (index) {
      final date = now.add(Duration(days: index));
      return {
        "day": day(date),
        "date": date.day.toString().padLeft(2, "0"),
        "month": month(date),
      };
    });
  }

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
      SelectDateAndTime(
        calender: calender,
        selectedIndex: selectedIndex,
        allSlots: allSlots,
        disabledSlots: disabledSlots,
        selectedSlots: selectedSlots,
        hour: hour,
      ),
    );
  }

  void selectSlot(String court, String slot) {
    if (disabledSlots[court]?.contains(slot) == true) return;
    final otherCourt = (court == "Court 1" ? "Court 2" : "Court 1");
    if (selectedSlots[otherCourt]!.isNotEmpty &&
        !selectedSlots[court]!.contains(slot)) {
      return;
    }
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
      SelectDateAndTime(
        calender: calender,
        selectedIndex: selectedIndex,
        allSlots: allSlots,
        disabledSlots: disabledSlots,
        selectedSlots: selectedSlots,
        hour: hour,
      ),
    );
  }

  void incrementHour() {
    if (hour < 12) {
      hour++;
    }
    emit(
      SelectDateAndTime(
        calender: calender,
        selectedIndex: selectedIndex,
        allSlots: allSlots,
        disabledSlots: disabledSlots,
        selectedSlots: selectedSlots,
        hour: hour,
      ),
    );
  }

  void decrementHour() {
    if (hour > 1) {
      hour--;
    }
    emit(
      SelectDateAndTime(
        calender: calender,
        selectedIndex: selectedIndex,
        allSlots: allSlots,
        disabledSlots: disabledSlots,
        selectedSlots: selectedSlots,
        hour: hour,
      ),
    );
  }

  bool validateTimeSelection() {
    int totalSelected = 0;
    for (var slots in selectedSlots.values) {
      totalSelected += slots.length;
    }
    return totalSelected == 2;
  }
}
