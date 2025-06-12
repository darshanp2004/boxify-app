class SignInState {
  final String email;
  final String password;
  final bool isLoading;
  final String? errorMessage;

  const SignInState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.errorMessage,
  });

  SignInState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
