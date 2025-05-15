class ProfileState {
  final bool locationEnabled;
  final bool notificationsEnabled;

  ProfileState({
    required this.locationEnabled,
    required this.notificationsEnabled,
  });

  ProfileState copyWith({
    bool? locationEnabled,
    bool? notificationsEnabled,
  }) {
    return ProfileState(
      locationEnabled: locationEnabled ?? this.locationEnabled,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}

