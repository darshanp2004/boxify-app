class SignUpState {
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;

  const SignUpState({
    this.userName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
  });

  SignUpState copyWith({
    String? userName,
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return SignUpState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}
