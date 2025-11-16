import 'package:flutter/material.dart';
import 'package:hills_book_store/features/book_list_page.dart';
import 'package:hills_book_store/features/onboarding/data/books_data.dart';
import 'package:hills_book_store/features/onboarding/widgets/book_card.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Explore",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 SEARCH BAR
            _buildSearchBar(),
            const SizedBox(height: 24),

            // 🟦 CATEGORY GRID
            _buildCategoriesSection(context),
            const SizedBox(height: 32),

            // 🔥 TRENDING BOOKS
            _buildHorizontalBookSection(
              title: "Trending Books",
              books: books.take(5).toList(),
            ),
            const SizedBox(height: 32),

            // 🆕 NEW RELEASES
            _buildHorizontalBookSection(
              title: "New Releases",
              books: books.reversed.take(5).toList(),
            ),
            const SizedBox(height: 32),

            // 📚 EXPLORE MORE
            _buildExploreMoreSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// 🔍 Search Bar Widget
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.grey.shade600),
          hintText: "Search books...",
          hintStyle: TextStyle(color: Colors.grey.shade500),
        ),
        onSubmitted: (value) {
          // Handle search logic here
          if (value.isNotEmpty) {
            // Navigate to search results or filter books
          }
        },
      ),
    );
  }

  /// 🟦 Categories Section
  Widget _buildCategoriesSection(BuildContext context) {
    final categories = [
      "Fiction",
      "Mystery",
      "Romance",
      "Drama",
      "History",
      "Religion",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Categories",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return _buildCategoryCard(context, categories[index]);
          },
        ),
      ],
    );
  }

  /// Category Card
  Widget _buildCategoryCard(BuildContext context, String categoryName) {
    return InkWell(
      onTap: () {
        // Filter books by category and convert to Map format
        final categoryBooks = books
            .where((book) => book.category == categoryName)
            .map((book) => {
                  'title': book.title,
                  'author': book.author,
                  'imagePath': book.imagePath,
                  'price': book.price,
                  'category': book.category,
                  'description': book.description,
                })
            .toList();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookListPage(
              category: categoryName,
              books: categoryBooks,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            categoryName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.3,
            ),
          ),
        ),
      ),
    );
  }

  /// 📚 Horizontal Book Section (Trending, New Releases)
  Widget _buildHorizontalBookSection({
    required String title,
    required List<dynamic> books,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 240,
          child: books.isEmpty
              ? Center(
                  child: Text(
                    "No books available",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                )
              : ListView.separated(
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
                          // Navigate to book details
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  /// 📖 Explore More Section (Grid)
  Widget _buildExploreMoreSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Explore More",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: books.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.68,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final book = books[index];
            return BookCard(
              title: book.title,
              author: book.author,
              imagePath: book.imagePath,
              price: book.price,
              onTap: () {
                // Navigate to book details
              },
            );
          },
        ),
      ],
    );
  }
}