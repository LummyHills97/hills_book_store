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
  int _selectedIndex = 0;
  int _selectedCategoryIndex = 0;

  final List<String> _categories = [
    'All',
    'Fiction',
    'Mystery',
    'Romance',
    'Drama',
    'History',
    'Religion',
  ];

  final Map<String, IconData> categoryIcons = {
    'All': Icons.apps_rounded,
    'Fiction': Icons.auto_stories_rounded,
    'Mystery': Icons.search_rounded,
    'Romance': Icons.favorite_rounded,
    'Drama': Icons.theater_comedy_rounded,
    'History': Icons.menu_book_rounded,
    'Religion': Icons.church_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final selectedCategory = _categories[_selectedCategoryIndex];

    final filteredBooks = selectedCategory == 'All'
        ? books
        : books.where((b) => b.category == selectedCategory).toList();

    final recommendation = filteredBooks.take(3).toList();
    final popular = filteredBooks.skip(3).take(3).toList();
    final topSell = filteredBooks.skip(6).take(3).toList();

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
            const SizedBox(height: 10),
            
            /// CATEGORY FILTER
            SizedBox(
              height: 60,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedCategoryIndex;
                  final category = _categories[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedCategoryIndex = index);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green.shade900 : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: isSelected
                              ? Colors.green.shade900
                              : Colors.grey.shade300,
                          width: 1.4,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.green.shade900.withOpacity(0.19),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                )
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            categoryIcons[category],
                            size: 18,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            category,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

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

      /// ✅ BOTTOM NAV BAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
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