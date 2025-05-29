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
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  EditProfileCubit()
      : super(EditProfileState(username: '', email: '', image: null,gender: ''));

  static EditProfileCubit get(context) => BlocProvider.of(context);

  void updateImage(File image) {
    emit(state.copyWith(image: image));
  }

  Future pickImageFromGallery(BuildContext context) async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (returnedImage != null) {
      selectedImage = File(returnedImage.path);
      updateImage(selectedImage!);
      Navigator.pop(context);
    }
  }


  Future pickImageFromCamera(BuildContext context) async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (returnedImage != null) {
      selectedImage = File(returnedImage.path);
      updateImage(selectedImage!);
      Navigator.pop(context);
    }
  }

  void updateDetails({required String username, required String email}) {
    emit(state.copyWith(username: username, email: email));
  }

  void updateGender(String gender) {
    emit(state.copyWith(gender: gender));
  }

  void updateBirthDate(DateTime date) {
    emit(state.copyWith(birthDate: date));
  }

}
