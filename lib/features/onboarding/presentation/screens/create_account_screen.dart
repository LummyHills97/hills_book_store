import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/individual_registration_screen.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/school_registration_screen.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image with color filter for dark mode
              ColorFiltered(
                colorFilter: isDark
                    ? const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      )
                    : const ColorFilter.mode(
                        Colors.transparent,
                        BlendMode.dst,
                      ),
                child: Image.asset(
                  "assets/images/onboarding/onboarding0.png",
                  height: 120,
                  color: isDark ? colorScheme.primary : null,
                  colorBlendMode: isDark ? BlendMode.srcIn : null,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Create Account",
                style: theme.textTheme.displayMedium,
              ),
              const SizedBox(height: 12),
              Text(
                "Register as a school or individual to start shopping.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: isDark 
                      ? theme.textTheme.bodyMedium?.color 
                      : theme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 50),
              
              // School Registration Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SchoolRegistrationScreen(),
                      ),
                    );
                  },
                  child: const Text("Register as School"),
                ),
              ),
              const SizedBox(height: 16),
              
              // Individual Registration Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const IndividualRegistrationScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: colorScheme.primary, width: 2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Register as Individual",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}