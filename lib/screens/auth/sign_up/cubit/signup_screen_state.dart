class SignUpState {
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isLoading;
  final String? errorMessage;

  const SignUpState({
    this.userName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isLoading = false,
    this.errorMessage,
  });

  SignUpState copyWith({
    String? userName,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SignUpState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
