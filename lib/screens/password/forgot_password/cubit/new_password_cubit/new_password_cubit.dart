import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'new_password_state.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {
  NewPasswordCubit() : super(NewPasswordState());

  static NewPasswordCubit get(context) => BlocProvider.of(context);

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

}
