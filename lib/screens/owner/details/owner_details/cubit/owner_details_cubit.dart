import 'dart:io';
import 'package:boxify/screens/owner/details/court_details/view/court_details_screen.dart';
import 'package:boxify/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'owner_details_state.dart';

class OwnerDetailsCubit extends Cubit<OwnerDetailsState> {
  OwnerDetailsCubit({required String username, required String email})
    : super(OwnerDetailsState()) {
    usernameController.text = username;
    emailController.text = email;
  }

  static OwnerDetailsCubit get(context) => BlocProvider.of(context);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  File? selectedImage;

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return userValidator;
    }
    return null;
  }

  String? validateBusinessName(String? value) {
    if (value == null || value.isEmpty) {
      return businessNameValidator;
    }
    return null;
  }

  String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return emptyMobileNumber;
    }
    return null;
  }

  Future<void> pickImageFromGallery(BuildContext context) async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (returnedImage != null) {
      selectedImage = File(returnedImage.path);
      emit(OwnerDetailsState());
      Navigator.pop(context);
    }
  }

  Future<void> pickImageFromCamera(BuildContext context) async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (returnedImage != null) {
      selectedImage = File(returnedImage.path);
      emit(OwnerDetailsState());
      Navigator.pop(context);
    }
  }

  Future<void> navigateToCourtDetails(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CourtDetailsScreen()),
      );
    }
  }
}
