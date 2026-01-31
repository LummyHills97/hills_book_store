import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hills_book_store/features/onboarding/providers/profile_provider.dart';
import 'package:hills_book_store/features/onboarding/widgets/profile_avatar.dart';
import 'package:hills_book_store/features/onboarding/widgets/profile_form_card.dart';
import 'package:hills_book_store/features/onboarding/widgets/profile_text_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController bioController;
  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileProvider>().profile;
    nameController = TextEditingController(text: profile.name);
    emailController = TextEditingController(text: profile.email);
    phoneController = TextEditingController(text: profile.phone);
    bioController = TextEditingController(text: profile.bio);
    locationController = TextEditingController(text: profile.location);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bioController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: theme.appBarTheme.titleTextStyle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),
              const ProfileAvatar(radius: 60),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Photo upload coming soon!'),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                },
                icon: Icon(Icons.camera_alt, color: theme.colorScheme.primary),
                label: Text(
                  'Change Photo',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              ProfileFormCard(
                children: [
                  ProfileTextField(
                    controller: nameController,
                    label: 'Full Name',
                    icon: Icons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ProfileTextField(
                    controller: emailController,
                    label: 'Email',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ProfileTextField(
                    controller: phoneController,
                    label: 'Phone',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ProfileTextField(
                    controller: locationController,
                    label: 'Location',
                    icon: Icons.location_on,
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<ProfileProvider>().updateProfileField(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            bio: bioController.text,
                            location: locationController.text,
                          );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.white),
                              SizedBox(width: 12),
                              Text('Profile updated successfully'),
                            ],
                          ),
                          backgroundColor: theme.colorScheme.primary,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );

                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}