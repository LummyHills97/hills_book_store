import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/Providers/cart_provider.dart';
import 'package:hills_book_store/features/onboarding/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/main_navigation_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hills Book Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const MainNavigationScreen(),
    );
  }
}