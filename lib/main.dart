import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hills_book_store/core/theme/theme.dart';
import 'package:hills_book_store/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/explore_page.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/forgot_password_screen.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/login_screen.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/main_navigation_screen';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';

void main() {
  runApp(const HillsBookStore());
}

class HillsBookStore extends StatelessWidget {
  const HillsBookStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OnboardingCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hills Book Store',
        
        // ✅ Use your custom theme
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system, // Auto switch based on system setting
        
        initialRoute: '/',
        routes: {
          '/': (context) => const OnboardingScreen(),
          '/login': (context) => const LoginScreen(),
          '/forgot-password': (context) => const ForgotPasswordScreen(),
          '/home': (context) => const MainNavigationScreen(), // ✅ Main navigation with all 4 tabs
          '/explore': (context) => const ExplorePage(),
        },
      ),
    );
  }
}