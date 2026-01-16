import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:hills_book_store/features/onboarding/providers/profile_provider.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/home_screen.dart';

// Import your blocs here
// import 'package:hills_book_store/features/auth/bloc/auth_bloc.dart';
// import 'package:hills_book_store/features/cart/bloc/cart_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// ----------------------------
        /// Provider (ChangeNotifier)
        /// ----------------------------
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
      ],

      /// Bloc providers should be INSIDE MultiProvider
      child: MultiBlocProvider(
        providers: [
          /// ----------------------------
          /// Bloc Providers
          /// (Add at least one, never empty)
          /// ----------------------------

          // BlocProvider(
          //   create: (_) => AuthBloc(),
          // ),

          // BlocProvider(
          //   create: (_) => CartBloc(),
          // ),
        ],

        child: const AppView(),
      ),
    );
  }
}

/// Separate widget keeps main.dart clean
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
      home: const HomeScreen(),
    );
  }
}
