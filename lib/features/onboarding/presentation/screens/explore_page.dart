import 'package:flutter/material.dart';
import 'package:hills_book_store/features/book_list_page.dart';
import 'package:hills_book_store/features/onboarding/data/books_data.dart';
import 'package:hills_book_store/features/onboarding/widgets/book_card.dart';
import 'package:hills_book_store/features/onboarding/presentation/screens/book_details_screen.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController _searchController = TextEditingController();
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory = _categories[_selectedCategoryIndex];

    final filteredBooks = selectedCategory == 'All'
        ? books
        : books.where((b) => b.category == selectedCategory).toList();

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
            const SizedBox(height: 20),

            // 🏷️ CATEGORY FILTER CHIPS
            SizedBox(
              height: 60,
              child: ListView.separated(
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

            const SizedBox(height: 24),

            // 📚 FILTERED BOOKS GRID
            Text(
              selectedCategory == 'All' ? 'All Books' : selectedCategory,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 14),
            filteredBooks.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        "No books in this category",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredBooks.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.68,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      final book = filteredBooks[index];
                      return BookCard(
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
                      );
                    },
                  ),
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
}