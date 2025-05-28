abstract class PaymentState {}

class PaymentProcessInitial extends PaymentState {}

class PaymentProcessLoaded extends PaymentState {
  final String court;
  final String timeSlot;
  final String date;
  final bool isSelected;


  PaymentProcessLoaded({
    required this.court,
    required this.timeSlot,
    required this.date,
    required this.isSelected
  });

  PaymentProcessLoaded copyWith({
    String? court,
    String? timeSlot,
    String? date,
    bool? isSelected,
  }) {
    return PaymentProcessLoaded(
      court: court ?? this.court,
      timeSlot: timeSlot ?? this.timeSlot,
      date: date ?? this.date,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class PaymentProcessError extends PaymentState {
  final String message;

  PaymentProcessError(this.message);
}