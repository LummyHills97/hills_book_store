class UserProfile {
  final String name;
  final String email;
  final String phone;
  final String bio;
  final String imagePath;
  final String location;
  final DateTime joinedDate;

  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.bio,
    required this.imagePath,
    required this.location,
    required this.joinedDate,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? bio,
    String? imagePath,
    String? location,
    DateTime? joinedDate,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      imagePath: imagePath ?? this.imagePath,
      location: location ?? this.location,
      joinedDate: joinedDate ?? this.joinedDate,
    );
  }
}
