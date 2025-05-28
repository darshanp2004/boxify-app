import 'dart:io';

class EditProfileState{
  final String username;
  final String email;
  final File? image;
  final String gender;
  final DateTime? birthDate;


  EditProfileState({
    required this.username,
    required this.email,
    this.image,
    required this.gender,
    this.birthDate
  });

  EditProfileState copyWith({
    String? username,
    String? email,
    File? image,
    String? gender,
    DateTime? birthDate,

  }) {
    return EditProfileState(
      username: username ?? this.username,
      email: email ?? this.email,
      image: image ?? this.image,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
    );
  }
}
