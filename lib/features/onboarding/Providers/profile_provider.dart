import 'package:flutter/material.dart';

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

class ProfileProvider extends ChangeNotifier {
  UserProfile _profile = UserProfile(
    name: 'Akinnuli Olumide',
    email: 'olumide@hillsbooks.com',
    phone: '+234 801 234 5678',
    bio: 'Passionate reader and book collector. Love exploring different genres and sharing book recommendations.',
    imagePath: 'assets/images/profile.jpg',
    location: 'Lagos, Nigeria',
    joinedDate: DateTime(2023, 6, 15),
  );

  UserProfile get profile => _profile;

  void updateProfile(UserProfile newProfile) {
    _profile = newProfile;
    notifyListeners();
  }

  void updateProfileField({
    String? name,
    String? email,
    String? phone,
    String? bio,
    String? imagePath,
    String? location,
  }) {
    _profile = _profile.copyWith(
      name: name,
      email: email,
      phone: phone,
      bio: bio,
      imagePath: imagePath,
      location: location,
    );
    notifyListeners();
  }
}
