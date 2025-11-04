import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, String>> _books = [
    {'image': 'assets/images/covers/cover1.png', 'title': 'The Sixth Child', 'author': 'Manith J.', 'price': '\$15.00', 'category': 'Fiction'},
    {'image': 'assets/images/covers/cover2.png', 'title': 'The Book of God', 'author': 'Walter W.', 'price': '\$16.88', 'category': 'Religion'},
    {'image': 'assets/images/covers/cover3.png', 'title': 'The Khmer Kings', 'author': 'Kenneth T.', 'price': '\$43.35', 'category': 'History'},
    {'image': 'assets/images/covers/cover4.png', 'title': 'The Hobbit', 'author': 'J. R. R. Tolkien', 'price': '\$13.85', 'category': 'Fiction'},
    {'image': 'assets/images/covers/cover5.png', 'title': 'Harry Potter', 'author': 'J. K. Rowling', 'price': '\$29.39', 'category': 'Fiction'},
    {'image': 'assets/images/covers/cover6.png', 'title': 'The Lake House', 'author': 'Manith J.', 'price': '\$8.70', 'category': 'Romance'},
    {'image': 'assets/images/covers/cover7.png', 'title': 'Death Comes to Call', 'author': 'Clare Chase', 'price': '\$12.50', 'category': 'Mystery'},
    {'image': 'assets/images/covers/cover8.png', 'title': 'A History of Cambodia', 'author': 'David Chandler', 'price': '\$9.50', 'category': 'History'},
    {'image': 'assets/images/covers/cover9.png', 'title': 'The Power of Words', 'author': 'Samuel Cole', 'price': '\$11.20', 'category': 'Non-Fiction'},
    {'image': 'assets/images/covers/cover10.png', 'title': 'Learning Flutter', 'author': 'Dev Guru', 'price': '\$25.00', 'category': 'Education'},
  ];

  final List<String> _categories = ['Fiction', 'Education', 'Non-Fiction', 'Children'];
  int _selectedCategoryIndex = 0;

  void _selectCategory(int idx) => setState(() => _selectedCategoryIndex = idx);

  @override
  Widget build(BuildContext context) {
    final recommended = _books.take(3).toList();
    final popular = _books.sublist(3, 6);
    final topSell = _books.sublist(6, 8);
    final toRead = _books.sublist(8);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: const Text(
          'Hi, Olumide 👋',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Colors.black87), onPressed: () {}),
          IconButton(icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black87), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category chips
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedCategoryIndex;
                  return ChoiceChip(
                    label: Text(
                      _categories[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (_) => _selectCategory(index),
                    selectedColor: Colors.green.shade900,
                    backgroundColor: Colors.grey.shade200,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 14),
                  );
                },
              ),
            ),

            const SizedBox(height: 22),

            _section('Recommendation', recommended),
            _section('Popular', popular),
            _section('Top Sell', topSell),
            _section('To Read', toRead),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, List<Map<String, String>> books) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 10),
        SizedBox(
          height: 220, // reduced to fix overflow
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: books.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final book = books[index];
              return _bookCard(book);
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _bookCard(Map<String, String> book) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: AspectRatio(
              aspectRatio: 0.7, // keeps image height consistent
              child: Image.asset(
                book['image']!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported, color: Colors.grey),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book['title'] ?? '',
                    style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(book['author'] ?? '',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(book['price'] ?? '',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
