import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // master list of books (added cover9 and cover10)
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

  // categories shown as chips
  final List<String> _categories = ['Fiction', 'Education', 'Non-Fiction', 'Children'];

  // selected category chip index (for visual state)
  int _selectedCategoryIndex = 0;

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  void _selectCategory(int idx) => setState(() => _selectedCategoryIndex = idx);

  @override
  Widget build(BuildContext context) {
    // Build section lists from the master list (rearranged)
    final recommended = _books.take(3).toList(); // first 3 as recommendation
    final popular = _books.sublist(3, 6); // 4,5,6
    final topSell = _books.sublist(6, 8); // 7,8
    final toRead = _books.sublist(8); // 9,10

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
            icon: const Icon(Icons.notifications_none, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories chips row (Fiction, Education, Non-Fiction, Children)
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedCategoryIndex;
                  return ChoiceChip(
                    label: Text(_categories[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        )),
                    selected: isSelected,
                    onSelected: (_) => _selectCategory(index),
                    selectedColor: Colors.green.shade900,
                    backgroundColor: Colors.grey.shade200,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  );
                },
              ),
            ),

            const SizedBox(height: 18),

            // Recommendation - only 3 items
            _sectionTitle('Recommendation'),
            const SizedBox(height: 10),
            _horizontalList(recommended),

            const SizedBox(height: 20),
            // Popular
            _sectionTitle('Popular'),
            const SizedBox(height: 10),
            _horizontalList(popular),

            const SizedBox(height: 20),
            // Top Sell
            _sectionTitle('Top Sell'),
            const SizedBox(height: 10),
            _horizontalList(topSell),

            const SizedBox(height: 20),
            // To Read
            _sectionTitle('To Read'),
            const SizedBox(height: 10),
            _horizontalList(toRead),

            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _horizontalList(List<Map<String, String>> books) {
    return SizedBox(
      height: 240,
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
    );
  }

  Widget _bookCard(Map<String, String> book) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.14),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              book['image']!,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // fallback if an image is missing
                return Container(
                  height: 150,
                  color: Colors.grey.shade200,
                  child: const Center(child: Icon(Icons.image_not_supported)),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(book['author'] ?? '',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Text(book['price'] ?? '',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
