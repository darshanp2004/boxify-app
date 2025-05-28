import 'package:boxify/screens/password/change_password/cubit/change_password_success_cubit/change_password_success_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChangePasswordSuccessCubit extends Cubit<ChangePasswordSuccessState> {
  ChangePasswordSuccessCubit() : super(ChangePasswordInitial()) ;

  void startTimer() async {
    await Future.delayed(const Duration(seconds: 3));
    emit(ChangePasswordSuccess());
  }
}