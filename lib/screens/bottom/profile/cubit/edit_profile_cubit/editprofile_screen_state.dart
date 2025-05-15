import 'dart:io';

class EditProfileState{
  final String username;
  final String email;
  final File? image;

  EditProfileState({
    required this.username,
    required this.email,
    this.image,
  });

  EditProfileState copyWith({
    String? username,
    String? email,
    File? image,
  }) {
    return EditProfileState(
      username: username ?? this.username,
      email: email ?? this.email,
      image: image ?? this.image,
    );
  }
}
