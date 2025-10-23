import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/widgets/onboarding_page.dart';
import 'package:hills_book_store/features/onboarding/widgets/onboarding_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> pages = [
      {
        "image": "assets/images/onboarding/onboarding0.png",
        "title": "Discover Great Books",
        "description":
            "Explore our collection of the best educational and inspirational titles.",
      },
      {
        "image": "assets/images/onboarding/onboarding2.png",
        "title": "Order with Ease",
        "description": "Shop your favorite books in just a few taps.",
      },
      {
        "image": "assets/images/onboarding/onboarding3.png",
        "title": "Learn Anytime, Anywhere",
        "description": "Enjoy reading on the go with digital and physical copies.",
      },
      {
        "subtitle": "Welcome",
        "image": "assets/images/onboarding/onboarding4.png",
        "title": "Join the Hills Community",
        "description": "Login or create an account to start your journey.",
      },
    ];

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 👇 PageView for onboarding pages
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                final item = pages[index];
                return OnboardingPage(
                  image: item['image']!,
                  title: item['title']!,
                  description: item['description']!,
                  subtitle: item['subtitle'],
                );
              },
            ),
          ),

          // 👇 Dots Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pages.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? Colors.green.shade900
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

                 // 👇 Buttons section
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
  child: Column(
    children: [
      if (_currentPage < pages.length - 1)
        OnboardingButton(
          text: _currentPage == 0 ? "Get Started" : "Next",
          onPressed: _nextPage,
          backgroundColor: Colors.green.shade900,
          textColor: Colors.white,
        ),
      if (_currentPage == pages.length - 1) ...[
        OnboardingButton(
          text: "Login",
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          backgroundColor: Colors.white,
          textColor: Colors.green.shade900,
        ),
        const SizedBox(height: 12),
        OnboardingButton(
          text: "Create Account",
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          backgroundColor: Colors.green.shade900,
          textColor: Colors.white,
        ),
      ],
    ],
  ),
),

        ],
      ),
    );
  }
}
