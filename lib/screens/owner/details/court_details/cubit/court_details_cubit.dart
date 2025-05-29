import 'dart:io';

import 'package:boxify/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'court_details_state.dart';

class CourtDetailsCubit extends Cubit<CourtDetailsState> {
  CourtDetailsCubit() : super(CourtDetailsState());

  static CourtDetailsCubit get(context) => BlocProvider.of(context);

  final TextEditingController turfNameController = TextEditingController();
  final TextEditingController courtNameController = TextEditingController();
  final TextEditingController courtTypeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final List<File?> selectedImages = [null, null, null];
  final formKey = GlobalKey<FormState>();

  Future<void> pickImageFromGallery(int index) async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (returnedImage != null) {
      selectedImages[index] = File(returnedImage.path);
      emit(CourtDetailsState());
    }
  }

  Future<void> pickImageFromCamera(int index) async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (returnedImage != null) {
      selectedImages[index] = File(returnedImage.path);
      emit(CourtDetailsState());
    }
  }

  String? validateTurfName(String? value) {
    if (value == null || value.isEmpty) {
      return turfNameValidator;
    }
    return null;
  }

  String? validateCourtName(String? value) {
    if (value == null || value.isEmpty) {
      return courtNameValidator;
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return addressValidator;
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return descriptionValidator;
    }
    return null;
  }

  Future<void> validateInputs(BuildContext context) async {
    if (formKey.currentState!.validate()) {
    }
  }
}
