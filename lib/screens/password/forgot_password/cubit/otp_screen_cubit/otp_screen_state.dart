class OtpScreenState {
  final List<String> otpDigits;

  OtpScreenState({required this.otpDigits});

  OtpScreenState copyWith({List<String>? otpDigits}) {
    return OtpScreenState(
      otpDigits: otpDigits ?? this.otpDigits,
    );
  }
}
