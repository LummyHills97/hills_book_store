import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/data/models/cart_item_model.dart';
import 'package:hills_book_store/features/onboarding/presentation/search/book_search_delegate.dart';
import 'package:provider/provider.dart';
import 'package:hills_book_store/features/onboarding/data/books_data.dart';
import 'package:hills_book_store/features/onboarding/data/models/book_model.dart';
import 'package:hills_book_store/features/onboarding/providers/cart_provider.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/book_details_screen.dart';
import 'package:hills_book_store/features/onboarding/widgets/book_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newReleases =
        books.where((b) => b.category == 'Fiction').take(6).toList();
    final trending =
        books.where((b) => b.category == 'Drama').take(6).toList();
    final forYou =
        books.where((b) => b.category == 'Romance').take(6).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildReadingGoalCard(),
                ),
                const SizedBox(height: 28),

                _buildSection(
                  context,
                  title: 'New Releases',
                  subtitle: 'Fresh stories just for you',
                  books: newReleases,
                ),

                _buildSection(
                  context,
                  title: 'Trending Now',
                  subtitle: 'What everyone is reading',
                  books: trending,
                ),

                _buildSection(
                  context,
                  title: 'For You',
                  subtitle: 'Based on your interests',
                  books: forYou,
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- APP BAR ----------------

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.white,
      expandedHeight: 110,
      automaticallyImplyLeading: false,
      flexibleSpace: const FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 16, bottom: 16),
        title: Text(
          'Hi, Olumide 👋',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, size: 26, color: Colors.black87),
          onPressed: () {
            showSearch(
              context: context,
              delegate: BookSearchDelegate(),
            );
          },
        ),
        Consumer<CartProvider>(
          builder: (context, cart, _) {
            return IconButton(
              icon: Stack(
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 26,
                    color: Colors.black87,
                  ),
                  if (cart.itemCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${cart.itemCount}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CartScreen(),
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // ---------------- READING GOAL ----------------

  Widget _buildReadingGoalCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade900, Colors.green.shade700],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '2026 Reading Goal',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 6),
          const Text(
            '12 of 50 books',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: const LinearProgressIndicator(
              value: 0.24,
              backgroundColor: Colors.white24,
              valueColor: AlwaysStoppedAnimation(Colors.white),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- BOOK SECTION ----------------

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<BookModel> books,
  }) {
    if (books.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 240,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final book = books[index];
              return SizedBox(
                width: 140,
                child: BookCard(
                  title: book.title,
                  author: book.author,
                  imagePath: book.imagePath,
                  price: book.price,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookDetailsScreen(
                          title: book.title,
                          author: book.author,
                          imagePath: book.imagePath,
                          price: book.price,
                          description: book.description,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 28),
      ],
    );
  }
}
