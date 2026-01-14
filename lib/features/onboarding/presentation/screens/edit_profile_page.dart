import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/widgets/profile_avatar.dart';
import 'package:hills_book_store/features/onboarding/widgets/profile_form_card.dart';
import 'package:hills_book_store/features/onboarding/widgets/profile_text_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const ProfileAvatar(radius: 60),
            const SizedBox(height: 40),

            ProfileFormCard(
              children: [
                ProfileTextField(
                  controller: nameController,
                  label: 'Full Name',
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),
                ProfileTextField(
                  controller: emailController,
                  label: 'Email',
                  icon: Icons.email,
                ),
                const SizedBox(height: 20),
                ProfileTextField(
                  controller: phoneController,
                  label: 'Phone',
                  icon: Icons.phone,
                ),
                const SizedBox(height: 20),
                ProfileTextField(
                  controller: bioController,
                  label: 'Bio',
                  icon: Icons.info,
                  maxLines: 3,
                ),
              ],
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5E5CE6),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
