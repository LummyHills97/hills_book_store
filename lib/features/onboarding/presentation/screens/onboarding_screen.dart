import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hills_book_store/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:hills_book_store/features/onboarding/widgets/onboarding_page.dart';
import '../../logic/onboarding_cubit.dart';


class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController _controller = PageController();

  final List<Map<String, String>> _data = [
    {
      "image": "assets/images/onboarding/onboarding1.png",
      "title": "Discover Great Books",
      "description": "Explore our collection of the best educational and inspirational titles."
    },
    {
      "image": "assets/images/onboarding/onboarding2.png",
      "title": "Order with Ease",
      "description": "Shop your favorite books in just a few taps."
    },
    {
      "image": "assets/images/onboarding/onboarding3.png",
      "title": "Learn Anytime, Anywhere",
      "description": "Enjoy reading on the go with digital and physical copies."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _data.length,
                  onPageChanged: (index) =>
                      context.read<OnboardingCubit>().nextPage(index),
                  itemBuilder: (_, index) {
                    final item = _data[index];
                    return OnboardingPage(
                      image: item["image"]!,
                      title: item["title"]!,
                      description: item["description"]!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
