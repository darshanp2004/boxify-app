import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'editprofile_screen_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  File? selectedImage;

  EditProfileCubit()
      : super(EditProfileState(username: '', email: '', image: null));

  void updateImage(File image) {
    emit(state.copyWith(image: image));
  }

  Future pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (returnedImage != null) {
      selectedImage = File(returnedImage.path);
      updateImage(selectedImage!);
    }
  }

  void updateDetails({required String username, required String email}) {
    emit(state.copyWith(username: username, email: email));
  }

}
