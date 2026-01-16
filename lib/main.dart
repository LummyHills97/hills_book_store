import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/main_navigation.dart';
import 'package:provider/provider.dart';

import 'package:hills_book_store/features/onboarding/providers/profile_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hills Book Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5E5CE6),
        ),
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
}