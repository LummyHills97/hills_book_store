import 'package:flutter/material.dart';
import 'package:hills_book_store/features/onboarding/data/books_data.dart';
import 'package:hills_book_store/features/onboarding/data/models/book_model.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/book_details_screen.dart';
import 'package:hills_book_store/features/onboarding/widgets/book_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Show all books without filtering
    final recommendation = books.take(3).toList();
    final popular = books.skip(3).take(3).toList();
    final topSell = books.skip(6).take(3).toList();

    return Scaffold(
      backgroundColor: Colors.white,

      /// ✅ TOP APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Hi, Olumide 👋',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),

      /// ✅ MAIN CONTENT
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            /// RECOMMENDATION
            if (recommendation.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _sectionTitle("Recommendation"),
              ),
              const SizedBox(height: 12),
              _buildHorizontalList(recommendation),
              const SizedBox(height: 22),
            ],

            /// POPULAR
            if (popular.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _sectionTitle("Popular"),
              ),
              const SizedBox(height: 12),
              _buildHorizontalList(popular),
              const SizedBox(height: 22),
            ],

            /// TOP SELL
            if (topSell.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _sectionTitle("Top Sell"),
              ),
              const SizedBox(height: 12),
              _buildHorizontalList(topSell),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }

  /// ✅ SECTION TITLE WIDGET
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 19,
        color: Colors.black87,
      ),
    );
  }

  /// ✅ HORIZONTAL BOOK LIST
  Widget _buildHorizontalList(List<BookModel> booksList) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: booksList.length,
        itemBuilder: (context, index) {
          final book = booksList[index];

          return Padding(
            padding: EdgeInsets.only(right: index < booksList.length - 1 ? 14 : 0),
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
    );
  }
}