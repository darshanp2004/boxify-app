import 'package:flutter_bloc/flutter_bloc.dart';

import 'forgot_password_success_state.dart';

class ForgotPasswordSuccessCubit extends Cubit<ForgotPasswordSuccessState> {
  ForgotPasswordSuccessCubit() : super(ForgotPasswordInitial()) ;

  void startTimer() async {
    await Future.delayed(const Duration(seconds: 3));
    emit(ForgotSuccess());
  }
}