import 'package:boxify/screens/payment/cubit/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentProcessInitial());

  static PaymentCubit get(context) => BlocProvider.of(context);

  void loadPaymentDetails({
    required String court,
    required String timeSlot,
    required String date,
  }) {
    try {
      emit(
        PaymentProcessLoaded(
          court: court,
          timeSlot: timeSlot,
          date: date,
          isSelected: true,
        ),
      );
    } catch (e) {
      emit(PaymentProcessError("Failed to load payment details."));
    }
  }
  void toggleCheckbox(bool value) {
    final loaded = state as PaymentProcessLoaded;
    emit(loaded.copyWith(isSelected: value));
  }
}
