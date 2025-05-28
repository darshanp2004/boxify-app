import 'package:boxify/screens/password/change_password/view/change_password_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'change_password_state.dart';


class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordState());

  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void submitChangePassword(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ChangePasswordSuccess()),
    );
  }
}
