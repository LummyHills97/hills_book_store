import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final double radius;

  const ProfileAvatar({
    super.key,
    this.radius = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: radius * 2,
          height: radius * 2,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xFF5E5CE6),
                Color(0xFF8E8DFF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: const CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/covers/hills.jpg',
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 4,
          right: 4,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFF5E5CE6),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.camera_alt,
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
