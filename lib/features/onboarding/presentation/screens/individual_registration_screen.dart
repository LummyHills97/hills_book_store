import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/success_screen.dart';

class IndividualRegistrationScreen extends StatelessWidget {
  const IndividualRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Individual Registration")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Image.asset("assets/images/onboarding/onboarding0.png", height: 100),
            const SizedBox(height: 20),
            const TextField(decoration: InputDecoration(labelText: "Full Name")),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: "Email")),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: "Phone Number")),
            const SizedBox(height: 12),
            const TextField(obscureText: true, decoration: InputDecoration(labelText: "Password")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SuccessScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade900,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 55),
              ),
              child: const Text("Create Account"),
            ),
          ],
        ),
      ),
    );
  }
}
